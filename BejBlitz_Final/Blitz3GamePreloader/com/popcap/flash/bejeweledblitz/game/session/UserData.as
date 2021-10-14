package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import flash.utils.Dictionary;
   
   public class UserData
   {
      
      public static const LEVEL_STEP:Number = 250000;
      
      public static const QUEST_SLOT_MEDIUM_LEVEL:int = 5;
      
      public static const QUEST_SLOT_HARD_LEVEL:int = 20;
       
      
      private var _app:Blitz3App;
      
      private var _FUID:String = "";
      
      private var _locale:String = "en-US";
      
      private var _tokens:int = 0;
      
      private var _coins:Number = 0;
      
      private var _spins:int = 0;
      
      private var _highScore:int = 0;
      
      private var _newHighScore:Boolean = false;
      
      private var _xp:Number = 0;
      
      private var _level:int = 0;
      
      private var _prevLevelCutoff:Number = 0;
      
      private var _nextLevelCutoff:Number = 250000;
      
      private var _currentGameID:String = "";
      
      private var _lastLevelCutoff:int;
      
      private var _coinsEarnedInLastGame:int = 0;
      
      private var _ftueGame:Boolean = false;
      
      private var _starCatsToday:int = 0;
      
      private var _dailyChallengeRewardThresholds:Array;
      
      public var currencyManager:CurrencyManager;
      
      private var userBoostSkillData:Dictionary;
      
      private var userBoostLevelData:Dictionary;
      
      public function UserData(param1:Blitz3App)
      {
         this._dailyChallengeRewardThresholds = new Array();
         super();
         this._app = param1;
         this.currencyManager = new CurrencyManager();
         this.generateNewGameID();
      }
      
      public function Init() : void
      {
         this._highScore = int(this._app.network.parameters.theHighScore);
         if(isNaN(this._highScore))
         {
            this._highScore = 0;
         }
      }
      
      public function GetFUID() : String
      {
         return this._FUID;
      }
      
      public function SetFUID(param1:String) : void
      {
         this._FUID = param1;
         Globals.userId = param1;
      }
      
      public function GetLocale() : String
      {
         return this._locale;
      }
      
      public function SetLocale(param1:String) : void
      {
         this._locale = param1;
      }
      
      public function getCoinsEarnedInLastGame() : int
      {
         return this._coinsEarnedInLastGame;
      }
      
      public function getSpins() : int
      {
         return this._spins;
      }
      
      public function SetSpins(param1:int) : void
      {
      }
      
      public function set StarCats(param1:int) : void
      {
         this._starCatsToday = param1;
      }
      
      public function get StarCats() : int
      {
         return this._starCatsToday;
      }
      
      public function set StarCatsThresholdsPayed(param1:Array) : void
      {
         this._dailyChallengeRewardThresholds = param1;
      }
      
      public function get StarCatsThresholdsPayed() : Array
      {
         return this._dailyChallengeRewardThresholds;
      }
      
      public function set HighScore(param1:int) : void
      {
         this._newHighScore = false;
         if(param1 > this._highScore)
         {
            this._highScore = param1;
            this._newHighScore = true;
         }
      }
      
      public function get HighScore() : int
      {
         return this._highScore;
      }
      
      public function get NewHighScore() : Boolean
      {
         return this._newHighScore;
      }
      
      public function GetXP() : Number
      {
         return this._xp;
      }
      
      public function SetXP(param1:Number) : void
      {
         this._xp = param1;
         this._level = 0;
         var _loc2_:Number = LEVEL_STEP;
         this._prevLevelCutoff = 0;
         this._nextLevelCutoff = 0;
         while(this._xp >= this._nextLevelCutoff)
         {
            ++this._level;
            this._prevLevelCutoff = this._nextLevelCutoff;
            this._nextLevelCutoff += _loc2_;
            _loc2_ += LEVEL_STEP;
         }
         this.DispatchXPTotalChanged();
      }
      
      public function AddXP(param1:Number) : void
      {
         if(!this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_XP))
         {
            return;
         }
         this.SetXP(this._xp + param1);
      }
      
      public function GetLevel() : int
      {
         return this._level;
      }
      
      public function GetPrevLevelCutoff() : Number
      {
         return this._prevLevelCutoff;
      }
      
      public function GetNextLevelCutoff() : Number
      {
         return this._nextLevelCutoff;
      }
      
      public function IsNewUser() : Boolean
      {
         return this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_NEW_USER_ENROLLED) || this._app.network.IsNewUser();
      }
      
      public function ForceDispatchUserInfo() : void
      {
         this.currencyManager.DispatchBalanceChangedForAllCurrencies();
         this.DispatchXPTotalChanged();
      }
      
      public function ForceLevelUp() : void
      {
      }
      
      public function HandleGameStart() : void
      {
         this.generateNewGameID();
         this.currencyManager.DispatchBalanceChangedForAllCurrencies();
         this._coinsEarnedInLastGame = 0;
      }
      
      public function GetGameID() : String
      {
         return this._currentGameID;
      }
      
      private function generateNewGameID() : void
      {
         var _loc1_:Date = new Date();
         this._currentGameID = String(this.GetFUID()) + String(_loc1_.fullYear) + Utils.getTwoDigitString(_loc1_.month + 1) + Utils.getTwoDigitString(_loc1_.date) + Utils.getTwoDigitString(_loc1_.hours) + Utils.getTwoDigitString(_loc1_.minutes) + Utils.getTwoDigitString(_loc1_.seconds) + Utils.getThreeDigitString(_loc1_.milliseconds);
         String(Math.floor(Math.random() * 100000));
      }
      
      protected function DispatchXPTotalChanged() : void
      {
         var _loc1_:IUserDataHandler = null;
         for each(_loc1_ in this.currencyManager.GetHandlers())
         {
            _loc1_.HandleXPTotalChanged(this._xp,this._level);
         }
         if(this._level <= 0)
         {
            return;
         }
         var _loc2_:int = this._app.sessionData.userData.GetNextLevelCutoff();
         if(this._lastLevelCutoff != -1 && this._xp > 0 && _loc2_ > this._lastLevelCutoff)
         {
            this._app.network.ExternalCall("deliverNewLevel",this._level);
         }
         this._lastLevelCutoff = _loc2_;
      }
      
      public function setUserBoostSkillData(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         this.userBoostSkillData = null;
         this.userBoostSkillData = new Dictionary();
         for(_loc2_ in param1)
         {
            if(_loc2_)
            {
               this.userBoostSkillData[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function setUserBoostLevelData(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         this.userBoostLevelData = null;
         this.userBoostLevelData = new Dictionary();
         for(_loc2_ in param1)
         {
            if(_loc2_)
            {
               this.userBoostLevelData[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function GetBoostLevel(param1:String) : int
      {
         var _loc3_:BoostUIInfo = null;
         if(param1 == "" || this.userBoostLevelData == null || !this.userBoostLevelData.hasOwnProperty(param1))
         {
            trace(" ----- ERROR , retrieving level ( " + param1 + " ) of unknown boostId ------");
            return -1;
         }
         var _loc2_:int = this.userBoostLevelData[param1];
         if(this._app.sessionData.boostV2Manager != null)
         {
            _loc3_ = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(param1);
            if(_loc3_ != null)
            {
               if(_loc3_.IsLevelMaxLevel(_loc2_))
               {
                  _loc2_ = _loc3_.getMaxLevel();
               }
            }
         }
         return _loc2_;
      }
      
      public function GetUserSkillData(param1:String) : int
      {
         trace("Trying to get SkillData of " + param1);
         if(param1 == "" || this.userBoostSkillData == null || !this.userBoostSkillData.hasOwnProperty(param1))
         {
            trace(" ----- ERROR , retrieving skill data ( " + param1 + " ). no such skill known ------");
            return 0;
         }
         trace("returning " + this.userBoostSkillData[param1]);
         return this.userBoostSkillData[param1];
      }
      
      public function SetFTUEGame(param1:Boolean) : void
      {
         this._ftueGame = param1;
      }
      
      public function IsFTUEGame() : Boolean
      {
         return this._ftueGame;
      }
   }
}
