package com.popcap.flash.bejeweledblitz.game.quests.expirary
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public interface IQuestExpiraryStrategy
   {
       
      
      function SetQuest(param1:Quest) : void;
      
      function HasQuestExpired() : Boolean;
      
      function GetExpiraryString() : String;
      
      function timeLeft() : int;
   }
}
