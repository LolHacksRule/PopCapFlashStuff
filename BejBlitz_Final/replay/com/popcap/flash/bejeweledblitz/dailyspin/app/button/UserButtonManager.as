package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.ScaleAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.purchase.PurchaseConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import flash.display.Sprite;
   
   public class UserButtonManager extends Sprite implements IDSEventHandler
   {
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_PurchaseConfig:PurchaseConfig;
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_ExitButton:ExitDailySpinButton;
      
      private var m_ExitButtonAnim:ScaleAnim;
      
      private var m_CurrentPurchaseBtn:ResizableButton;
      
      private var m_PurchaseButtonAnim:ScaleAnim;
      
      public function UserButtonManager(dsMgr:DailySpinManager, purchaseConfig:PurchaseConfig)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_PurchaseConfig = purchaseConfig;
         this.init();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_PurchaseConfig.handleSetConfigEvent(event);
         this.m_StateHandlers.handleState(event);
      }
      
      private function handleConfigChange() : void
      {
         this.layout();
         this.m_CurrentPurchaseBtn.visible = false;
         this.m_ExitButton.visible = false;
      }
      
      private function hide() : void
      {
         this.m_CurrentPurchaseBtn.visible = false;
         this.m_PurchaseButtonAnim.x = this.m_CurrentPurchaseBtn.x + this.m_CurrentPurchaseBtn.width * 0.5;
         this.m_PurchaseButtonAnim.y = this.m_CurrentPurchaseBtn.y + this.m_CurrentPurchaseBtn.height * 0.5;
         this.m_PurchaseButtonAnim.init(this.m_CurrentPurchaseBtn,1,0,0.25,this.handlePurchaseAnimHideComplete);
         addChild(this.m_PurchaseButtonAnim);
         this.m_ExitButton.visible = false;
         this.m_ExitButtonAnim.x = this.m_ExitButton.x + this.m_ExitButton.width * 0.5;
         this.m_ExitButtonAnim.y = this.m_ExitButton.y + this.m_ExitButton.height * 0.5;
         this.m_ExitButtonAnim.init(this.m_ExitButton,1,0,0.25,this.handleExitButtonAnimHideComplete);
         addChild(this.m_ExitButtonAnim);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_PurchaseButtonAnim);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_ExitButtonAnim);
      }
      
      public function show() : void
      {
         LayoutHelpers.Center(this.m_PurchaseButtonAnim,this.m_CurrentPurchaseBtn);
         this.m_PurchaseButtonAnim.init(this.m_CurrentPurchaseBtn,0,1,0.25,this.handlePurchaseAnimShowComplete);
         addChild(this.m_PurchaseButtonAnim);
         LayoutHelpers.Center(this.m_ExitButtonAnim,this.m_ExitButton);
         this.m_ExitButtonAnim.init(this.m_ExitButton,0,1,0.25,this.handleExitButtonAnimShowComplete);
         addChild(this.m_ExitButtonAnim);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_PurchaseButtonAnim);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_ExitButtonAnim);
      }
      
      private function handlePurchaseAnimShowComplete() : void
      {
         this.m_CurrentPurchaseBtn.visible = true;
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_PurchaseButtonAnim);
         this.removeChild(this.m_PurchaseButtonAnim);
      }
      
      private function handlePurchaseAnimHideComplete() : void
      {
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_PurchaseButtonAnim);
         this.removeChild(this.m_PurchaseButtonAnim);
      }
      
      private function handleExitButtonAnimHideComplete() : void
      {
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_ExitButtonAnim);
         this.removeChild(this.m_ExitButtonAnim);
      }
      
      private function handleExitButtonAnimShowComplete() : void
      {
         this.m_ExitButton.visible = true;
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_ExitButtonAnim);
         this.removeChild(this.m_ExitButtonAnim);
      }
      
      private function layout() : void
      {
         if(this.m_CurrentPurchaseBtn)
         {
            if(this.contains(this.m_CurrentPurchaseBtn))
            {
               this.removeChild(this.m_CurrentPurchaseBtn);
            }
         }
         this.m_CurrentPurchaseBtn = this.m_PurchaseConfig.getCurrentButton();
         addChild(this.m_CurrentPurchaseBtn);
         LayoutHelpers.Center(this.m_ExitButton,this.m_CurrentPurchaseBtn,0,this.m_CurrentPurchaseBtn.height);
         LayoutHelpers.CenterXY(this,Dimensions.GAME_WIDTH * 0.5,Dimensions.GAME_HEIGHT * 0.5);
      }
      
      private function addUserButtonHandler(event:DSEvent, callback:Function) : void
      {
         this.m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function init() : void
      {
         this.m_ExitButtonAnim = new ScaleAnim();
         this.m_PurchaseButtonAnim = new ScaleAnim();
         this.m_ExitButton = new ExitDailySpinButton(this.m_DSMgr);
         addChild(this.m_ExitButton);
         this.m_StateHandlers = new StateHandlerList();
         this.addUserButtonHandler(DSEvent.DS_EVT_CONFIG_FREE_SPIN,this.handleConfigChange);
         this.addUserButtonHandler(DSEvent.DS_EVT_CONFIG_PURCHASE_SPIN,this.handleConfigChange);
         this.addUserButtonHandler(DSEvent.DS_EVT_CONFIG_SPIN_CREDITS,this.handleConfigChange);
         this.addUserButtonHandler(DSEvent.DS_EVT_SLOTS_START,this.hide);
         this.addUserButtonHandler(DSEvent.DS_EVT_SHOW_BUTTONS,this.show);
         this.addUserButtonHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_IN_COMPLETE,this.show);
         this.addUserButtonHandler(DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT,this.hide);
      }
   }
}
