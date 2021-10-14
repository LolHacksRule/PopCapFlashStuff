package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   
   public class SpecificRareGemOfferRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_ConfigManager:ConfigManager;
      
      private var m_RareGemManager:RareGemManager;
      
      private var m_RareGemId:String;
      
      private var m_QuestConfigId:String;
      
      private var m_Delay:int;
      
      private var m_StreakNumber:int;
      
      private var m_CanAward:Boolean;
      
      public function SpecificRareGemOfferRewardStrategy(param1:ConfigManager, param2:RareGemManager, param3:String, param4:String, param5:int = -1, param6:int = 0)
      {
         super();
         this.m_ConfigManager = param1;
         this.m_RareGemManager = param2;
         this.m_RareGemId = param3;
         this.m_QuestConfigId = param4;
         this.m_Delay = param5;
         this.m_StreakNumber = param6;
         var _loc7_:Object = QuestConstants.SanitizeQuestObject(this.m_ConfigManager.GetObj(this.m_QuestConfigId));
         this.m_CanAward = !_loc7_[QuestConstants.KEY_IS_COMPLETE];
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         if(!this.m_CanAward || param1)
         {
            this.m_CanAward = false;
            return;
         }
         this.m_RareGemManager.ForceOffer(this.m_RareGemId,this.m_Delay,this.m_StreakNumber);
         this.m_CanAward = false;
      }
      
      public function GetRewardString() : String
      {
         return "";
      }
      
      public function getRewardType() : String
      {
         return this.m_RareGemId;
      }
   }
}
