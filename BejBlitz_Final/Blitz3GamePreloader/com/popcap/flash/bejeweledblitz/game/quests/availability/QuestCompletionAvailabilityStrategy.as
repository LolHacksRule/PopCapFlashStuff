package com.popcap.flash.bejeweledblitz.game.quests.availability
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   
   public class QuestCompletionAvailabilityStrategy implements IQuestAvailabilityStrategy
   {
       
      
      private var m_QuestManager:QuestManager;
      
      private var m_RequiredQuestId:String;
      
      public function QuestCompletionAvailabilityStrategy(param1:QuestManager, param2:String)
      {
         super();
         this.m_QuestManager = param1;
         this.m_RequiredQuestId = param2;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function IsQuestAvailable() : Boolean
      {
         var _loc1_:Quest = this.m_QuestManager.GetQuest(this.m_RequiredQuestId);
         if(_loc1_ != null && !_loc1_.IsComplete())
         {
            return false;
         }
         return true;
      }
   }
}
