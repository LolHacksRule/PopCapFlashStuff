package com.popcap.flash.bejeweledblitz.game.quests.reward
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.session.UserData;
   import com.popcap.flash.framework.utils.StringUtils;
   
   public class TokenAwardRewardStrategy implements IQuestRewardStrategy
   {
       
      
      private var m_UserData:UserData;
      
      private var m_CoinAmount:int;
      
      private var m_CanAward:Boolean;
      
      private var m_RewardString:String;
      
      private var m_OnlyOnForced:Boolean;
      
      public function TokenAwardRewardStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String)
      {
         super();
         this.m_UserData = param1.sessionData.userData;
         this.m_CoinAmount = param2;
         this.m_RewardString = param4.replace("%tokens%",StringUtils.InsertNumberCommas(this.m_CoinAmount));
         var _loc5_:Object = QuestConstants.SanitizeQuestObject(param1.sessionData.configManager.GetObj(param3));
         this.m_CanAward = !_loc5_[QuestConstants.KEY_IS_COMPLETE];
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function DoQuestComplete(param1:Boolean) : void
      {
         if(!this.m_CanAward || this.m_OnlyOnForced && !param1)
         {
            return;
         }
         this.m_UserData.currencyManager.AddCurrencyByType(this.m_CoinAmount,CurrencyManager.TYPE_COINS);
      }
      
      public function GetRewardString() : String
      {
         return this.m_RewardString;
      }
      
      public function getRewardType() : String
      {
         return QuestConstants.QUEST_REWARD_TYPE_TOKENS;
      }
   }
}
