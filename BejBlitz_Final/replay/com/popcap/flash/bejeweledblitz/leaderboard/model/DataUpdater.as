package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class DataUpdater
   {
      
      public static const FV_PHP_PATH:String = "pathToPHP";
      
      public static const FV_BAISC_QUERY_STRING:String = "querystring";
      
      public static const URL_BASIC_XML:String = "leaderboard.php";
      
      public static const URL_EXTENDED_XML:String = "scrapbook.php";
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_PHPPath:String = "";
      
      protected var m_BasicQueryString:String = "";
      
      protected var m_Handlers:Vector.<IDataUpdaterHandler>;
      
      public function DataUpdater(app:Blitz3Game, leaderboard:LeaderboardWidget, params:Object)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         XML.ignoreWhitespace = true;
         this.m_Handlers = new Vector.<IDataUpdaterHandler>();
         if(FV_PHP_PATH in params)
         {
            this.m_PHPPath = params[FV_PHP_PATH];
         }
         if(FV_BAISC_QUERY_STRING in params)
         {
            this.m_BasicQueryString = params[FV_BAISC_QUERY_STRING];
         }
      }
      
      public function RequestBasicXML() : void
      {
         var now:Date = new Date();
         var queryString:String = this.m_BasicQueryString + "&bs=" + now.getTime().toString();
         this.DispatchBasicLoadBegin();
         var loader:URLLoader = new URLLoader(new URLRequest(this.m_PHPPath + URL_BASIC_XML + "?" + queryString));
         loader.addEventListener(Event.COMPLETE,this.HandleBasicComplete);
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.HandleBasicIOError);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleBasicSecurityError);
      }
      
      public function RequestExtendedXML(fuid:String) : void
      {
         var friendData:PlayerData = null;
         var needOwnInfo:Boolean = true;
         var data:PlayerData = this.m_Leaderboard.highScoreList.GetPlayerData(this.m_Leaderboard.curPlayerFUID);
         if(data && data.IsExtendedDataLoaded())
         {
            needOwnInfo = false;
         }
         var secondFUID:String = fuid;
         if(secondFUID == data.fuid)
         {
            secondFUID = "";
         }
         else
         {
            friendData = this.m_Leaderboard.highScoreList.GetPlayerData(secondFUID);
            if(!friendData || friendData.IsExtendedDataLoaded())
            {
               secondFUID = "";
            }
         }
         if(!needOwnInfo && secondFUID == "")
         {
            return;
         }
         var now:Date = new Date();
         var queryString:String = "fb_sig_user=" + this.m_Leaderboard.curPlayerFUID;
         if(secondFUID.length > 0)
         {
            queryString += "&friend=" + secondFUID;
         }
         if(!needOwnInfo)
         {
            queryString += "&sans_user=1";
         }
         queryString += "&bs=" + now.getTime().toString();
         this.DispatchExtendedLoadBegin(secondFUID,this.m_Leaderboard.curPlayerFUID);
         var url:String = this.m_PHPPath + URL_EXTENDED_XML + "?" + queryString;
         var loader:ExtendedXMLLoader = new ExtendedXMLLoader(new URLRequest(url),this.m_Leaderboard.curPlayerFUID,secondFUID);
         loader.addEventListener(Event.COMPLETE,this.HandleExtendedComplete);
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.HandleExtendedIOError);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleExtendedSecurityError);
      }
      
      public function AddHandler(handler:IDataUpdaterHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function UpdatePlayerScore(score:int) : void
      {
         this.m_Leaderboard.highScoreList.UpdateScore(this.m_Leaderboard.curPlayerFUID,score);
         this.DispatchScoreUpdated(score);
         this.UpdateFriendscore();
      }
      
      private function DispatchBasicLoadBegin() : void
      {
         var handler:IDataUpdaterHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBasicLoadBegin();
         }
      }
      
      private function DispatchBasicLoadComplete() : void
      {
         var handler:IDataUpdaterHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBasicLoadComplete();
         }
      }
      
      private function DispatchBasicLoadError() : void
      {
         var handler:IDataUpdaterHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBasicLoadError();
         }
      }
      
      private function DispatchExtendedLoadBegin(fuid1:String, fuid2:String) : void
      {
         var handler:IDataUpdaterHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleExtendedLoadBegin(fuid1,fuid2);
         }
      }
      
      private function DispatchExtendedLoadComplete(fuid1:String, fuid2:String) : void
      {
         var handler:IDataUpdaterHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleExtendedLoadComplete(fuid1,fuid2);
         }
      }
      
      private function DispatchExtendedLoadError() : void
      {
         var handler:IDataUpdaterHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleExtendedLoadError();
         }
      }
      
      private function DispatchScoreUpdated(newScore:int) : void
      {
         var handler:IDataUpdaterHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleScoreUpdated(newScore);
         }
      }
      
      private function UpdateFriendscore() : void
      {
         this.m_App.friendscore.pageInterface.SetGroupScore(this.m_Leaderboard.highScoreList.GetFriendscore());
      }
      
      protected function HandleBasicComplete(event:Event) : void
      {
         var xmlRoot:XML = null;
         var xmlText:String = event.target.data;
         if(xmlText.indexOf("<?xml") != 0)
         {
            trace("Leaderboard XML not available");
            this.DispatchBasicLoadError();
            return;
         }
         if(xmlText.indexOf("<error>") > -1)
         {
            if(xmlText.indexOf("Facebook API error: 102") > -1)
            {
               trace("Leaderboard XML Facebook API Error: " + xmlText);
            }
            this.DispatchBasicLoadError();
            return;
         }
         try
         {
            xmlRoot = XML(xmlText);
            this.m_Leaderboard.highScoreList.ParseBasicXML(xmlRoot);
            this.DispatchBasicLoadComplete();
         }
         catch(error:Error)
         {
            trace("Leaderboard XML Error: " + error.getStackTrace());
            DispatchBasicLoadError();
            return;
         }
         this.UpdateFriendscore();
      }
      
      protected function HandleBasicIOError(event:IOErrorEvent) : void
      {
         this.DispatchBasicLoadError();
      }
      
      protected function HandleBasicSecurityError(event:SecurityErrorEvent) : void
      {
         this.DispatchBasicLoadError();
      }
      
      protected function HandleExtendedComplete(event:Event) : void
      {
         var xmlRoot:XML = null;
         var xmlText:String = event.target.data;
         if(xmlText.indexOf("<error>") > -1 && xmlText.indexOf("<?xml") == 0)
         {
            if(xmlText.indexOf("Facebook API error: 102") > -1)
            {
               trace("HandleExtendedComplete: facebook error on extended load: " + xmlText);
            }
            this.DispatchExtendedLoadError();
            return;
         }
         try
         {
            xmlRoot = XML(xmlText);
            this.m_Leaderboard.highScoreList.ParseExtendedXML(xmlRoot,event.target.friendFUID);
            this.DispatchExtendedLoadComplete(event.target.fuid,event.target.friendFUID);
         }
         catch(error:Error)
         {
            trace("HandleExtendedComplete: " + error.getStackTrace());
            DispatchExtendedLoadError();
            return;
         }
      }
      
      protected function HandleExtendedIOError(event:IOErrorEvent) : void
      {
         trace("IO error on extended load:\n" + event.target.data);
         this.DispatchExtendedLoadError();
      }
      
      protected function HandleExtendedSecurityError(event:SecurityErrorEvent) : void
      {
         trace("security error on extended load:\n" + event.target.data);
         this.DispatchExtendedLoadError();
      }
   }
}
