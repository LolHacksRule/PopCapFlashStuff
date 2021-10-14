package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NPartyGamesCompletionStrategy;
   
   public class NPartyGamesCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("PartyGames");
      }
      
      public function NPartyGamesCompletionBuilder(param1:Blitz3Game)
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
         var _loc6_:String = "Play %max% Blitz Party Games";
         if(_loc3_ == 1)
         {
            _loc6_ = "Play 1 Blitz Party Game";
         }
         var _loc7_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NPartyGamesCompletionStrategy(m_App,_loc3_,_loc7_,"%cur% of %max%",_loc6_);
      }
   }
}
