package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.StarMedalCompletionStrategy;
   
   public class NStarMedalCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("GetStarMedals");
      }
      
      public function NStarMedalCompletionBuilder(param1:Blitz3Game)
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
         var _loc5_:int = int(_loc4_.slice(0,-1)) * 1000;
         var _loc6_:int;
         if((_loc6_ = m_App.starMedalFactory.GetNextThreshold(_loc5_)) == -1)
         {
            _loc6_ = int.MAX_VALUE;
         }
         var _loc8_:String = (_loc8_ = "Get a <font color=\'#b0017d\'>%starmedal%</font> STAR MEDAL").replace(/%starmedal%/g,_loc4_);
         var _loc9_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new StarMedalCompletionStrategy(m_App.sessionData.configManager,m_App.logic,_loc5_,_loc6_,_loc3_,_loc9_,"",_loc8_);
      }
   }
}
