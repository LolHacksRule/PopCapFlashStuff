package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NBoostedGamesCompletionStrategy;
   
   public class NBoostedGamesCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("BoostedGames");
      }
      
      public function NBoostedGamesCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         var _loc7_:* = null;
         if(!CanHandleList(param1,IDS))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         var _loc4_:String = param1[QuestConstants.KEY_COMPLETION_VAL2];
         var _loc5_:String = m_App.sessionData.boostV2Manager.getBoostV2FromBoostId(_loc4_) != null ? _loc4_ : "";
         if(_loc3_ == 1)
         {
            _loc7_ = "Play 1 Game";
         }
         else
         {
            _loc7_ = "Play %max% Games";
         }
         _loc7_ = (_loc7_ += " with %boost% Boost").replace(/%boost%/g,_loc5_);
         var _loc8_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NBoostedGamesCompletionStrategy(m_App,_loc3_,_loc8_,"%cur% of %max%",_loc7_,m_App.sessionData.boostV2Manager,_loc4_);
      }
   }
}
