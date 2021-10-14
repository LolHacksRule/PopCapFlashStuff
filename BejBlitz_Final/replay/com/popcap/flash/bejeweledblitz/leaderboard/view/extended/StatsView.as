package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseStatsView;
   
   public class StatsView extends BaseStatsView implements IInterfaceComponent
   {
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_MedalView:MedalView;
      
      protected var m_GraphView:GraphView;
      
      protected var m_LevelView:LevelView;
      
      public function StatsView(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_MedalView = new MedalView(this.m_App,this.m_Leaderboard);
         this.m_GraphView = new GraphView(this.m_App,this.m_Leaderboard);
         this.m_LevelView = new LevelView(this.m_App,this.m_Leaderboard);
      }
      
      public function Init() : void
      {
         addChild(this.m_MedalView);
         addChild(this.m_GraphView);
         addChild(this.m_LevelView);
         this.m_MedalView.x = anchorMedals.x;
         this.m_MedalView.y = anchorMedals.y;
         this.m_GraphView.x = anchorGraph.x;
         this.m_GraphView.y = anchorGraph.y;
         this.m_LevelView.x = anchorLevel.x;
         this.m_LevelView.y = anchorLevel.y;
         this.m_MedalView.Init();
         this.m_GraphView.Init();
         this.m_LevelView.Init();
      }
      
      public function Reset() : void
      {
         this.m_MedalView.Reset();
         this.m_GraphView.Reset();
         this.m_LevelView.Reset();
      }
      
      public function SetPlayerData(data:PlayerData, otherData:PlayerData = null) : void
      {
         this.m_MedalView.SetPlayerData(data);
         this.m_GraphView.SetPlayerData(data,otherData);
         this.m_LevelView.SetPlayerData(data);
      }
   }
}
