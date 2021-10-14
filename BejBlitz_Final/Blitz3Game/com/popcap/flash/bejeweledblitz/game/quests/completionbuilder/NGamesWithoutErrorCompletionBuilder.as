package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NGamesPlayedWithoutError;
   
   public class NGamesWithoutErrorCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const ID:String = "NoInvalidMoves";
       
      
      public function NGamesWithoutErrorCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         if(!CanHandle(param1,ID))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         var _loc4_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NGamesPlayedWithoutError(m_App,_loc3_,_loc4_,"%cur% of %max%","Play <font color=\'#b0017d\'>%max%</font> games without<br>making an invalid move");
      }
   }
}
