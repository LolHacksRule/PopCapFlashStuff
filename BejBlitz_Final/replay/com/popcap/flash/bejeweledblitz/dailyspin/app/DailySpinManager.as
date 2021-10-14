package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.DailySpinWidget;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.config.DSParamLoader;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEventDispatcher;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.prize.PrizeData;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic.SlotConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic.SlotLoader;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.framework.resources.sounds.SoundResource;
   import flash.display.Bitmap;
   
   public class DailySpinManager implements IDSEventHandler
   {
       
      
      private const PRIZE_KEY:String = "spin";
      
      public var m_App:Blitz3Game;
      
      private var m_Spin:DailySpinWidget;
      
      private var m_DSView:DailySpinView;
      
      private var m_EventDispatcher:DSEventDispatcher;
      
      private var m_ParamLoader:DSParamLoader;
      
      private var m_NetworkHandler:DailySpinNetworkHandler;
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_SlotLoader:SlotLoader;
      
      private var m_IsLoaded:Boolean;
      
      public function DailySpinManager(app:Blitz3Game, spin:DailySpinWidget)
      {
         super();
         this.m_App = app;
         this.m_Spin = spin;
         this.m_IsLoaded = false;
         this.init();
      }
      
      public function get paramLoader() : DSParamLoader
      {
         return this.m_ParamLoader;
      }
      
      public function get networkHandler() : DailySpinNetworkHandler
      {
         return this.m_NetworkHandler;
      }
      
      public function get isLoaded() : Boolean
      {
         return this.m_IsLoaded;
      }
      
      private function init() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         this.m_EventDispatcher = new DSEventDispatcher();
         this.m_NetworkHandler = new DailySpinNetworkHandler(this.m_App,this);
         this.m_ParamLoader = new DSParamLoader(this.m_NetworkHandler.getAppInitializeConfig());
         var slotCfg:SlotConfig = this.m_ParamLoader.getSlotConfig();
         this.m_SlotLoader = new SlotLoader(this,slotCfg.getConfigObj());
         this.addDSEventHandler(DSEvent.DS_EVT_SLOT_LOADER_COMPLETE,this);
         this.addDSEventHandler(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN,this);
         this.addDSEventHandler(DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT,this);
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_SLOT_LOADER_COMPLETE,this.onSlotLoaderComplete));
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN,this.onSpinComplete));
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT,this.onStartDisplayRollout));
      }
      
      public function display() : void
      {
         this.m_ParamLoader.loadData(this.m_NetworkHandler.getAppInitializeConfig());
         trace("----------------------------------------------------------------");
         this.m_ParamLoader.dumpParams();
         trace("----------------------------------------------------------------");
         this.dispatchEvent(this.getDisplayConfig());
         this.dispatchEvent(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_IN_START);
      }
      
      public function update() : void
      {
         this.m_EventDispatcher.update();
      }
      
      public function addDSEventHandler(event:DSEvent, handler:IDSEventHandler) : void
      {
         this.m_EventDispatcher.addHandler(event,handler);
      }
      
      public function removeDSEventHandler(event:DSEvent, handler:IDSEventHandler) : void
      {
         this.m_EventDispatcher.removeHandler(event,handler);
      }
      
      public function killEventHandler(handler:IDSEventHandler) : void
      {
         this.m_EventDispatcher.killHandler(handler);
      }
      
      public function dispatchEvent(event:DSEvent) : void
      {
         this.m_EventDispatcher.dispatchEvent(event);
      }
      
      public function getLocString(locId:String) : String
      {
         return this.m_App.TextManager.GetLocString(locId);
      }
      
      public function getBitmapAsset(imageId:String) : Bitmap
      {
         return new Bitmap(this.m_App.ImageManager.getBitmapData(imageId));
      }
      
      public function playSound(id:String, numPlays:int = 1) : void
      {
         this.m_App.SoundManager.playSound(id,numPlays);
      }
      
      public function getSoundResource(id:String) : SoundResource
      {
         return this.m_App.SoundManager.getSoundResource(id);
      }
      
      public function getPrizeId() : String
      {
         return this.m_ParamLoader.getStringParam(this.PRIZE_KEY);
      }
      
      public function getPrizeData() : PrizeData
      {
         return this.m_ParamLoader.getSlotConfig().getPrizeData(this.getPrizeId());
      }
      
      public function getSlotLoader() : SlotLoader
      {
         return this.m_SlotLoader;
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function onSpinComplete() : void
      {
         this.m_ParamLoader.markForReload();
         this.m_App.sessionData.userData.SetCoins(this.m_ParamLoader.getIntParam("coinBalance"));
         this.m_App.network.HandleBuyCoins(true);
      }
      
      private function onShutdownDailySpin() : void
      {
         this.dispatchEvent(DSEvent.DS_EVT_SHUT_DOWN_DAILY_SPIN);
      }
      
      private function getDisplayConfig() : DSEvent
      {
         if(this.networkHandler.isDailySpinAvailable())
         {
            return DSEvent.DS_EVT_CONFIG_FREE_SPIN;
         }
         if(this.paramLoader.getSpinCredits() > 0)
         {
            return DSEvent.DS_EVT_CONFIG_SPIN_CREDITS;
         }
         return DSEvent.DS_EVT_CONFIG_PURCHASE_SPIN;
      }
      
      private function onSlotLoaderComplete() : void
      {
         this.removeDSEventHandler(DSEvent.DS_EVT_SLOT_LOADER_COMPLETE,this);
         this.m_StateHandlers.removeHandlerForState(DSEvent.DS_EVT_SLOT_LOADER_COMPLETE);
         this.m_DSView = new DailySpinView(this.m_App,this);
         this.m_Spin.addChild(this.m_DSView);
         this.addDSEventHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_OUT_COMPLETE,this);
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_OUT_COMPLETE,this.onShutdownDailySpin));
         this.m_IsLoaded = true;
         if(this.getDisplayConfig() == DSEvent.DS_EVT_CONFIG_FREE_SPIN)
         {
            this.m_Spin.Show(true);
         }
      }
      
      private function onStartDisplayRollout() : void
      {
         if(this.networkHandler.isDailySpinAvailable())
         {
            this.m_ParamLoader.markForReload();
            this.m_ParamLoader.addParams({"isDailySpin":false});
         }
      }
   }
}
