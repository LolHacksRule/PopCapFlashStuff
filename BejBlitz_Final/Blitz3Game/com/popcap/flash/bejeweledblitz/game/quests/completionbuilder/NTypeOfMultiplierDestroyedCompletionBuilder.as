package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.MultiplierDestroyedCompletionStrategy;
   
   public class NTypeOfMultiplierDestroyedCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("DestroyMultiplier");
         IDS.push("DestroyMultiplierAny");
         IDS.push("DestroyMultiplierInOneGame");
      }
      
      public function NTypeOfMultiplierDestroyedCompletionBuilder(param1:Blitz3Game)
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
         var _loc5_:int = param1[QuestConstants.KEY_COMPLETION_TYPE].indexOf("InOneGame");
         var _loc7_:* = "Match <font color=\'#b0017d\'>%max%</font> %multi% %gemtype%";
         if(_loc5_ > 0)
         {
            _loc7_ += " in one game";
         }
         var _loc8_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new MultiplierDestroyedCompletionStrategy(m_App,_loc3_,_loc4_,_loc8_,"%cur% of %max%",_loc7_,_loc5_);
      }
   }
}
