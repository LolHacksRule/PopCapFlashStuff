package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class DataUpdater
   {
      
      private static const _JS_GET_STATS:String = "getLeaderboardStats";
      
      public static const FV_PHP_PATH:String = "pathToPHP";
      
      public static const FV_BAISC_QUERY_STRING:String = "querystring";
      
      public static const URL_BASIC_XML:String = "leaderboard.php";
       
      
      private var _app:Blitz3Game;
      
      private var _leaderboard:LeaderboardWidget;
      
      private var _PHPPath:String = "";
      
      private var _basicQueryString:String = "";
      
      public function DataUpdater(param1:Blitz3Game, param2:LeaderboardWidget)
      {
         super();
         this._app = param1;
         this._leaderboard = param2;
         XML.ignoreWhitespace = true;
         var _loc3_:Object = this._app.network.parameters;
         if(FV_PHP_PATH in _loc3_)
         {
            this._PHPPath = _loc3_[FV_PHP_PATH];
         }
         if(FV_BAISC_QUERY_STRING in _loc3_)
         {
            this._basicQueryString = _loc3_[FV_BAISC_QUERY_STRING];
         }
      }
      
      public function RequestBasicXML() : void
      {
         var _loc9_:Array = null;
         var _loc1_:Array = this._basicQueryString.split("&");
         var _loc2_:URLVariables = new URLVariables();
         var _loc3_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc9_ = _loc1_[_loc4_].split("=");
            _loc2_[_loc9_[0]] = _loc9_[1];
            _loc4_++;
         }
         var _loc5_:Date = new Date();
         var _loc6_:String = "bs=" + _loc5_.getTime().toString();
         var _loc7_:URLRequest;
         (_loc7_ = new URLRequest(this._PHPPath + URL_BASIC_XML + "?" + _loc6_)).method = URLRequestMethod.POST;
         _loc7_.data = _loc2_;
         var _loc8_:URLLoader;
         (_loc8_ = new URLLoader(_loc7_)).addEventListener(Event.COMPLETE,this.HandleBasicComplete);
         _loc8_.addEventListener(IOErrorEvent.IO_ERROR,this.HandleBasicIOError);
         _loc8_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleBasicSecurityError);
      }
      
      public function RequestExtendedData(param1:String, param2:Boolean = false) : void
      {
         var _loc8_:PlayerData = null;
         if(this._app.network.isOffline)
         {
            return;
         }
         var _loc3_:Boolean = true;
         var _loc4_:PlayerData;
         if((_loc4_ = PlayersData.getPlayerData(this._leaderboard.currentPlayerFUID)) && _loc4_.IsExtendedDataLoaded())
         {
            _loc3_ = false;
         }
         var _loc5_:String = param1;
         if(_loc4_ && _loc5_ == _loc4_.playerFuid)
         {
            _loc5_ = "";
         }
         else if(!(_loc8_ = PlayersData.getPlayerData(_loc5_)) || _loc8_.IsExtendedDataLoaded())
         {
            _loc5_ = "";
         }
         if(!param2 && !_loc3_ && _loc5_ == "")
         {
            return;
         }
         var _loc6_:Date = new Date();
         var _loc7_:* = "fb_sig_user=" + this._leaderboard.currentPlayerFUID;
         if(_loc5_.length > 0)
         {
            _loc7_ += "&friend=" + _loc5_;
         }
         if(!_loc3_)
         {
            _loc7_ += "&sans_user=1";
         }
         _loc7_ += "&bs=" + _loc6_.getTime().toString();
         ServerIO.registerCallback(_JS_GET_STATS,this.onGetStats,param1);
         ServerIO.sendToServer(_JS_GET_STATS,{"userId":param1},{"fuid":param1});
      }
      
      private function onGetStats(param1:Object) : void
      {
         PlayersData.ParseExtendedJSON(param1);
      }
      
      public function UpdatePlayerScore(param1:int) : void
      {
         this._app.DisptachHandleScoreUpdated(param1);
         this.UpdateFriendscore();
      }
      
      private function UpdateFriendscore() : void
      {
      }
      
      protected function HandleBasicComplete(param1:Event) : void
      {
         var event:Event = param1;
         var xmlText:String = event.target.data;
         if(xmlText.indexOf("<?xml") != 0)
         {
            if(!this._app.network.isOffline)
            {
               this.DispatchBasicLoadError();
               return;
            }
            xmlText = "<?xml version=\"1.0\" encoding=\"utf-8\"?><leaderboard><friendscore>322300</friendscore><current_tourney><id>259</id><date_start>1317142800</date_start><date_end>1317747600</date_end></current_tourney><player><name>Walker Lindley</name><score>2500</score><pic_square>http://profile.ak.fbcdn.net/hprofile-ak-snc4/273473_17701854_497798292_q.jpg</pic_square><xp>274850</xp><id>17701854</id></player><player><name>Colin Bricken</name><score>40400</score><pic_square>http://profile.ak.fbcdn.net/hprofile-ak-ash2/195255_588278980_3263367_q.jpg</pic_square><xp>550300</xp><id>588278980</id></player><player><name>Jeremiah Grace</name><score>0</score><pic_square>http://profile.ak.fbcdn.net/hprofile-ak-snc4/211520_1277474947_4137881_q.jpg</pic_square><xp>0</xp><id>1277474947</id></player><player><name>Ayelet Goldin</name><score>0</score><pic_square>http://profile.ak.fbcdn.net/static-ak/rsrc.php/v1/y9/r/IB7NOFmPw2a.gif</pic_square><xp>0</xp><id>100001424873625</id></player><player><name>Jon Fleming</name><score>0</score><pic_square>http://profile.ak.fbcdn.net/hprofile-ak-snc4/23150_703969285_2443_q.jpg</pic_square><xp>0</xp><id>703969285</id></player><player><name>Bear Bear</name><score>0</score><pic_square>http://profile.ak.fbcdn.net/hprofile-ak-ash2/41777_524932343_213_q.jpg</pic_square><xp>0</xp><id>524932343</id></player><player><name>Jason Keimig</name><score>0</score><pic_square>http://profile.ak.fbcdn.net/hprofile-ak-ash2/49056_674656654_636_q.jpg</pic_square><xp>0</xp><id>674656654</id></player><player><name>Scott Lantz</name><score>0</score><pic_square>http://profile.ak.fbcdn.net/hprofile-ak-snc4/49861_1140934709_77_q.jpg</pic_square><xp>0</xp><id>1140934709</id></player><userinfo><name>Colin</name><gender>male</gender><appfriends>8</appfriends></userinfo><invitee/></leaderboard>";
         }
         if(xmlText.indexOf("<error>") > -1)
         {
            this.DispatchBasicLoadError();
            return;
         }
         try
         {
            PlayersData.ParseBasicXML(XML(xmlText));
            this._app.DispatchHandleBasicLoadComplete();
            this._app.DispatchUpdatePokeAndRivalStatus();
         }
         catch(error:Error)
         {
            DispatchBasicLoadError();
            return;
         }
         this.UpdateFriendscore();
      }
      
      protected function HandleBasicIOError(param1:IOErrorEvent) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"DataUpdater io error: " + param1.toString());
         this.DispatchBasicLoadError();
      }
      
      protected function HandleBasicSecurityError(param1:SecurityErrorEvent) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_SECURITY,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"DataUpdater security error: " + param1.toString());
         this.DispatchBasicLoadError();
      }
      
      protected function HandleExtendedIOError(param1:IOErrorEvent) : void
      {
         this.DispatchExtendedLoadError();
      }
      
      protected function HandleExtendedSecurityError(param1:SecurityErrorEvent) : void
      {
         this.DispatchExtendedLoadError();
      }
      
      private function DispatchBasicLoadError() : void
      {
         this._app.DispatchShowLeaderboardRefresh();
      }
      
      private function DispatchExtendedLoadError() : void
      {
         this._app.DispatchShowLeaderboardRefresh();
      }
   }
}
