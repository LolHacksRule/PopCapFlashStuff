package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NDestroyedByDetonatorCompletionStrategy;
   
   public class NDestroyedByDetonatorCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("DestroyWithDetonator");
         IDS.push("DestoryWithDetonator");
      }
      
      public function NDestroyedByDetonatorCompletionBuilder(param1:Blitz3Game)
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
         var _loc4_:String = param1[QuestConstants.KEY_COMPLETION_VAL2];
         var _loc7_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NDestroyedByDetonatorCompletionStrategy(m_App,_loc3_,_loc4_,_loc7_,"%cur% of %max%","Destroy %max% %gemtype% with Detonator");
      }
   }
}
