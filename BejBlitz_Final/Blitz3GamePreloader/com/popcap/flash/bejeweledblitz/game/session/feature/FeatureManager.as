package com.popcap.flash.bejeweledblitz.game.session.feature
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.utils.Dictionary;
   
   public class FeatureManager
   {
      
      public static const FEATURE_BOOSTS:String = "FeatureBoosts";
      
      public static const FEATURE_RARE_GEMS:String = "FeatureRareGems";
      
      public static const FEATURE_RARE_GEM_STREAKS:String = "FeatureRareGemStreaks";
      
      public static const FEATURE_DAILY_SPIN:String = "FeatureDailySpin";
      
      public static const FEATURE_PROGRESSIVE_DAILY_SPIN:String = "FeatureProgressiveDailySpin";
      
      public static const FEATURE_LEADERBOARD_BASIC:String = "FeatureLeaderboardBasic";
      
      public static const FEATURE_LEADERBOARD_FULL:String = "FeatureLeaderboardFull";
      
      public static const FEATURE_FRIENDSCORE:String = "FeatureFriendscore";
      
      public static const FEATURE_DAILY_CHALLENGES:String = "FeatureDailyChallenges";
      
      public static const FEATURE_MULTIPLAYER:String = "FeatureMultiplayer";
      
      public static const FEATURE_MYSTERY_TREASURES:String = "FeatureMysteryTreasures";
      
      public static const FEATURE_XP:String = "FeatureXP";
      
      public static const FEATURE_QUESTS:String = "FeatureQuests";
      
      public static const FEATURE_QUEST_WIDGET:String = "FeatureQuestWidget";
      
      public static const FEATURE_DYNAMIC_EASY_QUESTS:String = "FeatureDynamicEasyQuests";
      
      public static const FEATURE_DYNAMIC_MEDIUM_QUESTS:String = "FeatureDynamicMediumQuests";
      
      public static const FEATURE_DYNAMIC_HARD_QUESTS:String = "FeatureDynamicHardQuests";
      
      public static const FEATURE_LEVELUP_MILESTONE:String = "FeatureLevelUpMilestone";
      
      public static const FEATURE_STAR_MEDALS:String = "FeatureStarMedals";
      
      public static const FEATURE_MENU_TIPS:String = "FeatureMenuTips";
      
      private static const DEPENDENCIES:Dictionary = new Dictionary();
      
      {
         DEPENDENCIES[FEATURE_BOOSTS] = [];
         DEPENDENCIES[FEATURE_RARE_GEMS] = [];
         DEPENDENCIES[FEATURE_RARE_GEM_STREAKS] = [FEATURE_RARE_GEMS];
         DEPENDENCIES[FEATURE_DAILY_SPIN] = [];
         DEPENDENCIES[FEATURE_PROGRESSIVE_DAILY_SPIN] = [FEATURE_DAILY_SPIN];
         DEPENDENCIES[FEATURE_LEADERBOARD_BASIC] = [FEATURE_XP];
         DEPENDENCIES[FEATURE_LEADERBOARD_FULL] = [FEATURE_LEADERBOARD_BASIC];
         DEPENDENCIES[FEATURE_FRIENDSCORE] = [FEATURE_LEADERBOARD_FULL];
         DEPENDENCIES[FEATURE_MULTIPLAYER] = [];
         DEPENDENCIES[FEATURE_DAILY_CHALLENGES] = [];
         DEPENDENCIES[FEATURE_MYSTERY_TREASURES] = [];
         DEPENDENCIES[FEATURE_XP] = [];
         DEPENDENCIES[FEATURE_QUESTS] = [];
         DEPENDENCIES[FEATURE_QUEST_WIDGET] = [FEATURE_QUESTS];
         DEPENDENCIES[FEATURE_DYNAMIC_EASY_QUESTS] = [FEATURE_QUESTS,FEATURE_QUEST_WIDGET];
         DEPENDENCIES[FEATURE_DYNAMIC_MEDIUM_QUESTS] = [FEATURE_DYNAMIC_EASY_QUESTS];
         DEPENDENCIES[FEATURE_DYNAMIC_HARD_QUESTS] = [FEATURE_DYNAMIC_MEDIUM_QUESTS];
         DEPENDENCIES[FEATURE_STAR_MEDALS] = [];
         DEPENDENCIES[FEATURE_MENU_TIPS] = [];
      }
      
      private var _app:Blitz3App;
      
      private var _featuresArray:Vector.<Feature>;
      
      private var _handlersArray:Vector.<IFeatureManagerHandler>;
      
      public function FeatureManager(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._featuresArray = new Vector.<Feature>();
         this._handlersArray = new Vector.<IFeatureManagerHandler>();
      }
      
      public function Init() : void
      {
         this.createFeatures();
         this.initializeFeatures();
      }
      
      public function AddHandler(param1:IFeatureManagerHandler) : void
      {
         this._handlersArray.push(param1);
      }
      
      public function isFeatureEnabled(param1:String) : Boolean
      {
         var _loc2_:Feature = this.getFeature(param1);
         return _loc2_ != null && _loc2_.isEnabled();
      }
      
      public function enableFeature(param1:String) : Boolean
      {
         return this.doEnableFeature(param1);
      }
      
      public function enableFeatures(param1:Vector.<String>) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         for each(_loc2_ in param1)
         {
            _loc3_ = this.doEnableFeature(_loc2_);
            if(!_loc3_)
            {
               return false;
            }
         }
         return true;
      }
      
      private function getFeature(param1:String) : Feature
      {
         var _loc2_:Feature = null;
         for each(_loc2_ in this._featuresArray)
         {
            if(_loc2_.getID() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function doEnableFeature(param1:String) : Boolean
      {
         var _loc2_:Feature = this.getFeature(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         if(_loc2_.isEnabled())
         {
            return true;
         }
         var _loc3_:Boolean = _loc2_.enable();
         if(!_loc3_)
         {
            return false;
         }
         this.dispatchFeatureEnabled(param1);
         return true;
      }
      
      private function createFeatures() : void
      {
         this._featuresArray.push(new Feature(this._app,FEATURE_BOOSTS,DEPENDENCIES[FEATURE_BOOSTS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_RARE_GEMS,DEPENDENCIES[FEATURE_RARE_GEMS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_RARE_GEM_STREAKS,DEPENDENCIES[FEATURE_RARE_GEM_STREAKS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_DAILY_SPIN,DEPENDENCIES[FEATURE_DAILY_SPIN]));
         this._featuresArray.push(new Feature(this._app,FEATURE_PROGRESSIVE_DAILY_SPIN,DEPENDENCIES[FEATURE_PROGRESSIVE_DAILY_SPIN]));
         this._featuresArray.push(new Feature(this._app,FEATURE_LEADERBOARD_BASIC,DEPENDENCIES[FEATURE_LEADERBOARD_BASIC]));
         this._featuresArray.push(new Feature(this._app,FEATURE_LEADERBOARD_FULL,DEPENDENCIES[FEATURE_LEADERBOARD_FULL]));
         this._featuresArray.push(new Feature(this._app,FEATURE_FRIENDSCORE,DEPENDENCIES[FEATURE_FRIENDSCORE]));
         this._featuresArray.push(new Feature(this._app,FEATURE_MULTIPLAYER,DEPENDENCIES[FEATURE_MULTIPLAYER]));
         this._featuresArray.push(new Feature(this._app,FEATURE_DAILY_CHALLENGES,DEPENDENCIES[FEATURE_DAILY_CHALLENGES]));
         this._featuresArray.push(new Feature(this._app,FEATURE_MYSTERY_TREASURES,DEPENDENCIES[FEATURE_MYSTERY_TREASURES]));
         this._featuresArray.push(new Feature(this._app,FEATURE_XP,DEPENDENCIES[FEATURE_XP]));
         this._featuresArray.push(new Feature(this._app,FEATURE_QUESTS,DEPENDENCIES[FEATURE_QUESTS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_QUEST_WIDGET,DEPENDENCIES[FEATURE_QUEST_WIDGET]));
         this._featuresArray.push(new Feature(this._app,FEATURE_DYNAMIC_EASY_QUESTS,DEPENDENCIES[FEATURE_DYNAMIC_EASY_QUESTS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_DYNAMIC_MEDIUM_QUESTS,DEPENDENCIES[FEATURE_DYNAMIC_MEDIUM_QUESTS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_DYNAMIC_HARD_QUESTS,DEPENDENCIES[FEATURE_DYNAMIC_HARD_QUESTS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_STAR_MEDALS,DEPENDENCIES[FEATURE_STAR_MEDALS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_MENU_TIPS,DEPENDENCIES[FEATURE_MENU_TIPS]));
         this._featuresArray.push(new Feature(this._app,FEATURE_LEVELUP_MILESTONE,DEPENDENCIES[FEATURE_LEVELUP_MILESTONE]));
      }
      
      private function initializeFeatures() : void
      {
         var _loc1_:Feature = null;
         for each(_loc1_ in this._featuresArray)
         {
            _loc1_.updateIsEnabled();
         }
         this.enableFeature(FeatureManager.FEATURE_DAILY_SPIN);
      }
      
      private function dispatchFeatureEnabled(param1:String) : void
      {
         var _loc2_:IFeatureManagerHandler = null;
         for each(_loc2_ in this._handlersArray)
         {
            _loc2_.HandleFeatureEnabled(param1);
         }
      }
   }
}
