package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   
   public class BaseRewardBuilder implements IQuestRewardBuilder
   {
       
      
      protected var m_App:Blitz3Game;
      
      public function BaseRewardBuilder(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
      }
      
      public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         return null;
      }
      
      protected function CanHandle(param1:Object, param2:String, param3:String = "") : Boolean
      {
         if(!(QuestConstants.KEY_REWARD_TYPE in param1))
         {
            return false;
         }
         var _loc4_:String;
         return (_loc4_ = param1[QuestConstants.KEY_REWARD_TYPE]) == param2 || _loc4_ == param3;
      }
   }
}
