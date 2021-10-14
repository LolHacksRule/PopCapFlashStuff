package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.MinimumScoreCompletionStrategy;
   
   public class MinimumScoreCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("ScorePoints");
      }
      
      public function MinimumScoreCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         if(!CanHandleList(param1,IDS))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         var _loc6_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new MinimumScoreCompletionStrategy(m_App.logic,m_App.sessionData.configManager,_loc3_,_loc6_,"","Score over<br><font color=\'#b0017d\'>%min%</font> points");
      }
   }
}
