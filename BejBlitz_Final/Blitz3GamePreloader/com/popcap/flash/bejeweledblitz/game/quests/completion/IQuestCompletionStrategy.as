package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public interface IQuestCompletionStrategy
   {
       
      
      function SetQuest(param1:Quest) : void;
      
      function IsQuestComplete() : Boolean;
      
      function ForceCompletion() : void;
      
      function clearCompletion() : void;
      
      function forceReset() : void;
      
      function UpdateCompletionState() : void;
      
      function GetProgress() : int;
      
      function GetProgressString() : String;
      
      function GetGoalString() : String;
      
      function GetGoal() : int;
      
      function CleanUpConfigData() : void;
   }
}
