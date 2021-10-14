package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.utils.Dictionary;
   
   public class ConfigManager
   {
      
      public static const FLAG_AUTO_RENEW:String = "boostAutoRenew";
      
      public static const FLAG_AUTO_HINT:String = "autoHint";
      
      public static const FLAG_TIPS_ENABLED:String = "tipsEnabled";
      
      public static const FLAG_TUTORIAL_COMPLETE:String = "tutorialComplete";
      
      public static const FLAG_ALLOW_DISABLE_TIPS:String = "allowDisableTips";
      
      public static const FLAG_FINISHED_FIRST_GAME:String = "finishedFirstGame";
      
      public static const FLAG_FINISHED_SECOND_GAME:String = "finishedSecondGame";
      
      public static const FLAG_LQ_MODE:String = "LQModeFix";
      
      public static const FLAG_HIDE_LQ_DIALOG_WARNING:String = "hideLQDialog";
      
      public static const FLAG_NEW_USER_ENROLLED:String = "enrolled";
      
      public static const FLAG_SHARE_BLITZ_PARTY:String = "shareCheckedForBlitzParty";
      
      public static const FLAG_FTUE_NEW_USER:String = "ftueV2NewUser";
      
      public static const FLAG_FTUE_FLAGS:String = "ftueV2Flags";
      
      public static const FLAG_FTUE_GRANT:String = "canvasFtue";
      
      public static const INT_VOLUME:String = "volume";
      
      public static const INT_FIRST_GAME_TIME:String = "firstGameTime";
      
      public static const INT_LAST_GAME_TIME:String = "lastGameTime";
      
      public static const INT_FINISHED_BLITZ_PARTY_TUTORIAL:String = "finishedBlitzPartyTutorial";
      
      public static const INT_TIP_KANGA_RUBY_END:String = "tipKangaRubyEnd";
      
      public static const NUMBER_LAST_POKE_CLICK:String = "lastPokeClickDate";
      
      public static const DICT_RARE_GEM_WEIGHTS:String = "rareGemWeights";
      
      public static const DICT_RARE_GEM_WEIGHTS_PARTY:String = "rareGemWeightsParty";
      
      public static const OBJ_QUEST_UNLOCK_QUEST_WIDGET:String = "unlockQuestWidget";
      
      public static const OBJ_QUEST_UNLOCK_LEADERBOARD_BASIC:String = "unlockLeaderboardBasic";
      
      public static const OBJ_QUEST_UNLOCK_BOOSTS:String = "unlockBoosts";
      
      public static const OBJ_QUEST_UNLOCK_DAILY_SPIN:String = "unlockDailySpin";
      
      public static const OBJ_QUEST_UNLOCK_FRIENDSCORE:String = "unlockFriendscore";
      
      public static const OBJ_QUEST_UNLOCK_RARE_GEMS:String = "unlockRareGems";
      
      public static const OBJ_QUEST_FIND_RARE_GEM:String = "findRareGem";
      
      public static const OBJ_QUEST_UNLOCK_STAR_MEDALS:String = "unlockStarMedals";
      
      public static const OBJ_QUEST_UNLOCK_MULTIPLAYER:String = "unlockChallenges";
      
      public static const OBJ_QUEST_UNLOCK_LEVELS:String = "unlockLevels";
      
      public static const OBJ_QUEST_LEVEL_UP:String = "levelUp";
      
      public static const OBJ_QUEST_DYNAMIC_EASY:String = "necronomicon";
      
      public static const OBJ_QUEST_DYNAMIC_MEDIUM:String = "oneRing";
      
      public static const OBJ_QUEST_DYNAMIC_HARD:String = "darkTower";
      
      public static const OBJ_QUEST_WEAK_MILESTONE:String = "weakMileStone";
      
      public static const OBJ_QUEST_STRONG_MILESTONE:String = "strongMileStone";
      
      public static const OBJ_QUEST_UNLOCK_ERRORLESS_GAMES:String = "errorLessGames";
       
      
      private var m_App:Blitz3App;
      
      private var m_ConfigProviders:Vector.<IConfigProvider>;
      
      public function ConfigManager(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_ConfigProviders = new Vector.<IConfigProvider>();
         this.m_ConfigProviders.push(new GameSettingsProvider());
         this.m_ConfigProviders.push(new TutorialSettingsProvider(param1));
         this.m_ConfigProviders.push(new QuestSettingsProvider(param1));
         this.m_ConfigProviders.push(new ServerResponseDataProvider(param1));
         this.m_ConfigProviders.push(new DummyProvider());
      }
      
      public function Init() : void
      {
         var _loc1_:IConfigProvider = null;
         for each(_loc1_ in this.m_ConfigProviders)
         {
            _loc1_.Init();
         }
      }
      
      public function CommitChanges(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:IConfigProvider = null;
         for each(_loc3_ in this.m_ConfigProviders)
         {
            _loc3_.CommitChanges(param1,param2);
         }
      }
      
      public function GetFlag(param1:String) : Boolean
      {
         return this.GetObject(param1) as Boolean;
      }
      
      public function GetFlagWithDefault(param1:String, param2:Boolean = false) : Boolean
      {
         return this.GetObject(param1,param2) as Boolean;
      }
      
      public function SetFlag(param1:String, param2:Boolean) : void
      {
         this.SetObject(param1,param2);
      }
      
      public function GetInt(param1:String) : int
      {
         return this.GetObject(param1) as int;
      }
      
      public function GetIntWithDefault(param1:String, param2:int = -1) : int
      {
         return this.GetObject(param1,param2) as int;
      }
      
      public function SetInt(param1:String, param2:int) : void
      {
         this.SetObject(param1,param2);
      }
      
      public function GetNumber(param1:String) : Number
      {
         return this.GetObject(param1) as Number;
      }
      
      public function GetNumberWithDefault(param1:String, param2:Number = -1) : Number
      {
         return this.GetObject(param1,param2) as Number;
      }
      
      public function SetNumber(param1:String, param2:Number) : void
      {
         this.SetObject(param1,param2);
      }
      
      public function GetString(param1:String) : String
      {
         return this.GetObject(param1) as String;
      }
      
      public function GetStringWithDefault(param1:String, param2:String = "") : String
      {
         return this.GetObject(param1,param2) as String;
      }
      
      public function SetString(param1:String, param2:String) : void
      {
         this.SetObject(param1,param2);
      }
      
      public function GetDictionary(param1:String) : Dictionary
      {
         return this.CopyObject(this.GetObject(param1)) as Dictionary;
      }
      
      public function GetDictionaryWithDefault(param1:String, param2:Dictionary = null) : Dictionary
      {
         return this.CopyObject(this.GetObject(param1,param2)) as Dictionary;
      }
      
      public function SetDictionary(param1:String, param2:Dictionary) : void
      {
         this.SetObject(param1,param2);
      }
      
      public function GetObj(param1:String) : Object
      {
         return this.CopyObject(this.GetObject(param1));
      }
      
      public function GetObjWithDefault(param1:String, param2:Dictionary = null) : Object
      {
         return this.CopyObject(this.GetObject(param1,param2));
      }
      
      public function SetObj(param1:String, param2:Object) : void
      {
         this.SetObject(param1,param2);
      }
      
      public function GetArray(param1:String) : Array
      {
         return this.GetObject(param1) as Array;
      }
      
      public function GetArrayWithDefault(param1:String, param2:Array = null) : Array
      {
         return this.GetObject(param1,param2) as Array;
      }
      
      public function SetArray(param1:String, param2:Array) : void
      {
         this.SetObject(param1,param2);
      }
      
      public function HasKey(param1:String) : Boolean
      {
         var _loc2_:IConfigProvider = this.GetProvider(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.HasObject(param1);
      }
      
      private function GetObject(param1:String, param2:Object = null) : Object
      {
         var _loc3_:IConfigProvider = this.GetProvider(param1);
         if(_loc3_ == null)
         {
            return param2;
         }
         var _loc4_:Object = param2;
         if(param2 == null)
         {
            _loc4_ = _loc3_.GetDefault(param1);
         }
         return _loc3_.GetObject(param1,_loc4_);
      }
      
      private function SetObject(param1:String, param2:Object) : void
      {
         var _loc3_:IConfigProvider = this.GetProvider(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.SetObject(param1,param2);
      }
      
      private function GetProvider(param1:String) : IConfigProvider
      {
         var _loc2_:IConfigProvider = null;
         for each(_loc2_ in this.m_ConfigProviders)
         {
            if(_loc2_.IsKeySupported(param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function CopyObject(param1:Object) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:* = null;
         if(param1 == null)
         {
            return null;
         }
         if(param1 is Dictionary)
         {
            _loc2_ = new Dictionary();
         }
         else
         {
            _loc2_ = new Object();
         }
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
   }
}
