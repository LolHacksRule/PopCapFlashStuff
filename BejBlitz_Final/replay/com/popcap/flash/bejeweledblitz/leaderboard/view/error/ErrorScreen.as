package com.popcap.flash.bejeweledblitz.leaderboard.view.error
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.ButtonUtils;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseErrorScreen;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.events.MouseEvent;
   
   public class ErrorScreen extends BaseErrorScreen implements IInterfaceComponent, IDataUpdaterHandler
   {
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      public function ErrorScreen(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
      }
      
      public function Init() : void
      {
         txtTitle.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_ERROR_TITLE);
         txtDescription.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_ERROR_DESC);
         btnRefresh.txtRefresh.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_TOURNEY_REFRESH_BTN);
         ButtonUtils.AddButtonListeners(btnRefresh);
         this.m_Leaderboard.updater.AddHandler(this);
         btnRefresh.addEventListener(MouseEvent.CLICK,this.HandleRefreshClick);
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
      }
      
      public function HandleBasicLoadBegin() : void
      {
      }
      
      public function HandleBasicLoadComplete() : void
      {
      }
      
      public function HandleBasicLoadError() : void
      {
         visible = true;
      }
      
      public function HandleExtendedLoadBegin(fuid1:String, fuid2:String) : void
      {
      }
      
      public function HandleExtendedLoadComplete(fuid1:String, fuid2:String) : void
      {
      }
      
      public function HandleExtendedLoadError() : void
      {
         visible = true;
      }
      
      public function HandleScoreUpdated(newScore:int) : void
      {
      }
      
      protected function HandleRefreshClick(event:MouseEvent) : void
      {
         visible = false;
         this.m_Leaderboard.updater.RequestBasicXML();
      }
   }
}
