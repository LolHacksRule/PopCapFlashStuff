package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.NullRewardStrategy;
   
   public class SuperMysteryTreasureRewardBuilder extends BaseRewardBuilder
   {
      
      public static const ID:String = "superMystery";
       
      
      public function SuperMysteryTreasureRewardBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         if(!CanHandle(param1,ID))
         {
            return null;
         }
         return new NullRewardStrategy("<font size=\'-2\'>Grand Treasure</font>");
      }
   }
}
