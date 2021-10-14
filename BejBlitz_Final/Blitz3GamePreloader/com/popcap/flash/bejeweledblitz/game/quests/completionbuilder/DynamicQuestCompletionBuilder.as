package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   
   public class DynamicQuestCompletionBuilder
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_Builders:Vector.<IQuestCompletionBuilder>;
      
      public function DynamicQuestCompletionBuilder(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_Builders = new Vector.<IQuestCompletionBuilder>();
         this.CreateBuilders();
      }
      
      public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         var _loc3_:IQuestCompletionBuilder = null;
         var _loc4_:IQuestCompletionStrategy = null;
         for each(_loc3_ in this.m_Builders)
         {
            if((_loc4_ = _loc3_.BuildQuestCompletionStrategy(param1,param2)) != null)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      private function CreateBuilders() : void
      {
         this.m_Builders.push(new BlazingSpeedCompletionBuilder(this.m_App));
         this.m_Builders.push(new HighScoreCompletionBuilder(this.m_App));
         this.m_Builders.push(new MinimumScoreCompletionBuilder(this.m_App));
         this.m_Builders.push(new NBoostedGamesCompletionBuilder(this.m_App));
         this.m_Builders.push(new NDestroyedByDetonatorCompletionBuilder(this.m_App));
         this.m_Builders.push(new NGamesWithoutErrorCompletionBuilder(this.m_App));
         this.m_Builders.push(new NGemsDestroyedCompletionBuilder(this.m_App));
         this.m_Builders.push(new NPartyGamesCompletionBuilder(this.m_App));
         this.m_Builders.push(new NPowerGemsCompletionBuilder(this.m_App));
         this.m_Builders.push(new NPowerGemsDestroyedCompletionBuilder(this.m_App));
         this.m_Builders.push(new NRareGemGamesCompletionBuilder(this.m_App));
         this.m_Builders.push(new NStarMedalCompletionBuilder(this.m_App));
         this.m_Builders.push(new NTypeOfMultiplierDestroyedCompletionBuilder(this.m_App));
         this.m_Builders.push(new ScoreRangeCompletionBuilder(this.m_App));
         this.m_Builders.push(new ScoreWithBoostCompletionBuilder(this.m_App));
         this.m_Builders.push(new ScoreWithRareGemCompletionBuilder(this.m_App));
         this.m_Builders.push(new UseBoostAtCertainTimeCompletionBuilder(this.m_App));
      }
   }
}
