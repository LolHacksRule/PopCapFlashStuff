package com.popcap.flash.bejeweledblitz.dailyspin.app.dialogs
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ButtonConfigBase;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.SlicedAssetManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ToolTipButton;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MathHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Bitmap;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flashx.textLayout.formats.TextAlign;
   
   public class ShareDialog extends BaseDialog
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_TextBody:TextField;
      
      public function ShareDialog(app:Blitz3Game, dsMgr:DailySpinManager)
      {
         this.m_App = app;
         super(dsMgr);
         this.init();
      }
      
      private function show() : void
      {
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_KILL_TOOL_TIP);
         m_DisplayAnim.init(this,m_OnScreenPosition,DISPLAY_ANIM_FRAME_SPAN,MathHelpers.easeInOutSine,this.onDisplayAnimComplete);
         var msg:String = m_DSMgr.getLocString(DailySpinLoc.LOC_shareMysteryDialogInfo);
         var bonusAmout:int = m_DSMgr.paramLoader.getShareAmount();
         msg = msg.replace("$bonus_amount",StringUtils.InsertNumberCommas(bonusAmout));
         this.m_TextBody.htmlText = msg;
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
         m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
      }
      
      private function hide() : void
      {
         m_DisplayAnim.init(this,m_OffScreenPosition,DISPLAY_ANIM_FRAME_SPAN,MathHelpers.easeInOutSine,this.onDisplayAnimComplete);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_KILL_TOOL_TIP);
         m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DIALOG_SHARE_HIDE);
      }
      
      private function shareAccept() : void
      {
         var shareJSFunc:String = m_DSMgr.paramLoader.getStringParam("shareSpin");
         var shareVal:int = m_DSMgr.getPrizeData().shareAmount;
         this.m_App.network.ExternalCall(shareJSFunc,shareVal);
         this.hide();
      }
      
      private function onDisplayAnimComplete() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,m_DisplayAnim);
      }
      
      private function init() : void
      {
         var bg:Bitmap = null;
         bg = m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_SHARE_DIALOG_BACKGROUND);
         addChild(bg);
         this.initText();
         this.initButtons();
         this.initHandlers();
         this.visible = false;
         m_OffScreenPosition = new Point(0.5 * (Dimensions.GAME_WIDTH - bg.width) - 1,-500);
         m_OnScreenPosition = new Point(m_OffScreenPosition.x,0.5 * (Dimensions.GAME_HEIGHT - bg.height) + 8);
      }
      
      private function initText() : void
      {
         var headerFilters:Array = [new DropShadowFilter(2,90,0,1,0,0,1),new BevelFilter(1,90,16777215,1,0,1,1,1)];
         var textFilters:Array = [new DropShadowFilter(1,90)];
         var textFmt:TextFormat = new TextFormat();
         textFmt.bold = true;
         textFmt.align = TextAlign.CENTER;
         textFmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         var header:TextField = MiscHelpers.createTextField(m_DSMgr.getLocString(DailySpinLoc.LOC_shareDialogTitle),textFmt,headerFilters);
         LayoutHelpers.Center(header,this,0,-50);
         addChild(header);
         var msg:String = m_DSMgr.getLocString(DailySpinLoc.LOC_shareMysteryDialogInfo);
         var bonusAmout:int = m_DSMgr.paramLoader.getShareAmount();
         msg = msg.replace("$bonus_amount",StringUtils.InsertNumberCommas(bonusAmout));
         this.m_TextBody = MiscHelpers.createTextField(msg,textFmt,textFilters);
         LayoutHelpers.Center(this.m_TextBody,this);
         addChild(this.m_TextBody);
      }
      
      private function initButtons() : void
      {
         var textFmt:TextFormat = new TextFormat();
         textFmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         textFmt.bold = true;
         var shareBtnCfg:ButtonConfigBase = new ButtonConfigBase(m_DSMgr,SlicedAssetManager.BUTTON_TYPE_GREEN_SLICES,m_DSMgr.getLocString(DailySpinLoc.LOC_shareDialogAccept),DSEvent.DS_EVT_DIALOG_SHARE_ACCEPT,textFmt,null,120,40);
         var shareBtn:ToolTipButton = new ToolTipButton(m_DSMgr,shareBtnCfg,m_DSMgr.getLocString(DailySpinLoc.LOC_shareDialogAcceptTip));
         addChild(shareBtn);
         LayoutHelpers.Center(shareBtn,this,-70,52);
         var cancelBtnCfg:ButtonConfigBase = new ButtonConfigBase(m_DSMgr,SlicedAssetManager.BUTTON_TYPE_BLACK_SLICES,m_DSMgr.getLocString(DailySpinLoc.LOC_shareDialogDecline),DSEvent.DS_EVT_DIALOG_SHARE_CANCEL,textFmt,null,120,40);
         var cancelBtn:ToolTipButton = new ToolTipButton(m_DSMgr,cancelBtnCfg,m_DSMgr.getLocString(DailySpinLoc.LOC_shareDialogDeclineTip));
         addChild(cancelBtn);
         LayoutHelpers.Center(cancelBtn,this,70,52);
      }
      
      private function initHandlers() : void
      {
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_DIALOG_SHARE_SHOW,this);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_DIALOG_SHARE_ACCEPT,this);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_DIALOG_SHARE_CANCEL,this);
         m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DIALOG_SHARE_SHOW,this.show));
         m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DIALOG_SHARE_ACCEPT,this.shareAccept));
         m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DIALOG_SHARE_CANCEL,this.hide));
      }
   }
}
