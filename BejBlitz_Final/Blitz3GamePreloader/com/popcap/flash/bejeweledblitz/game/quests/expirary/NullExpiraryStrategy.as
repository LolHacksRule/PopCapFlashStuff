package com.popcap.flash.bejeweledblitz.game.quests.expirary
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public class NullExpiraryStrategy implements IQuestExpiraryStrategy
   {
       
      
      public function NullExpiraryStrategy()
      {
         super();
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function HasQuestExpired() : Boolean
      {
         return false;
      }
      
      public function GetExpiraryString() : String
      {
         return "";
      }
      
      public function timeLeft() : int
      {
         return 1;
      }
   }
}
