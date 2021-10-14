package com.popcap.flash.bejeweledblitz.dailyspin.app.purchase
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ButtonConfigBase;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.FBPurchaseButton;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ResizableButton;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.SlicedAssetManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.button.ToolTipButton;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PurchaseConfig
   {
       
      
      private const PURCHASE_SPIN_BUTTON_WIDTH:Number = 200;
      
      private const PURCHASE_SPIN_BUTTON_HEIGHT:Number = 52;
      
      private const FREE_SPIN_BUTTON_WIDTH:Number = 200;
      
      private const FREE_SPIN_BUTTON_HEIGHT:Number = 52;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_FreeSpinBtn:ToolTipButton;
      
      private var m_FBPurchasBtn:FBPurchaseButton;
      
      private var m_CreditSpinBtn:ToolTipButton;
      
      private var m_CurrentBtn:ResizableButton;
      
      private var m_StateHandlers:StateHandlerList;
      
      public function PurchaseConfig(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function handleSetConfigEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      public function getCurrentButton() : ResizableButton
      {
         return this.m_CurrentBtn;
      }
      
      private function setFreeSpin() : void
      {
         this.m_CurrentBtn = this.m_FreeSpinBtn;
      }
      
      private function setPurchaseSpin() : void
      {
         this.m_CurrentBtn = this.m_FBPurchasBtn;
      }
      
      private function setCreditSpin() : void
      {
         this.m_CurrentBtn = this.m_CreditSpinBtn;
      }
      
      private function init() : void
      {
         var fmt:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,null,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this.initFreeSpinButton(fmt);
         this.initPurchaseButton(fmt);
         this.initCreditSpinButton(fmt);
         this.initHandlers();
      }
      
      private function initFreeSpinButton(fmt:TextFormat) : void
      {
         var btnCfg:ButtonConfigBase = new ButtonConfigBase(this.m_DSMgr,SlicedAssetManager.BUTTON_TYPE_GREEN_SLICES,this.m_DSMgr.getLocString(DailySpinLoc.LOC_freeSpinBtn),DSEvent.DS_EVT_REQUEST_FREE_SPIN,fmt,null,this.FREE_SPIN_BUTTON_WIDTH,this.FREE_SPIN_BUTTON_HEIGHT);
         this.m_FreeSpinBtn = new ToolTipButton(this.m_DSMgr,btnCfg,this.m_DSMgr.getLocString(DailySpinLoc.LOC_centerSpinBtnTip));
      }
      
      private function initPurchaseButton(fmt:TextFormat) : void
      {
         var btnCfg:ButtonConfigBase = new ButtonConfigBase(this.m_DSMgr,SlicedAssetManager.BUTTON_TYPE_GREEN_SLICES,this.m_DSMgr.getLocString(DailySpinLoc.LOC_centerSpinBtn),DSEvent.DS_EVT_REQUEST_PURCHASE_SPIN,fmt,null,this.PURCHASE_SPIN_BUTTON_WIDTH,this.PURCHASE_SPIN_BUTTON_HEIGHT);
         this.m_FBPurchasBtn = new FBPurchaseButton(this.m_DSMgr,btnCfg);
      }
      
      private function initCreditSpinButton(fmt:TextFormat) : void
      {
         var btnCfg:ButtonConfigBase = new ButtonConfigBase(this.m_DSMgr,SlicedAssetManager.BUTTON_TYPE_GREEN_SLICES,this.m_DSMgr.getLocString(DailySpinLoc.LOC_centerSpinBtn),DSEvent.DS_EVT_REQUEST_CONSUME_CREDIT_SPIN,fmt,null,150,50);
         this.m_CreditSpinBtn = new ToolTipButton(this.m_DSMgr,btnCfg,this.m_DSMgr.getLocString(DailySpinLoc.LOC_centerSpinBtnTip));
      }
      
      private function initHandlers() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_CONFIG_FREE_SPIN,this.setFreeSpin));
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_CONFIG_PURCHASE_SPIN,this.setPurchaseSpin));
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_CONFIG_SPIN_CREDITS,this.setCreditSpin));
      }
   }
}
