package com.popcap.flash.bejeweledblitz.game.quests.availability
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   
   public class FeatureAvailabilityStrategy implements IQuestAvailabilityStrategy
   {
       
      
      private var m_FeatureManager:FeatureManager;
      
      private var m_FeatureId:String;
      
      public function FeatureAvailabilityStrategy(param1:FeatureManager, param2:String)
      {
         super();
         this.m_FeatureManager = param1;
         this.m_FeatureId = param2;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function IsQuestAvailable() : Boolean
      {
         return this.m_FeatureManager.isFeatureEnabled(this.m_FeatureId);
      }
   }
}
