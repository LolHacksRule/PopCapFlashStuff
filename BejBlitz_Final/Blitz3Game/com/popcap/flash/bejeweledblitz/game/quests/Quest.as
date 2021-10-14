package com.popcap.flash.bejeweledblitz.game.quests
{
   import com.popcap.flash.bejeweledblitz.game.quests.availability.IQuestAvailabilityStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.expirary.IQuestExpiraryStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   
   public class Quest
   {
       
      
      private var _app:Blitz3Game;
      
      private var _questData:QuestData;
      
      private var _availability:IQuestAvailabilityStrategy;
      
      private var _completion:IQuestCompletionStrategy;
      
      private var _reward:IQuestRewardStrategy;
      
      private var _expiry:IQuestExpiraryStrategy;
      
      private var _level:int;
      
      private var _questType:String;
      
      public function Quest(param1:Blitz3Game, param2:QuestData, param3:IQuestAvailabilityStrategy, param4:IQuestCompletionStrategy, param5:IQuestRewardStrategy, param6:IQuestExpiraryStrategy, param7:int = 1, param8:Object = null)
      {
         super();
         this._app = param1;
         this._questData = param2;
         if(param8)
         {
            this._questType = param8[QuestConstants.KEY_COMPLETION][QuestConstants.KEY_COMPLETION_TYPE];
         }
         this._availability = param3;
         this._completion = param4;
         this._reward = param5;
         this._expiry = param6;
         this._availability.SetQuest(this);
         this._completion.SetQuest(this);
         if(this._reward)
         {
            this._reward.SetQuest(this);
         }
         this._expiry.SetQuest(this);
         this._level = param7;
      }
      
      public function IsAvailable() : Boolean
      {
         return this._availability.IsQuestAvailable();
      }
      
      public function IsComplete() : Boolean
      {
         return this._completion.IsQuestComplete();
      }
      
      public function GetConfigIdFromQuestId(param1:String) : String
      {
         if(param1 == QuestManager.QUEST_DYNAMIC_EASY)
         {
            return ConfigManager.OBJ_QUEST_DYNAMIC_EASY;
         }
         if(param1 == QuestManager.QUEST_DYNAMIC_MEDIUM)
         {
            return ConfigManager.OBJ_QUEST_DYNAMIC_MEDIUM;
         }
         if(param1 == QuestManager.QUEST_DYNAMIC_HARD)
         {
            return ConfigManager.OBJ_QUEST_DYNAMIC_HARD;
         }
         return "";
      }
      
      public function HasExpired() : Boolean
      {
         return this._expiry.HasQuestExpired();
      }
      
      public function isDailyChallengeGame() : Boolean
      {
         return this._app.isDailyChallengeGame();
      }
      
      public function isTournamentGame() : Boolean
      {
         return this._app.isTournamentScreenOrMode();
      }
      
      public function timeLeftOnQuest() : int
      {
         return this._expiry.timeLeft();
      }
      
      public function IsActive() : Boolean
      {
         return this.IsAvailable() && !this.IsComplete() && !this.HasExpired() && !this.isDailyChallengeGame() && !this.isTournamentGame();
      }
      
      public function UpdateCompletion(param1:Boolean) : void
      {
         if(!this.IsActive())
         {
            return;
         }
         var _loc2_:Boolean = this.IsComplete();
         this._completion.UpdateCompletionState();
         if(!_loc2_ && this.IsComplete())
         {
            this._completion.ForceCompletion();
            this._reward.DoQuestComplete(param1);
         }
      }
      
      public function GetProgress() : int
      {
         return this._completion.GetProgress();
      }
      
      public function GetQuestType() : String
      {
         return this._questType;
      }
      
      public function GetProgressString() : String
      {
         return this._completion.GetProgressString();
      }
      
      public function GetGoalString() : String
      {
         return this._completion.GetGoalString();
      }
      
      public function GetGoal() : int
      {
         return this._completion.GetGoal();
      }
      
      public function GetRewardString() : String
      {
         return this._reward.GetRewardString();
      }
      
      public function getRewardType() : String
      {
         return this._reward.getRewardType();
      }
      
      public function GetExpiraryString() : String
      {
         return this._expiry.GetExpiraryString();
      }
      
      public function GetData() : QuestData
      {
         return this._questData;
      }
      
      public function ClearCompletitionStrategy() : void
      {
         this._completion.CleanUpConfigData();
      }
      
      public function getLevel() : int
      {
         return this._level;
      }
      
      public function UpdateQuestFromServerData() : void
      {
         var _loc1_:Object = this._app.sessionData.configManager.GetObj(this.GetConfigIdFromQuestId(this._questData.id));
         var _loc2_:Boolean = false;
         if(_loc1_ != null)
         {
            _loc2_ = this._completion.IsQuestComplete() || _loc1_.complete && _loc1_.goal.name == this._questType;
         }
         if(_loc2_)
         {
            this.ForceCompleteQuest();
         }
      }
      
      private function ForceCompleteQuest() : void
      {
         this._completion.ForceCompletion();
      }
      
      function ForceCompletion() : void
      {
         this._completion.ForceCompletion();
         this._reward.DoQuestComplete(true);
         this.UpdateCompletion(false);
      }
      
      public function clearCompletion() : void
      {
         this._completion.clearCompletion();
      }
      
      public function forceReset() : void
      {
         this._completion.forceReset();
      }
      
      public function dumpQuestData() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_["slot"] = this._questData.id;
         _loc1_["type"] = this.GetQuestType();
         _loc1_["progress"] = this.GetProgress();
         _loc1_["goal"] = this.GetGoal();
         _loc1_["time"] = this.timeLeftOnQuest();
         return _loc1_;
      }
   }
}
