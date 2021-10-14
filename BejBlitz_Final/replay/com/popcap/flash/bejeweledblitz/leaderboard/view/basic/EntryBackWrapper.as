package com.popcap.flash.bejeweledblitz.leaderboard.view.basic
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.ButtonUtils;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.extended.LevelCrest;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.EntryBack;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class EntryBackWrapper implements IInterfaceComponent
   {
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_PlayerData:PlayerData;
      
      protected var m_Back:EntryBack;
      
      protected var m_LevelCrest:LevelCrest;
      
      public function EntryBackWrapper(app:App, leaderboard:LeaderboardWidget, back:EntryBack)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_Back = back;
         this.m_LevelCrest = new LevelCrest(leaderboard,0);
      }
      
      public function Init() : void
      {
         this.m_Back.btnExtendedStats.txtTitle.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_BUTTON_STATS);
         ButtonUtils.AddButtonListeners(this.m_Back.btnExtendedStats);
         this.m_Back.btnJewelJabber.visible = false;
         this.m_Back.clipJabberDisabled.visible = false;
         this.m_Back.btnExtendedStats.addEventListener(MouseEvent.CLICK,this.HandleStatsClick);
         this.m_Back.addChild(this.m_LevelCrest);
         this.m_LevelCrest.x = this.m_Back.anchorLevelCrest.x;
         this.m_LevelCrest.y = this.m_Back.anchorLevelCrest.y;
         this.m_LevelCrest.Init();
      }
      
      public function Reset() : void
      {
         this.m_LevelCrest.Reset();
      }
      
      public function SetPlayerData(data:PlayerData, parentWidth:Number, parentRect:Rectangle) : void
      {
         this.m_PlayerData = data;
         this.m_LevelCrest.SetPlayerData(data);
      }
      
      protected function HandleStatsClick(event:MouseEvent) : void
      {
         var otherData:PlayerData = null;
         if(this.m_PlayerData.fuid != this.m_Leaderboard.curPlayerFUID)
         {
            otherData = this.m_Leaderboard.highScoreList.GetPlayerData(this.m_Leaderboard.curPlayerFUID);
         }
         this.m_Leaderboard.viewManager.ShowExtendedView(this.m_PlayerData,otherData);
      }
   }
}
