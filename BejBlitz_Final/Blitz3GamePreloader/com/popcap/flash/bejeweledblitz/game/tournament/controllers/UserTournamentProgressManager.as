package com.popcap.flash.bejeweledblitz.game.tournament.controllers
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   
   public class UserTournamentProgressManager
   {
      
      public static const USER_TOURNAMENT_PROGRESS:String = "/facebook/bj2/getTournamentProgress.php";
      
      public static const TIMER_UPDATE_INTERVAL_MILLISECONDS:int = 1000;
      
      public static const USER_TOURNAMENT_ACTIVE_STATE:String = "active";
      
      public static const USER_TOURNAMENT_COMPUTING_STATE:String = "computingResults";
      
      public static const USER_TOURNAMENT_INACTIVE_STATE:String = "inactive";
      
      public static var firstTimeFetched:Boolean = false;
       
      
      private var _app:Blitz3Game;
      
      private var _refreshTimeDuration:uint;
      
      private var _lastFetchTime:Number;
      
      private var _refreshTimer:Timer;
      
      private var _onCompleted:Function;
      
      private var _userTournamentProgresses:Vector.<UserTournamentProgress>;
      
      private var _networkStatus:int;
      
      public function UserTournamentProgressManager(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._refreshTimeDuration = 0;
         this._userTournamentProgresses = null;
         this._lastFetchTime = 0;
         this._refreshTimer = null;
         this._onCompleted = null;
      }
      
      public function Init() : void
      {
         this._userTournamentProgresses = new Vector.<UserTournamentProgress>();
         this._refreshTimer = new Timer(TIMER_UPDATE_INTERVAL_MILLISECONDS,0);
         this.refreshTimeDuration = 300;
         this._refreshTimer.addEventListener(TimerEvent.TIMER,this.OnTimerTick);
         this._networkStatus = TournamentCommonInfo.NETWORK_ERROR_NONE;
      }
      
      public function clear() : void
      {
         var _loc1_:int = this._userTournamentProgresses.length - 1;
         while(_loc1_ >= 0)
         {
            delete this._userTournamentProgresses[_loc1_];
            _loc1_--;
         }
         this._userTournamentProgresses.splice(0,this._userTournamentProgresses.length);
      }
      
      public function setOnComplete(param1:Function) : void
      {
         this._onCompleted = param1;
      }
      
      public function FetchUserTournamentProgress() : void
      {
         var _loc1_:URLVariables = null;
         this._networkStatus = TournamentCommonInfo.NETWORK_ERROR_NONE;
         this._refreshTimer.start();
         _loc1_ = this._app.network.GetSecureVariables();
         UrlParameters.Get().InjectParams(_loc1_);
         var _loc2_:URLRequest = new URLRequest(Globals.labsPath + USER_TOURNAMENT_PROGRESS);
         _loc2_.method = URLRequestMethod.POST;
         _loc2_.data = _loc1_;
         var _loc3_:Date = new Date();
         this._lastFetchTime = _loc3_.getTime().valueOf() / 1000;
         var _loc4_:URLLoader;
         (_loc4_ = new URLLoader()).dataFormat = "VARIABLES";
         _loc4_.data = _loc1_;
         _loc4_.addEventListener(Event.COMPLETE,this.handleComplete,false,0,true);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.handleError,false,0,true);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleError,false,0,true);
         _loc4_.load(_loc2_);
      }
      
      private function handleError(param1:Event) : void
      {
         this._lastFetchTime = 0;
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         this._networkStatus = TournamentCommonInfo.NETWORK_ERROR_NO_INTERNET;
         firstTimeFetched = true;
         if(param1 is IOErrorEvent)
         {
            this._networkStatus = TournamentCommonInfo.NETWORK_ERROR_NO_INTERNET;
            Blitz3App.app.network.clearLastServerCallVariables();
            (Blitz3App.app as Blitz3Game).displayNetworkError(true);
            (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Progress_fetch_error","Tournament_lobby","");
            return;
         }
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: " + param1 + " on get user tournaments progress");
         if(this._onCompleted != null)
         {
            this._onCompleted(false);
         }
         (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Progress_fetch_error","Tournament_lobby","");
      }
      
      private function handleComplete(param1:Event) : void
      {
         var jsonObj:Object = null;
         var event:Event = param1;
         var loader:URLLoader = event.target as URLLoader;
         loader.removeEventListener(Event.COMPLETE,this.handleComplete);
         var data:String = loader.data;
         try
         {
            jsonObj = JSON.parse(data);
            if(jsonObj.result == "success")
            {
               this.parseJSON(jsonObj["tournaments"]);
               firstTimeFetched = true;
               if(this._onCompleted != null)
               {
                  this._onCompleted(true);
               }
               this._networkStatus = TournamentCommonInfo.NETWORK_ERROR_NONE;
            }
            else
            {
               firstTimeFetched = true;
               if(this._onCompleted != null)
               {
                  this._onCompleted(false);
               }
               this._networkStatus = TournamentCommonInfo.NETWORK_ERROR_SERVER_ERROR;
               (this._app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Progress_fetch_error","Tournament_lobby","");
            }
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Error parsing user tournament progress :  " + e.message);
            firstTimeFetched = true;
            if(_onCompleted != null)
            {
               _onCompleted(false);
            }
            (_app as Blitz3App).network.SendTournamentErrorMetrics("Tour_Progress_fetch_error","Tournament_lobby","");
            _networkStatus = TournamentCommonInfo.NETWORK_ERROR_NONE;
         }
      }
      
      public function parseJSON(param1:Array) : void
      {
         var _loc3_:UserTournamentProgress = null;
         this.clear();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new UserTournamentProgress();
            _loc3_.setInfo(param1[_loc2_]);
            this._userTournamentProgresses.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function set refreshTimeDuration(param1:uint) : void
      {
         this._refreshTimeDuration = param1;
      }
      
      public function get refreshTimeDuration() : uint
      {
         return this._refreshTimeDuration;
      }
      
      private function OnTimerTick(param1:TimerEvent) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = false;
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.getTime().valueOf() / 1000;
         if(this._networkStatus == TournamentCommonInfo.NETWORK_ERROR_NONE && (this._app as Blitz3App).sessionData.tournamentController.FetchStatus == TournamentCommonInfo.TOUR_CATALOGUE_FETCHED)
         {
            _loc4_ = this._lastFetchTime + this._refreshTimeDuration;
            _loc5_ = _loc3_ > _loc4_;
            if(!this._app.mainState.isCurrentStateGame() && _loc5_)
            {
               this.FetchUserTournamentProgress();
            }
         }
      }
      
      public function getUserProgress(param1:String) : UserTournamentProgress
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._userTournamentProgresses.length)
         {
            if(this._userTournamentProgresses[_loc2_].getTournamentId() == param1)
            {
               return this._userTournamentProgresses[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function hasUserJoinedTournament(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(this._userTournamentProgresses != null)
         {
            _loc3_ = 0;
            while(_loc3_ < this._userTournamentProgresses.length)
            {
               if(this._userTournamentProgresses[_loc3_].getTournamentId() == param1)
               {
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
   }
}
