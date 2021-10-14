package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig.BonusBarFreeSpinConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig.BonusBarPurchaseSpinConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig.BonusBarSpinCreditConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig.IBonusBarConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.BonusBarPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.Rotator;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.RotatorPanelSequence;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BonusBar extends Sprite implements IDSEventHandler
   {
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_LeftRotator:Rotator;
      
      private var m_MiddleRotator:Rotator;
      
      private var m_RightRotator:Rotator;
      
      private var m_FreeSpinConfig:BonusBarFreeSpinConfig;
      
      private var m_SpinCreditConfig:BonusBarSpinCreditConfig;
      
      private var m_PurchaseSpinConfig:BonusBarPurchaseSpinConfig;
      
      private var m_CurrentBonusConfig:IBonusBarConfig;
      
      private var m_PreviousBonusConfig:IBonusBarConfig;
      
      public function BonusBar(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function handleFreeSpinConfig() : void
      {
         if(this.configIsCurrentlyDisplayed(this.m_FreeSpinConfig))
         {
            return;
         }
         this.removeConfig();
         if(!this.m_FreeSpinConfig)
         {
            this.m_FreeSpinConfig = new BonusBarFreeSpinConfig(this.m_DSMgr);
         }
         this.setConfig(this.m_FreeSpinConfig);
         this.addBonusBarHandler(DSEvent.DS_EVT_BONUS_FREE_SPIN_COMPLETE,this.handleFreeSpinComplete);
      }
      
      private function handleFreeSpinComplete() : void
      {
         this.removeBonusBarHandler(DSEvent.DS_EVT_BONUS_FREE_SPIN_COMPLETE);
         if(this.m_DSMgr.paramLoader.getMinimalMode())
         {
            this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT);
            return;
         }
         this.setNextConfiguration();
      }
      
      private function setNextConfiguration() : void
      {
         if(this.m_DSMgr.paramLoader.getSpinCredits() > 0)
         {
            this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_CONFIG_SPIN_CREDITS);
            this.handleSpinCreditConfig();
         }
         else
         {
            this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_CONFIG_PURCHASE_SPIN);
            this.handlePurchaseSpinConfig();
         }
      }
      
      private function handleSpinCreditConfig() : void
      {
         if(this.configIsCurrentlyDisplayed(this.m_SpinCreditConfig))
         {
            return;
         }
         this.removeConfig();
         if(!this.m_SpinCreditConfig)
         {
            this.m_SpinCreditConfig = new BonusBarSpinCreditConfig(this.m_DSMgr);
         }
         this.setConfig(this.m_SpinCreditConfig);
         this.addBonusBarHandler(DSEvent.DS_EVT_SPIN_CREDITS_CONSUMED,this.handleSpinCreditsConsumed);
      }
      
      private function handleSpinCreditsConsumed() : void
      {
         this.removeBonusBarHandler(DSEvent.DS_EVT_SPIN_CREDITS_CONSUMED);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_CONFIG_PURCHASE_SPIN);
         this.handlePurchaseSpinConfig();
      }
      
      private function handlePurchaseSpinConfig() : void
      {
         if(this.configIsCurrentlyDisplayed(this.m_PurchaseSpinConfig))
         {
            return;
         }
         this.removeConfig();
         if(!this.m_PurchaseSpinConfig)
         {
            this.m_PurchaseSpinConfig = new BonusBarPurchaseSpinConfig(this.m_DSMgr);
         }
         this.setConfig(this.m_PurchaseSpinConfig);
      }
      
      private function removeLeftRotatorPanels() : void
      {
         if(!this.m_PreviousBonusConfig)
         {
            return;
         }
         this.removePanels(this.m_LeftRotator,this.m_PreviousBonusConfig.getLeftRotatorSequence());
         this.removeBonusBarHandler(DSEvent.DS_EVT_BONUS_LEFT_ROTATOR_COMPLETE_SPIN);
      }
      
      private function removeMiddleRotatorPanels() : void
      {
         if(!this.m_PreviousBonusConfig)
         {
            return;
         }
         this.removePanels(this.m_MiddleRotator,this.m_PreviousBonusConfig.getMiddleRotatorSequence());
         this.removeBonusBarHandler(DSEvent.DS_EVT_BONUS_MIDDLE_ROTATOR_COMPLETE_SPIN);
      }
      
      private function removeRightRotatorPanels() : void
      {
         if(!this.m_PreviousBonusConfig)
         {
            return;
         }
         this.removePanels(this.m_RightRotator,this.m_PreviousBonusConfig.getRightRotatorSequence());
         this.removeBonusBarHandler(DSEvent.DS_EVT_BONUS_RIGHT_ROTATOR_COMPLETE_SPIN);
      }
      
      private function setConfig(config:IBonusBarConfig) : void
      {
         this.m_PreviousBonusConfig = this.m_CurrentBonusConfig;
         this.setRotatorSequence(this.m_LeftRotator,config.getLeftRotatorSequence());
         this.setRotatorSequence(this.m_MiddleRotator,config.getMiddleRotatorSequence());
         this.setRotatorSequence(this.m_RightRotator,config.getRightRotatorSequence());
         this.m_CurrentBonusConfig = config;
      }
      
      private function removeConfig() : void
      {
         this.addBonusBarHandler(DSEvent.DS_EVT_BONUS_LEFT_ROTATOR_COMPLETE_SPIN,this.removeLeftRotatorPanels);
         this.addBonusBarHandler(DSEvent.DS_EVT_BONUS_MIDDLE_ROTATOR_COMPLETE_SPIN,this.removeMiddleRotatorPanels);
         this.addBonusBarHandler(DSEvent.DS_EVT_BONUS_RIGHT_ROTATOR_COMPLETE_SPIN,this.removeRightRotatorPanels);
      }
      
      private function removePanels(rotator:Rotator, sequence:RotatorPanelSequence) : void
      {
         var panel:BonusBarPanel = null;
         var dsEventHandler:IDSEventHandler = null;
         for each(panel in sequence.getPanels())
         {
            dsEventHandler = panel as IDSEventHandler;
            if(dsEventHandler)
            {
               this.m_DSMgr.removeDSEventHandler(panel.getDisplayEvent(),dsEventHandler);
            }
            if(this.contains(panel))
            {
               removeChild(panel);
            }
         }
         rotator.removePanelEventHandlers();
      }
      
      private function setRotatorSequence(rotator:Rotator, sequence:RotatorPanelSequence) : void
      {
         var panel:BonusBarPanel = null;
         for each(panel in sequence.getPanels())
         {
            addChild(panel);
            panel.visible = false;
            this.centerPanelOnRotator(panel,rotator);
         }
         rotator.setSequence(sequence);
      }
      
      private function centerPanelOnRotator(panel:BonusBarPanel, rotator:Rotator) : void
      {
         LayoutHelpers.CenterXY(panel,rotator.layoutCenter.x,rotator.layoutCenter.y);
      }
      
      private function addBonusBarHandler(event:DSEvent, callback:Function) : void
      {
         this.m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function removeBonusBarHandler(event:DSEvent) : void
      {
         this.m_DSMgr.removeDSEventHandler(event,this);
         this.m_StateHandlers.removeHandlerForState(event);
      }
      
      private function configIsCurrentlyDisplayed(config:IBonusBarConfig) : Boolean
      {
         return this.m_CurrentBonusConfig == config && config;
      }
      
      private function init() : void
      {
         var bg:Bitmap = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_BONUS_BAR_BG);
         addChild(bg);
         this.initRotators();
         this.initHandlers();
      }
      
      private function initRotators() : void
      {
         this.m_MiddleRotator = new Rotator(this.m_DSMgr,new Point(this.width * 0.5,this.height * 0.5 + 2),DSEvent.DS_EVT_BONUS_MIDDLE_ROTATOR_COMPLETE_SPIN);
         addChild(this.m_MiddleRotator);
         this.m_LeftRotator = new Rotator(this.m_DSMgr,new Point(this.width * 0.5 - 121,this.height * 0.5 + 2),DSEvent.DS_EVT_BONUS_LEFT_ROTATOR_COMPLETE_SPIN);
         addChild(this.m_LeftRotator);
         this.m_RightRotator = new Rotator(this.m_DSMgr,new Point(this.width * 0.5 + 121,this.height * 0.5 + 2),DSEvent.DS_EVT_BONUS_RIGHT_ROTATOR_COMPLETE_SPIN);
         addChild(this.m_RightRotator);
      }
      
      private function initHandlers() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         this.addBonusBarHandler(DSEvent.DS_EVT_CONFIG_FREE_SPIN,this.handleFreeSpinConfig);
         this.addBonusBarHandler(DSEvent.DS_EVT_CONFIG_PURCHASE_SPIN,this.handlePurchaseSpinConfig);
         this.addBonusBarHandler(DSEvent.DS_EVT_CONFIG_SPIN_CREDITS,this.handleSpinCreditConfig);
      }
   }
}
