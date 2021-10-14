package com.popcap.flash.bejeweledblitz.leaderboard.view
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.basic.BasicView;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.error.ErrorScreen;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.extended.ExtendedView;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.invite.InviteView;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.loading.LoadingScreen;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.tourneyrefresh.TourneyRefreshScreen;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.PrimaryBackground;
   import flash.display.Sprite;
   
   public class ViewManager extends Sprite implements IInterfaceComponent
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Background:PrimaryBackground;
      
      protected var m_InviteView:InviteView;
      
      public var basicView:BasicView;
      
      public var extendedView:ExtendedView;
      
      protected var m_LoadingScreen:LoadingScreen;
      
      public var tourneyRefreshScreen:TourneyRefreshScreen;
      
      protected var m_ErrorScreen:ErrorScreen;
      
      protected var m_Handlers:Vector.<IViewManagerHandler>;
      
      public function ViewManager(app:Blitz3App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_Background = new PrimaryBackground();
         this.m_InviteView = new InviteView(this.m_App,this.m_Leaderboard);
         this.basicView = new BasicView(this.m_App,this.m_Leaderboard);
         this.extendedView = new ExtendedView(this.m_App,this.m_Leaderboard);
         this.m_LoadingScreen = new LoadingScreen(this.m_App,this.m_Leaderboard);
         this.tourneyRefreshScreen = new TourneyRefreshScreen(this.m_App,this.m_Leaderboard);
         this.m_ErrorScreen = new ErrorScreen(this.m_App,this.m_Leaderboard);
         this.m_Handlers = new Vector.<IViewManagerHandler>();
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_InviteView);
         addChild(this.basicView);
         addChild(this.extendedView);
         addChild(this.m_LoadingScreen);
         addChild(this.tourneyRefreshScreen);
         addChild(this.m_ErrorScreen);
         this.m_InviteView.x = 8;
         this.m_InviteView.y = this.basicView.y + this.basicView.height + 5;
         this.basicView.x = 2 + this.basicView.width * 0.5;
         this.extendedView.x = 21 + this.extendedView.width * 0.5;
         this.m_InviteView.Init();
         this.basicView.Init();
         this.extendedView.Init();
         this.m_LoadingScreen.Init();
         this.tourneyRefreshScreen.Init();
         this.m_ErrorScreen.Init();
         this.ShowBasicView();
      }
      
      public function Reset() : void
      {
         this.m_InviteView.Reset();
         this.basicView.Reset();
         this.extendedView.Reset();
         this.m_LoadingScreen.Reset();
         this.tourneyRefreshScreen.Init();
         this.m_ErrorScreen.Reset();
      }
      
      public function ShowBasicView() : void
      {
         this.basicView.OnShow();
         this.basicView.visible = true;
         this.extendedView.visible = false;
         this.DispatchShowBasicView();
      }
      
      public function ShowExtendedView(data:PlayerData, friendData:PlayerData = null) : void
      {
         this.extendedView.Reset();
         this.extendedView.SetPlayerData(data,friendData);
         this.basicView.visible = false;
         this.extendedView.visible = true;
         this.DispatchShowExtendedView();
      }
      
      public function AddHandler(handler:IViewManagerHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      protected function DispatchShowBasicView() : void
      {
         var handler:IViewManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleShowBasicView();
         }
      }
      
      protected function DispatchShowExtendedView() : void
      {
         var handler:IViewManagerHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleShowExtendedView();
         }
      }
   }
}
