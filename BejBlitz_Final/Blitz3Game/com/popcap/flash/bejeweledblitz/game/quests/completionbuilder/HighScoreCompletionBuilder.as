package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.completion.HighScoreCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayersData;
   
   public class HighScoreCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("BeatHighScore");
      }
      
      public function HighScoreCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         var _loc8_:int = 0;
         if(!CanHandleList(param1,IDS))
         {
            return null;
         }
         var _loc3_:int = m_App.network.GetHighScoreParam();
         var _loc4_:LeaderboardWidget;
         if((_loc4_ = m_App.mainmenuLeaderboard).isLoaded())
         {
            if((_loc8_ = PlayersData.getPlayerData(_loc4_.currentPlayerFUID).curTourneyData.score) > _loc3_)
            {
               _loc3_ = _loc8_;
            }
         }
         var _loc7_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new HighScoreCompletionStrategy(m_App.logic,m_App.sessionData.configManager,_loc3_,_loc7_,"","Beat your weekly High Score of <font color=\'#b0017d\'>%min%</font>");
      }
   }
}
