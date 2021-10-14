package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.TokenAwardRewardStrategy;
   
   public class TokenRewardBuilder extends BaseRewardBuilder
   {
      
      public static const ID1:String = "token";
      
      public static const ID2:String = "token_message";
       
      
      public function TokenRewardBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         var _loc4_:String = null;
         if(!CanHandle(param1,ID1,ID2))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_REWARD_VAL1]);
         if(_loc3_ == 1)
         {
            _loc4_ = "%tokens% Token";
         }
         else
         {
            _loc4_ = "%tokens% Tokens";
         }
         return new TokenAwardRewardStrategy(m_App,_loc3_,param2,_loc4_);
      }
   }
}
