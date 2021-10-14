package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.UserData;
   import com.popcap.flash.framework.utils.StringUtils;
   
   public class SimpleSpinRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_UserData:UserData;
      
      private var m_SpinAmount:int;
      
      private var m_RewardString:String;
      
      private var _rewardType:String;
      
      public function SimpleSpinRewardStrategy(param1:UserData, param2:int, param3:String, param4:String)
      {
         super();
         this._rewardType = param4;
         this.m_UserData = param1;
         this.m_SpinAmount = param2;
         this.m_RewardString = param3.replace("%spins%",StringUtils.InsertNumberCommas(this.m_SpinAmount));
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         if(this._rewardType == QuestConstants.QUEST_REWARD_TYPE_SPIN)
         {
            this.m_UserData.SetSpins(this.m_SpinAmount);
         }
      }
      
      public function GetRewardString() : String
      {
         return this.m_RewardString;
      }
      
      public function getRewardType() : String
      {
         return this._rewardType;
      }
   }
}
