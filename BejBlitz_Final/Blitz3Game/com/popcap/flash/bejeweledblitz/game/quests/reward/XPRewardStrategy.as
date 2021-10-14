package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.UserData;
   import com.popcap.flash.framework.utils.StringUtils;
   
   public class XPRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_UserData:UserData;
      
      private var m_XPAmount:int;
      
      private var m_RewardString:String;
      
      public function XPRewardStrategy(param1:UserData, param2:int, param3:String)
      {
         super();
         this.m_UserData = param1;
         this.m_XPAmount = param2;
         this.m_RewardString = param3.replace("%xp%",StringUtils.InsertNumberCommas(this.m_XPAmount));
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
         return QuestConstants.QUEST_REWARD_TYPE_XP;
      }
   }
}
