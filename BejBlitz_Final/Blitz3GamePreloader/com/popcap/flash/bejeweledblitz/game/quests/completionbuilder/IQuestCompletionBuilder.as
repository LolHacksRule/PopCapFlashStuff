package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   
   public interface IQuestCompletionBuilder
   {
       
      
      function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy;
   }
}
