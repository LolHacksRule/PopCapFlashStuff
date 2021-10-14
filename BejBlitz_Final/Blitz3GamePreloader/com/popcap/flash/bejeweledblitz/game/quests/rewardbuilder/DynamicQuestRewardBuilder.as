package com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   
   public class DynamicQuestRewardBuilder
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_Builders:Vector.<IQuestRewardBuilder>;
      
      public function DynamicQuestRewardBuilder(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_Builders = new Vector.<IQuestRewardBuilder>();
         this.CreateBuilders();
      }
      
      public function BuildQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         var _loc3_:IQuestRewardBuilder = null;
         var _loc4_:IQuestRewardStrategy = null;
         for each(_loc3_ in this.m_Builders)
         {
            if((_loc4_ = _loc3_.BuildQuestRewardStrategy(param1,param2)) != null)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      private function CreateBuilders() : void
      {
         this.m_Builders.push(new SpinRewardBuilder(this.m_App));
         this.m_Builders.push(new TokenRewardBuilder(this.m_App));
         this.m_Builders.push(new CoinRewardBuilder(this.m_App));
         this.m_Builders.push(new XPRewardBuilder(this.m_App));
         this.m_Builders.push(new FreeRareGemRewardBuilder(this.m_App));
         this.m_Builders.push(new RareGemOfferRewardBuilder(this.m_App));
         this.m_Builders.push(new MysteryTreasureRewardBuilder(this.m_App));
         this.m_Builders.push(new SuperMysteryTreasureRewardBuilder(this.m_App));
         this.m_Builders.push(new MegaMysteryTreasureRewardBuilder(this.m_App));
      }
   }
}
