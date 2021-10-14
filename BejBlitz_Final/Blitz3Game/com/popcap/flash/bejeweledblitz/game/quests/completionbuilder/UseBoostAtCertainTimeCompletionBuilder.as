package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.UseBoostAtCertainTimeCompletionStrategy;
   
   public class UseBoostAtCertainTimeCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("UseBoostAtCertainTime");
         IDS.push("UsedBoostAtCertainTime");
      }
      
      public function UseBoostAtCertainTimeCompletionBuilder(param1:Blitz3Game)
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
         var _loc5_:String = m_App.sessionData.boostV2Manager.getBoostV2FromBoostId(_loc4_) != null ? _loc4_ : "";
         var _loc7_:String = (_loc7_ = (_loc7_ = "Use %boost% Boost at %time% seconds").replace(/%boost%/g,_loc5_)).replace(/%time%/g,_loc3_);
         var _loc8_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new UseBoostAtCertainTimeCompletionStrategy(m_App,_loc3_ * 100,_loc4_,_loc8_,"",_loc7_);
      }
   }
}
