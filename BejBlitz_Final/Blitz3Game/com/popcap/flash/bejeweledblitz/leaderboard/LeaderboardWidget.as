package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class LeaderboardWidget extends MovieClip
   {
      
      public static const _MAX_ENTRIES:int = 50;
      
      public static const _SECONDS_PER_MINUTE:Number = 60;
      
      public static const _SECONDS_PER_HOUR:Number = _SECONDS_PER_MINUTE * 60;
      
      public static const _SECONDS_PER_DAY:Number = _SECONDS_PER_HOUR * 24;
      
      public static const _SECONDS_PER_WEEK:Number = _SECONDS_PER_DAY * 7;
      
      private static const _GET_MESSAGE_STORE_CONFIG:String = "getMessageStoreConfig";
      
      private static const SEND_LEADERBOARD_TRACKING_DATA:String = "sendLeaderboardTrackingData";
       
      
      public var currentPlayerFUID:String = "";
      
      public var updater:DataUpdater;
      
      public var pageInterface:PageInterface;
      
      protected var _app:Blitz3Game;
      
      protected var _isLoaded:Boolean = false;
      
      protected var _imageLoader:Loader;
      
      protected var _image:Bitmap;
      
      protected var _boxContainer:MovieClip;
      
      protected var _currentPlayerHighScore:int = 0;
      
      protected var _stats:LeaderboardStats;
      
      protected var _initialized:Boolean = false;
      
      protected var _friendData:Array;
      
      public var pokeLimit:uint = 1;
      
      public var flagLimit:uint = 1;
      
      public var pokeHandler:PokeHandler;
      
      public var rivalHandler:RivalHandler;
      
      protected var tournamentRemainingTimeInSeconds:Number;
      
      public function LeaderboardWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._imageLoader = new Loader();
         this._imageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleImageLoadComplete);
         this._imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleImageLoadError);
         this._imageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleImageLoadError);
         this._image = new Bitmap();
         this._image.smoothing = true;
         this._image.scaleX = 35 / 50;
         this._image.scaleY = 35 / 50;
         this.fetchRemainingTournamentTime();
      }
      
      protected function fetchRemainingTournamentTime() : void
      {
         var _loc1_:Object = this._app.network.ExternalCall(Blitz3Network.GET_SWF_CONFIG,"friendscore");
         if(_loc1_)
         {
            this.tournamentRemainingTimeInSeconds = _loc1_["endDate"] - new Date().getTime() * 0.001;
         }
      }
      
      public function getLeaderBoardEntry(param1:PlayerData) : LeaderboardListBox
      {
         return null;
      }
      
      public function GetMessageStoreConfig() : void
      {
         var result:Object = null;
         var messagesConfigs:Object = null;
         var messagesConfigsLength:int = 0;
         var i:int = 0;
         try
         {
            result = this._app.network.ExternalCall(_GET_MESSAGE_STORE_CONFIG);
            messagesConfigs = result.config.messagesConfigs;
            messagesConfigsLength = messagesConfigs.length;
            i = 0;
            while(i < messagesConfigsLength)
            {
               switch(messagesConfigs[i].type)
               {
                  case "poke":
                     this.pokeLimit = messagesConfigs[i].limit as int;
                     break;
                  case "rival":
                     this.flagLimit = messagesConfigs[i].limit as int;
                     break;
               }
               i++;
            }
         }
         catch(e:Error)
         {
            pokeLimit = 1;
            flagLimit = 1;
         }
      }
      
      public function showStats(param1:PlayerData, param2:Boolean = false, param3:Number = -1) : void
      {
         Utils.log(this,"showStats pForceLoad is: " + param2);
         this._stats.showMe(param1,param2,param3);
      }
      
      public function TryPoke(param1:LeaderboardListBox) : void
      {
         if(this.pokeHandler.IsPokeInProgress(param1) || param1.playerData.pokeCountFromCurrentUser >= this.pokeLimit)
         {
            this.OnPokeFailed(null);
            return;
         }
         this._app.network.registerPoke(param1.playerData,param1.isIngameList);
      }
      
      public function TryFlag(param1:LeaderboardListBox) : void
      {
         if(this.rivalHandler.IsFlagInProgress(param1))
         {
            this.OnFlagRivalFailed(null);
            return;
         }
         this._app.network.registerFlagStatus(param1.playerData,param1.isIngameList);
      }
      
      public function OnPokeSucceeded(param1:Event) : void
      {
         var jsonObj:Object = null;
         var resultSucceeded:Boolean = false;
         var pokeCount:int = 0;
         var e:Event = param1;
         try
         {
            jsonObj = JSON.parse(e.target.data);
            resultSucceeded = jsonObj.result == "success" ? true : false;
            if(resultSucceeded)
            {
               pokeCount = jsonObj.PokeCount;
               this.UpdatePokeCount(pokeCount);
               this.SendTrackingEvent("Poke","Poke Sent",-1,this.pokeHandler.playerEntry.playerData.pokeCountFromCurrentUser,this.GetCurrentRivalCount(),this.pokeHandler.playerEntry.playerData);
               this.pokeHandler.OnPokeProcessCompleted();
            }
            else
            {
               this.OnPokeFailed(null);
            }
         }
         catch(e:Error)
         {
            OnPokeFailed(null);
         }
      }
      
      public function OnPokeFailed(param1:Event) : void
      {
         this.SendTrackingEvent("Poke","Button Clicked",-1,this.pokeHandler.playerEntry.playerData.pokeCountFromCurrentUser,this.GetCurrentRivalCount(),this.pokeHandler.playerEntry.playerData);
         this.pokeHandler.OnPokeProcessCompleted();
      }
      
      public function OnFlagRivalSucceeded(param1:Event) : void
      {
         var jsonObj:Object = null;
         var resultSucceeded:Boolean = false;
         var flagStatus:int = 0;
         var e:Event = param1;
         try
         {
            jsonObj = JSON.parse(e.target.data);
            resultSucceeded = jsonObj.result == "success" ? true : false;
            if(resultSucceeded)
            {
               flagStatus = jsonObj.isFlagged;
               this.rivalHandler.OnFlagStatusUpdated(flagStatus);
               this.updatePokeAndRivalStatusForAllPlayers();
               this.SendTrackingEvent("Flag","Flag Tagged",-1,this.rivalHandler.playerEntry.playerData.pokeCountFromCurrentUser,this.GetCurrentRivalCount(),this.rivalHandler.playerEntry.playerData);
               this.rivalHandler.OnFlagProcessCompleted();
            }
            else
            {
               this.OnFlagRivalFailed(null);
            }
         }
         catch(e:Error)
         {
            OnFlagRivalFailed(null);
         }
      }
      
      public function updatePokeAndRivalStatusForAllPlayers() : void
      {
      }
      
      public function OnFlagRivalFailed(param1:Event) : void
      {
         this.SendTrackingEvent("Flag","Button Clicked",-1,this.rivalHandler.playerEntry.playerData.pokeCountFromCurrentUser,this.GetCurrentRivalCount(),this.rivalHandler.playerEntry.playerData);
         this.rivalHandler.OnFlagProcessCompleted();
      }
      
      public function GetCurrentRivalCount() : int
      {
         return 0;
      }
      
      private function UpdatePokeCount(param1:int) : void
      {
         this.pokeHandler.OnPokeResultUpdated(param1);
      }
      
      public function isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function getCurrentPlayerData() : PlayerData
      {
         return PlayersData.getPlayerData(this.currentPlayerFUID);
      }
      
      public function handleInviteData(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1 != null && "pic_square" in param1)
         {
            _loc2_ = param1["pic_square"];
            this._imageLoader.load(new URLRequest(_loc2_),new LoaderContext(true));
         }
      }
      
      protected function handleImageLoadComplete(param1:Event) : void
      {
         var tmpImg:Bitmap = null;
         var event:Event = param1;
         try
         {
            tmpImg = this._imageLoader.content as Bitmap;
         }
         catch(e:Error)
         {
            return;
         }
         if(!tmpImg)
         {
            return;
         }
         this._image.bitmapData = tmpImg.bitmapData;
         this._image.smoothing = true;
         this._image.scaleX = 0.8;
         this._image.scaleY = 0.8;
      }
      
      protected function handleImageLoadError(param1:Event) : void
      {
      }
      
      public function SendTrackingEvent(param1:String, param2:String, param3:int = -1, param4:int = -1, param5:int = -1, param6:PlayerData = null) : void
      {
         this._app.network.ExternalCall(SEND_LEADERBOARD_TRACKING_DATA,{
            "ClientVersion":Version.version,
            "SNSUserID":this.currentPlayerFUID,
            "SessionID":this._app.network.getSessionID(),
            "Source":param1,
            "Subtype":param2,
            "Messages":(this._app.ui as MainWidgetGame).menu.leftPanel.getNotificationCount(),
            "FriendsInvited":(param3 == -1 ? null : param3),
            "PokesReceived":(param4 == -1 ? null : param4),
            "FlagTag":(param5 == -1 ? null : param5),
            "LBPosition":this.getCurrentPlayerData().rank,
            "Recipient":(param6 != null ? param6.playerFuid : null)
         });
      }
   }
}
