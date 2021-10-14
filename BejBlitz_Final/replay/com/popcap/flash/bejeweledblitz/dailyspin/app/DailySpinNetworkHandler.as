package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.debug.DebugSpinConfigData;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   
   public class DailySpinNetworkHandler implements IDSEventHandler
   {
       
      
      private const CALL_BUY_SPIN:String = "buySpin";
      
      private const FREE_SPIN_JS_CALL:String = "consumeFreeSpin";
      
      private const SPINNING_JS_CALL:String = "clickedToSpin";
      
      private const CONSUME_SPIN_JS_CALL:String = "consumeBankedSpin";
      
      private const PURCHASE_SPIN_JS_CALL:String = "purchaseSpin";
      
      private const DAILY_SPIN_SHUT_DOWN:String = "dailySpinShutdown";
      
      private const GET_SWF_CONFIG_SPIN:String = "spin";
      
      private const DAILY_SPIN_AVAILABLE:String = "Spin.dailySpinAvailable";
      
      private const CALLBACK_BUY_SPIN:String = "buySpinCallback";
      
      private const CALLBACK_ERROR_MESSAGE:String = "errorMsgCallback";
      
      private const CALLBACK_PROCESSING_CANCELED:String = "cancelProcess";
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_SpinValue:Number;
      
      private var m_Prize:String;
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_App:Blitz3Game;
      
      private var m_UsedFreeSpin:Boolean;
      
      public function DailySpinNetworkHandler(app:Blitz3Game, dsMgr:DailySpinManager)
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
      
      public function getAppInitializeConfig() : Object
      {
         if(this.m_App.network.isOffline)
         {
            return DebugSpinConfigData.createDSInitData();
         }
         return this.m_App.network.ExternalCall(Blitz3Network.GET_SWF_CONFIG,this.GET_SWF_CONFIG_SPIN);
      }
      
      public function isDailySpinAvailable() : Boolean
      {
         return this.m_App.network.ExternalCall(this.DAILY_SPIN_AVAILABLE) as Boolean;
      }
      
      public function doSilentFreeSpin() : void
      {
         this.handleRequestFreeSpin(true);
      }
      
      private function buySpinCallback(spinData:Object) : void
      {
         this.m_DSMgr.paramLoader.addParams(spinData);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DIALOG_PROCESSING_HIDE);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SPIN_SLOTS);
      }
      
      private function errorMsgCallback() : void
      {
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DIALOG_ERROR_SHOW);
      }
      
      private function cancelProcess() : void
      {
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DIALOG_PROCESSING_HIDE);
      }
      
      private function handleRequestFreeSpin(silent:Boolean = false) : void
      {
         this.handleSpinRequest(this.m_DSMgr.paramLoader.getStringParam(this.FREE_SPIN_JS_CALL),silent);
      }
      
      private function handleRequestCreditSpin() : void
      {
         this.handleSpinRequest(this.m_DSMgr.paramLoader.getStringParam(this.CONSUME_SPIN_JS_CALL));
      }
      
      private function handleRequestPurchaseSpin() : void
      {
         this.handleSpinRequest(this.m_DSMgr.paramLoader.getStringParam(this.PURCHASE_SPIN_JS_CALL));
      }
      
      private function handleShutdown() : void
      {
         this.m_App.network.ExternalCall(this.m_DSMgr.paramLoader.getStringParam(this.DAILY_SPIN_SHUT_DOWN));
         this.m_App.dailyspin.Hide();
      }
      
      private function handleSpinComplete() : void
      {
         this.m_App.sessionData.userData.AddCoins(this.m_DSMgr.paramLoader.getIntParam("spinAmount"));
      }
      
      private function handleSpinRequest(jsCall:String, silent:Boolean = false) : void
      {
         if(this.m_App.network.isOffline)
         {
            this.buySpinCallback(DebugSpinConfigData.createPurchasedSpinData());
            return;
         }
         var cbs:Object = {
            "buySpinCallback":this.CALLBACK_BUY_SPIN,
            "errorMsgCallback":this.CALLBACK_ERROR_MESSAGE,
            "cancelProcessing":this.CALLBACK_PROCESSING_CANCELED
         };
         this.m_App.network.ExternalCall(jsCall,cbs);
         if(!silent)
         {
            this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DIALOG_PROCESSING_SHOW);
         }
      }
      
      private function addNetworkHandler(event:DSEvent, callback:Function) : void
      {
         this.m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function removeNetworkHandler(event:DSEvent) : void
      {
         this.m_DSMgr.removeDSEventHandler(event,this);
         this.m_StateHandlers.removeHandlerForState(event);
      }
      
      private function init() : void
      {
         this.initJSCallbacks();
         this.initHandlers();
         this.m_UsedFreeSpin = false;
      }
      
      private function initJSCallbacks() : void
      {
         this.m_App.network.AddExternalCallback(this.CALLBACK_BUY_SPIN,this.buySpinCallback);
         this.m_App.network.AddExternalCallback(this.CALLBACK_ERROR_MESSAGE,this.errorMsgCallback);
         this.m_App.network.AddExternalCallback(this.CALLBACK_PROCESSING_CANCELED,this.cancelProcess);
      }
      
      private function initHandlers() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         this.addNetworkHandler(DSEvent.DS_EVT_REQUEST_FREE_SPIN,this.handleRequestFreeSpin);
         this.addNetworkHandler(DSEvent.DS_EVT_REQUEST_CONSUME_CREDIT_SPIN,this.handleRequestCreditSpin);
         this.addNetworkHandler(DSEvent.DS_EVT_REQUEST_PURCHASE_SPIN,this.handleRequestPurchaseSpin);
         this.addNetworkHandler(DSEvent.DS_EVT_SHUT_DOWN_DAILY_SPIN,this.handleShutdown);
         this.addNetworkHandler(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN,this.handleSpinComplete);
      }
   }
}
