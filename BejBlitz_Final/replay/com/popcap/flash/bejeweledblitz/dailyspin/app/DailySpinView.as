package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.MoveAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.BonusBar;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.UserButtonManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.controls.ToolTip;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.dialogs.ErrorDialog;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.dialogs.ProcessingDialog;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.dialogs.ShareDialog;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.prize.PrizeData;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.prize.PrizeManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.purchase.PurchaseConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic.SlotWidget;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.titlebar.TitleBar;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MathHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DailySpinView extends Sprite implements IDSEventHandler
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_SlotWidget:SlotWidget;
      
      private var m_ToolTip:ToolTip;
      
      private var m_WidgetContainer:Sprite;
      
      private var m_RollAnim:MoveAnim;
      
      private var m_StateHandlers:StateHandlerList;
      
      public function DailySpinView(app:Blitz3Game, dsMgr:DailySpinManager)
      {
         super();
         this.m_App = app;
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function handleDisplayRollIn() : void
      {
         this.m_RollAnim.init(this.m_WidgetContainer,new Point(0,5),45,MathHelpers.easeInOutCubic,this.handleRollInComplete);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_RollAnim);
         this.m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_1);
      }
      
      private function handleDisplayRollOut() : void
      {
         this.m_RollAnim.init(this.m_WidgetContainer,new Point(0,700),45,MathHelpers.easeInOutCubic,this.handleRollOutComplete);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_RollAnim);
         this.m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_1);
      }
      
      private function handleRollInComplete() : void
      {
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_RollAnim);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_IN_COMPLETE);
      }
      
      private function handleRollOutComplete() : void
      {
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_RollAnim);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_OUT_COMPLETE);
      }
      
      private function onMouseIn(e:MouseEvent) : void
      {
         this.m_ToolTip.updateMouseTarget(e);
      }
      
      private function handleCoinTallyComplete() : void
      {
         var prizeData:PrizeData = this.m_DSMgr.getPrizeData();
         if(prizeData)
         {
            if(prizeData.shouldShare)
            {
               this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DIALOG_SHARE_SHOW);
               this.addViewHandler(DSEvent.DS_EVT_DIALOG_SHARE_HIDE,this.showButtons);
               return;
            }
         }
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SHOW_BUTTONS);
      }
      
      private function showButtons() : void
      {
         this.removeViewHandler(DSEvent.DS_EVT_DIALOG_SHARE_HIDE);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SHOW_BUTTONS);
      }
      
      private function addViewHandler(event:DSEvent, callback:Function) : void
      {
         this.m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function removeViewHandler(event:DSEvent) : void
      {
         this.m_DSMgr.removeDSEventHandler(event,this);
         this.m_StateHandlers.removeHandlerForState(event);
      }
      
      private function init() : void
      {
         var bm:Bitmap = this.m_DSMgr.getBitmapAsset(Blitz3GameImages.IMAGE_MENU_BACKGROUND);
         addChild(bm);
         this.m_WidgetContainer = new Sprite();
         addChild(this.m_WidgetContainer);
         this.initPrizeItems();
         this.initSlots();
         this.initTitleBar();
         this.initBonusBar();
         this.initButtons();
         this.initDialogs();
         this.initToolTip();
         this.initHandlers();
         this.m_WidgetContainer.y = 700;
         this.m_RollAnim = new MoveAnim();
      }
      
      private function initToolTip() : void
      {
         this.m_ToolTip = new ToolTip(this.m_DSMgr);
         addChild(this.m_ToolTip);
      }
      
      private function initDialogs() : void
      {
         var shareDialog:ShareDialog = null;
         var dialogMask:Sprite = null;
         var pd:ProcessingDialog = new ProcessingDialog(this.m_DSMgr);
         LayoutHelpers.CenterXY(pd,Dimensions.GAME_WIDTH * 0.5 - 1,-500);
         addChild(pd);
         var errDiag:ErrorDialog = new ErrorDialog(this.m_DSMgr);
         LayoutHelpers.CenterXY(errDiag,Dimensions.GAME_WIDTH * 0.5 - 1,-500);
         addChild(errDiag);
         shareDialog = new ShareDialog(this.m_App,this.m_DSMgr);
         shareDialog.visible = true;
         LayoutHelpers.CenterXY(shareDialog,Dimensions.GAME_WIDTH * 0.5 - 1,-500);
         addChild(shareDialog);
         dialogMask = new Sprite();
         dialogMask.graphics.beginFill(16777215);
         dialogMask.graphics.drawRect(0,0,345,220);
         shareDialog.mask = dialogMask;
         LayoutHelpers.CenterXY(dialogMask,Dimensions.GAME_WIDTH * 0.5 - 1,215 + Dimensions.NAVIGATION_HEIGHT);
      }
      
      private function initBonusBar() : void
      {
         var bonusBar:BonusBar = new BonusBar(this.m_DSMgr);
         LayoutHelpers.Center(bonusBar,this,-2,155);
         this.m_WidgetContainer.addChild(bonusBar);
      }
      
      private function initSlots() : void
      {
         this.m_SlotWidget = new SlotWidget(this.m_DSMgr);
         this.m_WidgetContainer.addChild(this.m_SlotWidget);
         this.m_SlotWidget.x = 1;
         this.m_SlotWidget.y = 25;
      }
      
      private function initPrizeItems() : void
      {
         var prizeMgr:PrizeManager = new PrizeManager(this.m_DSMgr);
         this.m_WidgetContainer.addChild(prizeMgr);
      }
      
      private function initButtons() : void
      {
         var purchaseConfig:PurchaseConfig = new PurchaseConfig(this.m_DSMgr);
         this.m_WidgetContainer.addChild(new UserButtonManager(this.m_DSMgr,purchaseConfig));
      }
      
      private function initTitleBar() : void
      {
         var titleBar:TitleBar = new TitleBar(this.m_DSMgr);
         LayoutHelpers.CenterXY(titleBar,Dimensions.GAME_WIDTH * 0.5 - 4,57);
         this.m_WidgetContainer.addChild(titleBar);
      }
      
      private function initHandlers() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseIn);
         this.m_StateHandlers = new StateHandlerList();
         this.addViewHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_IN_START,this.handleDisplayRollIn);
         this.addViewHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_OUT_START,this.handleDisplayRollOut);
         this.addViewHandler(DSEvent.DS_EVT_USER_TOTAL_BALANCE_TALLY_COMPLETE,this.handleCoinTallyComplete);
      }
   }
}
