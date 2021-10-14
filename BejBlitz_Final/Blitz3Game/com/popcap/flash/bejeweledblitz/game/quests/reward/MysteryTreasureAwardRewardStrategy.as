package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   
   public class MysteryTreasureAwardRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_Network:Blitz3Network;
      
      private var m_RewardString:String;
      
      private var m_InitialLevel:int;
      
      public function MysteryTreasureAwardRewardStrategy(param1:Blitz3Network, param2:String)
      {
         super();
         this.m_Network = param1;
         this.m_RewardString = param2;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         if(!param1)
         {
            this.m_Network.RefreshMessageCenter();
         }
      }
      
      public function GetRewardString() : String
      {
         return this.m_RewardString;
      }
      
      public function getRewardType() : String
      {
         return QuestConstants.QUEST_REWARD_TYPE_MYSTERY_TREASURE;
      }
   }
}
