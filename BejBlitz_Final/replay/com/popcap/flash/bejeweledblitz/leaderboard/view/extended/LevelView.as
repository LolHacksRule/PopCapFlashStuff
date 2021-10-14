package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseLevelView;
   import flash.events.MouseEvent;
   
   public class LevelView extends BaseLevelView implements IInterfaceComponent, IDataUpdaterHandler
   {
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_XPBar:XPBar;
      
      protected var m_LevelCrest:LevelCrest;
      
      protected var m_Data:PlayerData;
      
      public function LevelView(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_XPBar = new XPBar(this.m_App,this.m_Leaderboard,anchorXPBarBottomRight.x - anchorXPBarTopLeft.x,anchorXPBarBottomRight.y - anchorXPBarTopLeft.y);
         this.m_LevelCrest = new LevelCrest(leaderboard);
      }
      
      public function Init() : void
      {
         addChild(this.m_XPBar);
         addChild(this.m_LevelCrest);
         this.m_XPBar.x = anchorXPBarTopLeft.x - XPBar.FRAME_SIZE;
         this.m_XPBar.y = anchorXPBarTopLeft.y;
         this.m_LevelCrest.x = anchorLevelCrest.x;
         this.m_LevelCrest.y = anchorLevelCrest.y;
         this.m_XPBar.Init();
         this.m_LevelCrest.Init();
         this.m_Leaderboard.updater.AddHandler(this);
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function Reset() : void
      {
         this.m_XPBar.Reset();
         this.m_LevelCrest.Reset();
      }
      
      public function SetPlayerData(data:PlayerData) : void
      {
         this.m_Data = data;
         this.m_XPBar.SetPlayerData(data);
         this.m_LevelCrest.SetPlayerData(data);
      }
      
      public function HandleBasicLoadBegin() : void
      {
      }
      
      public function HandleBasicLoadComplete() : void
      {
      }
      
      public function HandleBasicLoadError() : void
      {
      }
      
      public function HandleExtendedLoadBegin(fuid1:String, fuid2:String) : void
      {
      }
      
      public function HandleExtendedLoadComplete(fuid1:String, fuid2:String) : void
      {
      }
      
      public function HandleExtendedLoadError() : void
      {
      }
      
      public function HandleScoreUpdated(newScore:int) : void
      {
         if(!this.m_Data)
         {
            return;
         }
         this.m_XPBar.SetPlayerData(this.m_Data,true);
         this.m_LevelCrest.SetPlayerData(this.m_Data);
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         if(this.m_Data)
         {
            this.m_Data.xp += 25000;
            this.m_Data.RecalcLevel();
            this.SetPlayerData(this.m_Data);
         }
      }
   }
}
