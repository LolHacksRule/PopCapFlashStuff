package com.popcap.flash.bejeweledblitz.leaderboard.view.loading
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseLoadingScreen;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   
   public class LoadingScreen extends BaseLoadingScreen implements IInterfaceComponent, IDataUpdaterHandler
   {
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      public function LoadingScreen(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
      }
      
      public function Init() : void
      {
         txtLoading.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_LOADING);
         this.m_Leaderboard.updater.AddHandler(this);
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
      }
      
      public function HandleBasicLoadBegin() : void
      {
         visible = true;
      }
      
      public function HandleBasicLoadComplete() : void
      {
         visible = false;
      }
      
      public function HandleBasicLoadError() : void
      {
      }
      
      public function HandleExtendedLoadBegin(fuid1:String, fuid2:String) : void
      {
         visible = true;
      }
      
      public function HandleExtendedLoadComplete(fuid1:String, fuid2:String) : void
      {
         visible = false;
      }
      
      public function HandleExtendedLoadError() : void
      {
      }
      
      public function HandleScoreUpdated(newScore:int) : void
      {
      }
   }
}
