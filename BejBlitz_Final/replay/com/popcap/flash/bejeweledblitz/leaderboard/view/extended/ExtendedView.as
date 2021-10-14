package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IPlayerDataLoadHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.basic.Entry;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseExtendedView;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ExtendedView extends BaseExtendedView implements IInterfaceComponent, IPlayerDataLoadHandler, IDataUpdaterHandler
   {
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Header:Entry;
      
      public var stats:StatsView;
      
      protected var m_PlayerData1:PlayerData = null;
      
      protected var m_PlayerData2:PlayerData = null;
      
      public var tooltipView:TooltipView;
      
      public function ExtendedView(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_Header = new Entry(this.m_App,this.m_Leaderboard,Entry.FLIP_POLICY_NONE);
         this.stats = new StatsView(this.m_App,this.m_Leaderboard);
         this.tooltipView = new TooltipView(this.m_Leaderboard);
      }
      
      public function Init() : void
      {
         addChild(this.m_Header);
         addChild(this.stats);
         addChild(this.tooltipView);
         this.m_Header.Init();
         this.stats.Init();
         this.tooltipView.Init();
         this.m_Header.x = anchorEntry.x;
         this.m_Header.y = anchorEntry.y + this.m_Header.height * 0.5;
         this.stats.x = anchorStats.x;
         this.stats.y = anchorStats.y;
         this.m_Header.addEventListener(MouseEvent.CLICK,this.HandleHeaderClick);
      }
      
      public function Reset() : void
      {
         this.m_PlayerData1 = null;
         this.m_PlayerData2 = null;
         this.m_Header.Reset();
         this.stats.Reset();
         this.tooltipView.Reset();
      }
      
      public function SetPlayerData(data:PlayerData, friendData:PlayerData = null) : void
      {
         this.m_PlayerData1 = data;
         this.m_PlayerData2 = friendData;
         this.stats.Reset();
         this.m_Leaderboard.updater.RequestExtendedXML(data.fuid);
         this.m_PlayerData1.AddLoadCompleteHandler(this);
         if(this.m_PlayerData2)
         {
            this.m_PlayerData2.AddLoadCompleteHandler(this);
         }
      }
      
      public function GetHeaderBounds(targetSpace:DisplayObject) : Rectangle
      {
         return this.m_Header.getRect(targetSpace);
      }
      
      public function GetDisplayedFUID() : String
      {
         if(!this.m_PlayerData1)
         {
            return "";
         }
         return this.m_PlayerData1.fuid;
      }
      
      public function HandleExtendedPlayerDataLoaded(data:PlayerData) : void
      {
         if(data == this.m_PlayerData1)
         {
            this.m_Header.SetPlayerData(data);
         }
         if(this.m_PlayerData1.IsExtendedDataLoaded() && (!this.m_PlayerData2 || this.m_PlayerData2.IsExtendedDataLoaded()))
         {
            this.stats.SetPlayerData(this.m_PlayerData1,this.m_PlayerData2);
         }
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
         this.m_Header.SetPlayerData(this.m_PlayerData1);
         this.stats.SetPlayerData(this.m_PlayerData1,this.m_PlayerData2);
      }
      
      protected function HandleHeaderClick(event:MouseEvent) : void
      {
         this.m_Leaderboard.viewManager.ShowBasicView();
      }
   }
}
