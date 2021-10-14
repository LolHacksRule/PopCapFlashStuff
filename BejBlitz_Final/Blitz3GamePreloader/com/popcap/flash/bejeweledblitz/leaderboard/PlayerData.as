package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.replay.ReplayAssetDependency;
   import com.popcap.flash.framework.App;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.text.TextField;
   
   public class PlayerData
   {
      
      public static const NUM_MEDALS:int = 19;
      
      public static const NUM_TOURNEYS:int = 5;
      
      public static const LEVEL_STEP:int = 250000;
      
      public static const MAX_LEVEL:int = 182;
      
      public static const MAX_NAME_LENGTH:int = 18;
       
      
      public var playerFuid:String = "0";
      
      public var playerName:String = "";
      
      public var imageUrl:String;
      
      public var isFakePlayer:Boolean = false;
      
      public var rank:int;
      
      public var level:int;
      
      public var levelName:String;
      
      public var xp:Number;
      
      public var newCatPresses:Number = 0;
      
      public var totalCatPresses:Number = 0;
      
      public var prevLevelCutoff:Number;
      
      public var nextLevelCutoff:Number;
      
      public var curTourneyData:TourneyData;
      
      public var tourneyHistory:Vector.<TourneyData>;
      
      public var medalHistory:Vector.<MedalData>;
      
      public var allTimeHighScore:Number = 0;
      
      public var highNonBoostedScore:Number = 0;
      
      public var maxRareGemScore:Number = 0;
      
      public var perfectPartiesWon:Number = 0;
      
      public var maxLastFiveWeeksScore:Number = 0;
      
      private var _app:App;
      
      private var _imageLoader:Loader;
      
      private var _profileImage:BitmapData;
      
      private var _isExtendedDataLoaded:Boolean = false;
      
      private var _textDataConsumers:Vector.<TextField>;
      
      private var _bitmapDataConsumers:Vector.<Bitmap>;
      
      private var _isExtendedDataError:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var _imageRetryLoad:Boolean = true;
      
      private var _imageRedirectLoad:Boolean = true;
      
      public var pokeCountFromCurrentUser:int = 0;
      
      public var isFlaggedByCurrentUser:Boolean = false;
      
      public var rareGemUsedForHighScore:String;
      
      public var boostsUsedForHighScore:Object;
      
      public var mReplayAssetDependency:ReplayAssetDependency;
      
      public var currentChampionshipData:BlitzChampionshipData;
      
      public function PlayerData(param1:App, param2:String = "", param3:String = "", param4:String = "", param5:BitmapData = null)
      {
         super();
         this._app = param1;
         this.playerFuid = param2;
         this.playerName = param3;
         this.imageUrl = param4;
         this._bitmapDataConsumers = new Vector.<Bitmap>();
         this._textDataConsumers = new Vector.<TextField>();
         this._imageLoader = new Loader();
         this._imageLoader = new Loader();
         this._imageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleProfileImageComplete);
         this._imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleProfileImageIOError);
         this._imageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleProfileImageSecurityError);
         this.curTourneyData = new TourneyData();
         this.tourneyHistory = new Vector.<TourneyData>();
         this.medalHistory = new Vector.<MedalData>(NUM_MEDALS);
         var _loc6_:int = 0;
         while(_loc6_ < this.medalHistory.length)
         {
            this.medalHistory[_loc6_] = new MedalData();
            _loc6_++;
         }
         if(param5 != null)
         {
            this._isLoaded = true;
            this._profileImage = param5.clone();
         }
         else if(param4 != "")
         {
         }
         this.boostsUsedForHighScore = new Object();
         this.mReplayAssetDependency = new ReplayAssetDependency();
         this.currentChampionshipData = new BlitzChampionshipData();
      }
      
      public function getPlayerName(param1:Boolean = false) : String
      {
         return !!param1 ? Utils.getFirstString(this.playerName) : this.playerName;
      }
      
      public function setLoading() : void
      {
         this._isExtendedDataLoaded = false;
         this._isExtendedDataError = false;
      }
      
      public function isCurrentPlayer() : Boolean
      {
         return this.playerFuid == (this._app as Blitz3Game).mainmenuLeaderboard.currentPlayerFUID;
      }
      
      public function parseBasicXML(param1:XML, param2:int) : void
      {
         var _loc10_:Object = null;
         this.playerFuid = param1.id.text().toString();
         this.playerName = param1.name.text().toString();
         this.imageUrl = param1.pic_square.text().toString();
         this.isFlaggedByCurrentUser = param1.isFlaggedAsRival.text() == "true" ? true : false;
         this.pokeCountFromCurrentUser = param1.pokeCount.text().toString();
         this.curTourneyData.date = new Date();
         this.curTourneyData.score = Number(param1.score.text().toString());
         this.curTourneyData.id = param2;
         this.xp = Number(param1.xp.text().toString());
         this.xp = Math.max(this.xp,0);
         this.recalcLevel();
         this.rareGemUsedForHighScore = param1.rareGemUsed.text();
         var _loc3_:Array = param1.boostsUsed.text().toString().split(",");
         var _loc4_:int = -1;
         var _loc5_:String = "";
         var _loc6_:int = 0;
         var _loc7_:int = _loc3_.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_ = 0;
            _loc5_ = "";
            if((_loc4_ = _loc3_[_loc8_].indexOf("!")) != -1)
            {
               _loc5_ = _loc3_[_loc8_].slice(0,_loc4_);
               _loc6_ = _loc6_ = _loc3_[_loc8_].slice(_loc4_ + 1,_loc3_[_loc8_].length);
            }
            if(_loc5_ != "")
            {
               this.boostsUsedForHighScore[_loc5_] = _loc6_;
            }
            _loc8_++;
         }
         var _loc9_:String;
         if((_loc9_ = param1.replay_data.text()).length > 0)
         {
            _loc10_ = JSON.parse(_loc9_);
            (this._app as Blitz3Game).sessionData.replayManager.LoadAssetDependencyFromJSONData(_loc10_,this.mReplayAssetDependency);
         }
      }
      
      public function parseTournamentJSON(param1:Object, param2:String) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         this.playerFuid = Utils.getStringFromObjectKey(param1,"user_id");
         this.playerName = Utils.getStringFromObjectKey(param1,"name");
         this.imageUrl = Utils.getStringFromObjectKey(param1,"pic");
         this.currentChampionshipData.date = new Date();
         this.currentChampionshipData.score = Utils.getIntFromObjectKey(param1,"player_score");
         this.currentChampionshipData.secondary_score = Utils.getIntFromObjectKey(param1,"secondary_score");
         this.currentChampionshipData.id = param2;
         var _loc3_:Array = Utils.getArrayFromObjectKey(param1,"boostsUsedV2");
         if(_loc3_ != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = Utils.getStringFromObjectKey(_loc3_[_loc5_],"name");
               _loc7_ = Utils.getIntFromObjectKey(_loc3_[_loc5_],"level");
               this.currentChampionshipData.boostsUsedForHighScore[_loc6_] = _loc7_;
               _loc5_++;
            }
         }
         this.currentChampionshipData.rareGemUsedForHighScore = Utils.getStringFromObjectKey(param1,"rareGemUsed");
         var _loc4_:Object;
         if((_loc4_ = param1["replay_data"]) != null)
         {
            (this._app as Blitz3Game).sessionData.replayManager.LoadAssetDependencyFromJSONData(_loc4_,this.mReplayAssetDependency);
         }
      }
      
      public function catPress() : void
      {
         ++this.newCatPresses;
         if(this.totalCatPresses + 1 >= Number.MAX_VALUE || this.totalCatPresses < 0)
         {
            this.totalCatPresses = 0;
         }
         ++this.totalCatPresses;
      }
      
      public function submitNewCatPresses() : void
      {
         if(this.isCurrentPlayer() && this.newCatPresses > 0)
         {
            ServerIO.sendToServer("addMeows",{"count":this.newCatPresses});
            this.newCatPresses = 0;
         }
      }
      
      public function parseExtendedJSON(param1:Object, param2:Boolean = true) : Boolean
      {
         var _loc4_:int = 0;
         var _loc7_:TourneyData = null;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc10_:MedalData = null;
         var _loc11_:String = null;
         var _loc12_:Object = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:String = null;
         var _loc16_:Number = NaN;
         var _loc17_:* = null;
         var _loc18_:Array = null;
         this._isExtendedDataLoaded = false;
         if(param2 == false)
         {
            this._isExtendedDataError = true;
            this._isExtendedDataLoaded = true;
            return false;
         }
         var _loc3_:Boolean = false;
         if(param1.misc != null && param1.misc.xp != null)
         {
            this.xp = Math.floor(param1.misc.xp);
            this.xp = Math.max(this.xp,0);
            this.recalcLevel();
         }
         if(param1.misc != null && param1.misc.meows != null)
         {
            this.totalCatPresses = Math.floor(param1.misc.meows);
            this.totalCatPresses = Math.max(0,this.totalCatPresses + this.newCatPresses);
         }
         if(param1.achievements != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.achievements.length)
            {
               _loc8_ = param1.achievements[_loc4_];
               _loc9_ = int(_loc8_.id);
               (_loc10_ = new MedalData()).count = int(_loc8_.user_data);
               _loc10_.name = _loc8_.name;
               if(_loc8_.modified_date != null)
               {
                  _loc11_ = (_loc11_ = _loc8_.modified_date).replace("-","/");
                  _loc10_.earnedDate.setTime(Date.parse(_loc11_));
               }
               _loc10_.CalculateTier();
               this.medalHistory[_loc9_ - 1] = _loc10_;
               _loc4_++;
            }
         }
         var _loc5_:int = this.curTourneyData.id - 1;
         var _loc6_:int;
         _loc4_ = _loc6_ = this.curTourneyData.id - (NUM_TOURNEYS - 1);
         while(_loc4_ <= _loc5_)
         {
            (_loc7_ = new TourneyData()).id = _loc4_;
            _loc7_.score = 0;
            _loc7_.date = new Date();
            this.tourneyHistory.push(_loc7_);
            _loc4_++;
         }
         this.tourneyHistory.push(this.curTourneyData);
         if(param1.scores != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.scores.length)
            {
               _loc12_ = param1.scores[_loc4_];
               if((_loc13_ = int(_loc12_.id)) > this.curTourneyData.id)
               {
                  _loc3_ = true;
               }
               if(!(_loc13_ < _loc6_ || _loc13_ > _loc5_ || _loc13_ == this.curTourneyData.id))
               {
                  _loc7_ = null;
                  _loc14_ = 0;
                  while(_loc14_ < this.tourneyHistory.length)
                  {
                     if(this.tourneyHistory[_loc14_].id == _loc13_)
                     {
                        _loc7_ = this.tourneyHistory[_loc14_];
                        break;
                     }
                     _loc14_++;
                  }
                  if(_loc7_)
                  {
                     _loc7_.score = int(_loc12_.score);
                     _loc15_ = (_loc15_ = String(_loc12_.score_date)).replace("-","/");
                     _loc7_.date.setTime(Date.parse(_loc15_));
                  }
               }
               _loc4_++;
            }
         }
         if(param1.highScores != null)
         {
            this.allTimeHighScore = Utils.getIntFromObject(param1.highScores.overall);
            this.highNonBoostedScore = Utils.getIntFromObject(param1.highScores.unboosted);
            if(this.highNonBoostedScore > this.allTimeHighScore)
            {
               this.allTimeHighScore = this.highNonBoostedScore;
            }
            this.maxRareGemScore = 0;
            _loc16_ = 0;
            for(_loc17_ in param1.highScores)
            {
               if(_loc17_ != "overall" && _loc17_ != "unboosted" && _loc17_ != "boosted")
               {
                  if(param1.highScores[_loc17_] != null)
                  {
                     if((_loc16_ = param1.highScores[_loc17_]) > this.maxRareGemScore)
                     {
                        this.maxRareGemScore = _loc16_;
                     }
                  }
               }
            }
            if(this.maxRareGemScore > this.allTimeHighScore)
            {
               this.allTimeHighScore = this.maxRareGemScore;
            }
         }
         if(param1.multiplayer != null)
         {
            this.perfectPartiesWon = Utils.getIntFromObject(param1.multiplayer.perfectGames);
         }
         if(param1.scores != null && param1.scores.length >= 1)
         {
            _loc18_ = new Array();
            _loc4_ = 0;
            while(_loc4_ < param1.scores.length)
            {
               _loc18_.push({
                  "id":param1.scores[_loc4_].id,
                  "score":param1.scores[_loc4_].score
               });
               _loc4_++;
            }
            _loc18_.sortOn("score",Array.NUMERIC | Array.DESCENDING);
            this.maxLastFiveWeeksScore = _loc18_[0].score;
            if(this.maxLastFiveWeeksScore > this.allTimeHighScore)
            {
               this.allTimeHighScore = this.maxLastFiveWeeksScore;
            }
         }
         this._isExtendedDataLoaded = true;
         this.recalcLevel();
         return _loc3_;
      }
      
      public function copyBitmapDataTo(param1:Bitmap, param2:TextField = null) : void
      {
         if(this._isLoaded && this._profileImage != null)
         {
            param1.bitmapData = this._profileImage.clone();
            if(param2 != null)
            {
               param2.htmlText = Utils.getTruncatedString(this.playerName,18);
            }
         }
         else
         {
            this._bitmapDataConsumers.push(param1);
            if(param2)
            {
               this._textDataConsumers.push(param2);
            }
            if(!this._isLoading)
            {
               this.loadImage();
            }
         }
      }
      
      public function IsExtendedDataLoaded() : Boolean
      {
         return this._isExtendedDataLoaded || this.isFakePlayer;
      }
      
      public function recalcLevel() : void
      {
         this.level = 0;
         var _loc1_:Number = LEVEL_STEP;
         var _loc2_:Number = 0;
         while(this.xp >= _loc2_)
         {
            ++this.level;
            this.prevLevelCutoff = _loc2_;
            _loc2_ += _loc1_;
            _loc1_ += LEVEL_STEP;
         }
         this.nextLevelCutoff = _loc2_;
         var _loc3_:int = Math.max(Math.min(this.level - 1,MAX_LEVEL - 1),0);
         this.levelName = Constants.LEVEL_NAMES[_loc3_];
      }
      
      public function setScore(param1:int) : void
      {
         this.xp += param1;
         this.recalcLevel();
         if(param1 > this.curTourneyData.score)
         {
            this.curTourneyData.score = param1;
            this.rareGemUsedForHighScore = (this._app as Blitz3Game).network.reportedRGUsed;
            this.boostsUsedForHighScore = (this._app as Blitz3Game).network.reportedBoostsUsed;
            if(param1 > this.allTimeHighScore)
            {
               this.allTimeHighScore = param1;
            }
         }
         (this._app as Blitz3Game).network.reportedRGUsed = "";
         (this._app as Blitz3Game).network.reportedBoostsUsed = null;
         var _loc2_:int = 0;
         if(param1 < 25000)
         {
            _loc2_ = -1;
            return;
         }
         if(param1 < 250000)
         {
            _loc2_ = int(param1 / 25000) - 1;
         }
         else if(param1 <= 500000)
         {
            _loc2_ = 9 + int((param1 - 250000) / 50000);
         }
         else if(param1 <= 1000000)
         {
            _loc2_ = 14;
         }
         else if(param1 <= 3000000)
         {
            _loc2_ = 15;
         }
         else if(param1 <= 5000000)
         {
            _loc2_ = 16;
         }
         else if(param1 <= 10000000)
         {
            _loc2_ = 17;
         }
         else
         {
            _loc2_ = 18;
         }
         _loc2_ = Math.min(_loc2_,NUM_MEDALS - 1);
         var _loc3_:MedalData = this.medalHistory[_loc2_];
         var _loc4_:int = _loc3_.tierIndex;
         ++_loc3_.count;
         _loc3_.CalculateTier();
      }
      
      public function onGetUser(param1:String, param2:String) : void
      {
         this.playerName = param1;
         this.makeTextConsumerCallbacks();
         this.imageUrl = param2;
         this.doLoad();
      }
      
      private function loadImage() : void
      {
         if(this.playerFuid != "" && this.playerFuid != "0" && (this.playerName == "" || this.imageUrl == ""))
         {
            this.imageUrl = ".";
            ServerIO.sendToServer("getUser",{"userId":this.playerFuid});
         }
         else
         {
            this.doLoad();
         }
      }
      
      private function doLoad() : void
      {
         if(!this._isLoaded && !this._isLoading && this.imageUrl != "")
         {
            this._isLoading = true;
            this._imageRetryLoad = true;
            this._imageLoader.load(new URLRequest(this.imageUrl),new LoaderContext(true));
         }
      }
      
      private function makeImageConsumerCallbacks() : void
      {
         var _loc1_:Bitmap = null;
         for each(_loc1_ in this._bitmapDataConsumers)
         {
            _loc1_.bitmapData = this._profileImage.clone();
         }
      }
      
      private function makeTextConsumerCallbacks() : void
      {
         var _loc1_:TextField = null;
         for each(_loc1_ in this._textDataConsumers)
         {
            _loc1_.htmlText = Utils.getTruncatedString(this.playerName,MAX_NAME_LENGTH);
         }
      }
      
      private function handleProfileImageComplete(param1:Event) : void
      {
         var event:Event = param1;
         this._isLoading = false;
         this._isLoaded = true;
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            return;
         }
         try
         {
            this._profileImage = (this._imageLoader.content as Bitmap).bitmapData.clone();
         }
         catch(e:Error)
         {
            _isLoaded = false;
            if(_imageRedirectLoad)
            {
               _imageRedirectLoad = false;
               if(_imageLoader.contentLoaderInfo.isURLInaccessible)
               {
                  Security.allowDomain(_imageLoader.contentLoaderInfo.url);
                  Security.allowInsecureDomain(_imageLoader.contentLoaderInfo.url);
                  Security.loadPolicyFile(_imageLoader.contentLoaderInfo.url + "crossdomain.xml");
               }
               else
               {
                  imageUrl = _imageLoader.contentLoaderInfo.url;
               }
               _isLoading = true;
               _imageLoader.load(new URLRequest(imageUrl),new LoaderContext(true));
            }
            return;
         }
         if(this._profileImage != null)
         {
            this._imageLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleProfileImageComplete);
            this._imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleProfileImageIOError);
            this._imageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleProfileImageSecurityError);
            this.makeImageConsumerCallbacks();
            this.makeTextConsumerCallbacks();
         }
      }
      
      private function handleProfileImageIOError(param1:IOErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this.imageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"PlayerData error loading profile image: " + this.imageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      private function handleProfileImageSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this._imageRetryLoad)
         {
            this._imageRetryLoad = false;
            this._imageLoader.load(new URLRequest(this.imageUrl),new LoaderContext(true));
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_SECURITY,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"PlayerData security error loading profile image: " + this.imageUrl + " " + param1.toString());
            this._isLoading = false;
         }
      }
      
      public function LoadReplay(param1:Boolean) : void
      {
         (this._app as Blitz3Game).sessionData.replayManager.LoadReplayFromServer(this,param1);
      }
   }
}
