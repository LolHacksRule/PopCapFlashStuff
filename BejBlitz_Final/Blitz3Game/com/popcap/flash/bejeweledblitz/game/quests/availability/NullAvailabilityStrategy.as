package com.popcap.flash.bejeweledblitz.game.quests.availability
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public class NullAvailabilityStrategy implements IQuestAvailabilityStrategy
   {
       
      
      private var m_IsAvailable:Boolean;
      
      public function NullAvailabilityStrategy(param1:Boolean = true)
      {
         super();
         this.m_IsAvailable = param1;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function IsQuestAvailable() : Boolean
      {
         return this.m_IsAvailable;
      }
   }
}
