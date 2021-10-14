package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public class AutoCompletedCompletionStrategy implements IQuestCompletionStrategy
   {
       
      
      protected var m_Quest:Quest;
      
      protected var m_IsComplete:Boolean;
      
      public function AutoCompletedCompletionStrategy()
      {
         super();
         this.m_IsComplete = false;
      }
      
      public function SetQuest(param1:Quest) : void
      {
         this.m_Quest = param1;
      }
      
      public function IsQuestComplete() : Boolean
      {
         return this.m_IsComplete;
      }
      
      public function ForceCompletion() : void
      {
      }
      
      public function clearCompletion() : void
      {
      }
      
      public function forceReset() : void
      {
      }
      
      public function UpdateCompletionState() : void
      {
         this.m_IsComplete = true;
      }
      
      public function GetProgressString() : String
      {
         return "";
      }
      
      public function GetProgress() : int
      {
         return int(this.m_IsComplete);
      }
      
      public function GetGoalString() : String
      {
         return "";
      }
      
      public function GetGoal() : int
      {
         return 0;
      }
      
      public function CleanUpConfigData() : void
      {
      }
   }
}
