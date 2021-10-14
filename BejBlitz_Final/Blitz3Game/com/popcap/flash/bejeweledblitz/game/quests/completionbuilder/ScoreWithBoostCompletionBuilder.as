package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.CompoundCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.MinimumScoreCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NBoostedGamesCompletionStrategy;
   
   public class ScoreWithBoostCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("ScoreWithBoost");
      }
      
      public function ScoreWithBoostCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         if(!CanHandleList(param1,IDS))
         {
            return null;
         }
         var _loc4_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         var _loc5_:String = "with %boost% Boost";
         var _loc6_:String = param1[QuestConstants.KEY_COMPLETION_VAL2];
         var _loc7_:String = m_App.sessionData.boostV2Manager.getBoostV2FromBoostId(_loc6_) != null ? _loc6_ : "";
         _loc5_ = _loc5_.replace(/%boost%/g,_loc7_);
         var _loc8_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         var _loc9_:Vector.<IQuestCompletionStrategy>;
         (_loc9_ = new Vector.<IQuestCompletionStrategy>()).push(new MinimumScoreCompletionStrategy(m_App.logic,m_App.sessionData.configManager,_loc4_,_loc8_,"","Beat %min%"));
         _loc9_.push(new NBoostedGamesCompletionStrategy(m_App,1,_loc8_,"",_loc5_,m_App.sessionData.boostV2Manager,_loc6_));
         return new CompoundCompletionStrategy(_loc9_,true," ",true);
      }
   }
}
