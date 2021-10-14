package com.popcap.flash.bejeweledblitz.leaderboard.view.tourneyrefresh
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.ButtonUtils;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseTourneyRefreshScreen;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.events.MouseEvent;
   
   public class TourneyRefreshScreen extends BaseTourneyRefreshScreen implements IInterfaceComponent
   {
       
      
      protected var m_App:App;
      
      private var m_Leaderboard:LeaderboardWidget;
      
      public function TourneyRefreshScreen(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         visible = false;
      }
      
      public function Init() : void
      {
         txtMessage.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_TOURNEY_REFRESH_MSG);
         btnRefresh.txtRefresh.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_TOURNEY_REFRESH_BTN);
         ButtonUtils.AddButtonListeners(btnRefresh);
         btnRefresh.addEventListener(MouseEvent.CLICK,this.HandleRefreshClick);
      }
      
      public function Reset() : void
      {
         visible = false;
      }
      
      protected function HandleRefreshClick(event:MouseEvent) : void
      {
         this.m_Leaderboard.pageInterface.RefreshPage();
      }
   }
}
