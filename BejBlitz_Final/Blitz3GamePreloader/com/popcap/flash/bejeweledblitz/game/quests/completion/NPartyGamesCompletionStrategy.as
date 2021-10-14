package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   
   public class NPartyGamesCompletionStrategy extends NGamesCompletionStrategy
   {
       
      
      public function NPartyGamesCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function HandleGameEnd() : void
      {
         if(!m_Quest.IsActive() || !m_App.isMultiplayerGame())
         {
            return;
         }
         ++m_GamesComplete;
         var _loc1_:Object = QuestConstants.SanitizeQuestObject(m_ConfigManager.GetObj(m_QuestConfigId));
         _loc1_[QuestConstants.KEY_PROGRESS] = "" + m_GamesComplete;
         m_ConfigManager.SetObj(m_QuestConfigId,_loc1_);
      }
   }
}
