package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.ScoreRangeCompletionStrategy;
   
   public class ScoreRangeCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("ScoreBetweenInOneGame");
         IDS.push("ScoreBetweenInOneGameB");
      }
      
      public function ScoreRangeCompletionBuilder(param1:Blitz3Game)
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
         var _loc4_:int = _loc3_ + parseInt(param1[QuestConstants.KEY_COMPLETION_VAL2]);
         var _loc7_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new ScoreRangeCompletionStrategy(m_App.logic,m_App.sessionData.configManager,_loc3_,_loc4_,_loc7_,"","Score between <font color=\'#b0017d\'>%min%</font> and <font color=\'#b0017d\'>%max%</font>");
      }
   }
}
