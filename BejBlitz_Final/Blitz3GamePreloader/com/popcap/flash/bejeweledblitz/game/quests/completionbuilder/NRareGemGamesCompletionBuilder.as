package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NRareGemGamesCompletionStrategy;
   
   public class NRareGemGamesCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("RareGemGames");
      }
      
      public function NRareGemGamesCompletionBuilder(param1:Blitz3Game)
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
         var _loc5_:String = m_App.sessionData.rareGemManager.GetLocalizedRareGemName(_loc4_);
         if(_loc3_ == 1)
         {
            _loc7_ = "Play 1 Game";
         }
         else
         {
            _loc7_ = "Play %max% Games";
         }
         _loc7_ = (_loc7_ += " with<br>%raregem%").replace(/%raregem%/g,_loc5_);
         var _loc8_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NRareGemGamesCompletionStrategy(m_App,_loc3_,_loc8_,"%cur% of %max%",_loc7_,_loc4_);
      }
   }
}
