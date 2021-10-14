package com.popcap.flash.bejeweledblitz.game.tournament.configHandler
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentDataManager;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class GetAllTournamentsTask
   {
      
      public static const CONFIG_URL:String = "/facebook/bj2/getAllTournaments.php";
       
      
      private var onFinished:Function;
      
      public function GetAllTournamentsTask()
      {
         super();
         this.onFinished = null;
      }
      
      public function setOnFinished(param1:Function) : void
      {
         this.onFinished = param1;
      }
      
      public function fetchConfig() : void
      {
         var _loc1_:URLRequest = new URLRequest(Globals.labsPath + CONFIG_URL);
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:URLVariables = Blitz3App.app.network.GetSecureVariables();
         UrlParameters.Get().InjectParams(_loc2_);
         _loc1_.data = _loc2_;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener(Event.COMPLETE,this.handleComplete,false,0,true);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.handleError,false,0,true);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleSecurityError,false,0,true);
         _loc3_.load(_loc1_);
      }
      
      private function handleComplete(param1:Event) : void
      {
         var jsonObj:Object = null;
         var dataManager:TournamentDataManager = null;
         var e:Event = param1;
         var loader:URLLoader = e.target as URLLoader;
         loader.removeEventListener(Event.COMPLETE,this.handleComplete);
         var data:String = loader.data;
         try
         {
            jsonObj = JSON.parse(data);
            if(jsonObj.result == "success")
            {
               dataManager = Blitz3App.app.sessionData.tournamentController.DataManager;
               dataManager.parseJSON(jsonObj);
               if(this.onFinished != null)
               {
                  this.onFinished(true);
               }
               this.onFinished = null;
               Blitz3App.app.sessionData.tournamentController.FetchStatus = TournamentCommonInfo.TOUR_CATALOGUE_FETCHED;
               Blitz3App.app.sessionData.tournamentController.NetworkStatus = TournamentCommonInfo.NETWORK_ERROR_NONE;
            }
            else
            {
               if(this.onFinished != null)
               {
                  this.onFinished(false);
               }
               this.onFinished = null;
               this.showErrorPopup();
               Blitz3App.app.network.SendTournamentErrorMetrics("Tour_Catalog_fetch_error","Tournament_lobby","");
               Blitz3App.app.sessionData.tournamentController.NetworkStatus = TournamentCommonInfo.NETWORK_ERROR_SERVER_ERROR;
            }
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to parse all tournaments: " + e.message);
            if(onFinished != null)
            {
               onFinished(false);
            }
            onFinished = null;
            showErrorPopup();
            Blitz3App.app.network.SendTournamentErrorMetrics("Tour_Catalog_fetch_error","Tournament_lobby","");
            Blitz3App.app.sessionData.tournamentController.NetworkStatus = TournamentCommonInfo.NETWORK_ERROR_NONE;
         }
      }
      
      private function handleError(param1:ErrorEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         if(param1 is IOErrorEvent)
         {
            Blitz3App.app.sessionData.tournamentController.NetworkStatus = TournamentCommonInfo.NETWORK_ERROR_NO_INTERNET;
            Blitz3App.app.network.clearLastServerCallVariables();
            (Blitz3App.app as Blitz3Game).displayNetworkError(true);
            Blitz3App.app.network.SendTournamentErrorMetrics("Tour_Catalog_fetch_error","Tournament_lobby","");
            return;
         }
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: error on get get all tournaments data");
         if(this.onFinished != null)
         {
            this.onFinished(false);
         }
         this.onFinished = null;
         this.showErrorPopup();
         Blitz3App.app.network.SendTournamentErrorMetrics("Tour_Catalog_fetch_error","Tournament_lobby","");
      }
      
      private function handleSecurityError(param1:ErrorEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleSecurityError);
         Blitz3App.app.sessionData.tournamentController.NetworkStatus = TournamentCommonInfo.NETWORK_ERROR_SECURITY_ERROR;
         if(param1 is IOErrorEvent)
         {
            Blitz3App.app.network.clearLastServerCallVariables();
            (Blitz3App.app as Blitz3Game).displayNetworkError(true);
            Blitz3App.app.network.SendTournamentErrorMetrics("Tour_Catalog_fetch_error","Tournament_lobby","");
            return;
         }
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Security:error on get all tournaments data");
         if(this.onFinished != null)
         {
            this.onFinished(false);
         }
         this.onFinished = null;
         this.showErrorPopup();
         Blitz3App.app.network.SendTournamentErrorMetrics("Tour_Catalog_fetch_error","Tournament_lobby","");
      }
      
      private function showErrorPopup() : void
      {
         Blitz3App.app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","An error occurred while loading Contests.");
      }
   }
}
