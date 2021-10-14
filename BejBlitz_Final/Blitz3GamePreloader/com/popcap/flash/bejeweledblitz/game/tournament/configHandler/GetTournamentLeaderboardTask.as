package com.popcap.flash.bejeweledblitz.game.tournament.configHandler
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentLeaderboardData;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class GetTournamentLeaderboardTask
   {
      
      public static const CONFIG_URL:String = "/facebook/bj2/getTournamentLeaderboard.php";
       
      
      private var _userId:String = "";
      
      private var _tournamentId:String = "";
      
      private var _onFinished:Function;
      
      public function GetTournamentLeaderboardTask()
      {
         super();
         this._userId = "";
         this._tournamentId = "";
         this._onFinished = null;
      }
      
      public function setOnFinished(param1:Function) : void
      {
         this._onFinished = param1;
      }
      
      public function fetchConfig(param1:String, param2:String) : void
      {
         this._userId = param1;
         this._tournamentId = param2;
         var _loc3_:URLRequest = new URLRequest(Globals.labsPath + CONFIG_URL);
         _loc3_.method = URLRequestMethod.POST;
         var _loc4_:URLVariables;
         (_loc4_ = Blitz3App.app.network.GetSecureVariables()).user_id = this._userId;
         _loc4_.tour_id = this._tournamentId;
         UrlParameters.Get().InjectParams(_loc4_);
         _loc3_.data = _loc4_;
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader()).addEventListener(Event.COMPLETE,this.handleComplete,false,0,true);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.handleError,false,0,true);
         _loc5_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleSecurityError,false,0,true);
         _loc5_.load(_loc3_);
      }
      
      private function handleComplete(param1:Event) : void
      {
         var jsonObj:Object = null;
         var leaderboard:TournamentLeaderboardData = null;
         var e:Event = param1;
         var loader:URLLoader = e.target as URLLoader;
         loader.removeEventListener(Event.COMPLETE,this.handleComplete);
         var data:String = loader.data;
         try
         {
            jsonObj = JSON.parse(data);
            if(jsonObj.result == "success")
            {
               leaderboard = Blitz3App.app.sessionData.tournamentController.LeaderboardController.getLeaderboard(this._tournamentId);
               leaderboard.SetInfo(jsonObj);
               if(this._onFinished != null)
               {
                  this._onFinished(true);
               }
            }
            else
            {
               if(this._onFinished != null)
               {
                  this._onFinished(false);
               }
               this.showErrorPopup();
               Blitz3App.app.network.SendTournamentErrorMetrics("Tour_LB_Fetch_Error","Tournament_lobby","");
            }
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to parse tournament leaderboard data: " + e.message);
            if(_onFinished != null)
            {
               _onFinished(false);
            }
            showErrorPopup();
            Blitz3App.app.network.SendTournamentErrorMetrics("Tour_LB_Fetch_Error","Tournament_lobby","");
         }
      }
      
      private function handleError(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         if(param1 is IOErrorEvent)
         {
            Blitz3App.app.network.clearLastServerCallVariables();
            (Blitz3App.app as Blitz3Game).displayNetworkError(true);
            Blitz3App.app.network.SendTournamentErrorMetrics("Tour_LB_Fetch_Error","Tournament_lobby","");
            return;
         }
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: " + param1 + " on get tournament leaderboard data");
         if(this._onFinished != null)
         {
            this._onFinished(false);
         }
         this.showErrorPopup();
         Blitz3App.app.network.SendTournamentErrorMetrics("Tour_LB_Fetch_Error","Tournament_lobby","");
      }
      
      private function handleSecurityError(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleSecurityError);
         if(param1 is IOErrorEvent)
         {
            Blitz3App.app.network.clearLastServerCallVariables();
            (Blitz3App.app as Blitz3Game).displayNetworkError(true);
            Blitz3App.app.network.SendTournamentErrorMetrics("Tour_LB_Fetch_Error","Tournament_lobby","");
            return;
         }
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Security: " + param1 + " on get tournament leaderboard data");
         if(this._onFinished != null)
         {
            this._onFinished(false);
         }
         this.showErrorPopup();
         Blitz3App.app.network.SendTournamentErrorMetrics("Tour_LB_Fetch_Error","Tournament_lobby","");
      }
      
      private function showErrorPopup() : void
      {
         Blitz3App.app.sessionData.tournamentController.ErrorMessageHandler.showErrorDialog("","An error occurred while loading the Leaderboard.");
      }
   }
}
