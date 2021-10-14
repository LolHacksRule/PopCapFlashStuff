package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.DataUpdater;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.HighScoreList;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PageInterface;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.ViewManager;
   import flash.display.Sprite;
   
   public class LeaderboardWidget extends Sprite implements IDataUpdaterHandler
   {
       
      
      private var m_App:Blitz3Game;
      
      public var isActive:Boolean;
      
      public var curPlayerFUID:String;
      
      public var highScoreList:HighScoreList;
      
      public var updater:DataUpdater;
      
      public var viewManager:ViewManager;
      
      public var pageInterface:PageInterface;
      
      protected var m_IsCurPlayerDataRequested:Boolean = false;
      
      public function LeaderboardWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.updater = new DataUpdater(this.m_App,this,this.m_App.network.parameters);
         this.highScoreList = new HighScoreList(this.m_App,this);
         this.viewManager = new ViewManager(this.m_App,this);
         this.pageInterface = new PageInterface(this.m_App);
      }
      
      public function Init() : void
      {
         this.curPlayerFUID = "17701854";
         this.curPlayerFUID = this.m_App.sessionData.userData.GetFUID();
         addChild(this.viewManager);
         this.viewManager.Init();
         this.updater.AddHandler(this);
         this.updater.RequestBasicXML();
         x = Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH;
         this.isActive = true;
      }
      
      public function Show() : void
      {
         visible = true;
         mouseChildren = true;
      }
      
      public function Hide() : void
      {
         visible = false;
         mouseChildren = false;
      }
      
      public function HandleBasicLoadBegin() : void
      {
      }
      
      public function HandleBasicLoadComplete() : void
      {
         if(this.m_IsCurPlayerDataRequested)
         {
            return;
         }
         this.updater.RequestExtendedXML(this.curPlayerFUID);
         this.m_IsCurPlayerDataRequested = true;
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
      }
   }
}
