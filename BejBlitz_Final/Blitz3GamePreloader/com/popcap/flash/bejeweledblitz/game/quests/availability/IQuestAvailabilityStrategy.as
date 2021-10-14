package com.popcap.flash.bejeweledblitz.game.quests.availability
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public interface IQuestAvailabilityStrategy
   {
       
      
      function SetQuest(param1:Quest) : void;
      
      function IsQuestAvailable() : Boolean;
   }
}
