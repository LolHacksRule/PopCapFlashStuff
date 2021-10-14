package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   
   public class SimpleRareGemOfferRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_RareGemManager:RareGemManager;
      
      private var m_RareGemId:String;
      
      private var m_RewardString:String;
      
      private var m_Delay:int;
      
      private var m_StreakNumber:int;
      
      public function SimpleRareGemOfferRewardStrategy(param1:Blitz3App, param2:RareGemManager, param3:String, param4:String, param5:int = -1, param6:int = 0)
      {
         super();
         this.m_RareGemManager = param2;
         this.m_RareGemId = param3;
         this.m_Delay = param5;
         this.m_StreakNumber = param6;
         var _loc7_:String = param1.sessionData.rareGemManager.GetLocalizedRareGemName(param3);
         this.m_RewardString = param4;
         this.m_RewardString = this.m_RewardString.replace("%gem%",_loc7_);
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
      }
      
      public function GetRewardString() : String
      {
         return this.m_RewardString;
      }
      
      public function getRewardType() : String
      {
         return this.m_RareGemId;
      }
   }
}
