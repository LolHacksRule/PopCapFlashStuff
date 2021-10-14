package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public interface IQuestRewardStrategy
   {
       
      
      function SetQuest(param1:Quest) : void;
      
      function DoQuestComplete(param1:Boolean) : void;
      
      function GetRewardString() : String;
      
      function getRewardType() : String;
   }
}
