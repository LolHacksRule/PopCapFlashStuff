package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.bej3.blitz.ScoreValue;
   import com.popcap.flash.games.blitz3.session.IUserDataHandler;
   import com.popcap.flash.games.blitz3.ui.widgets.levels.IXpBarHandler;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PostGameStatsWidget extends Sprite implements IBlitz3NetworkHandler, IXpBarHandler, IUserDataHandler
   {
      
      public static const TIMEOUT_TIME:int = 500;
       
      
      private var dummy:ScoreValue;
      
      public var window:StatsWindow;
      
      public var playAgainButton:PlayAgainButton;
      
      public var mainMenuButton:MainMenuButton;
      
      public var linkButton:LinkButton;
      
      public var submittingScoreMessage:SubmittingScoreMessage;
      
      public var levelUp:LevelUpWidget;
      
      public var showPlayAgainButton:Boolean;
      
      private var mApp:Blitz3Game;
      
      private var m_Timeout:int = 500;
      
      private var m_Handlers:Vector.<IPostGameStatsHandler>;
      
      public function PostGameStatsWidget(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.m_Handlers = new Vector.<IPostGameStatsHandler>();
         this.playAgainButton = new PlayAgainButton(app);
         this.mainMenuButton = new MainMenuButton(app);
         this.linkButton = new LinkButton(app);
         this.window = new StatsWindow(app);
         this.submittingScoreMessage = new SubmittingScoreMessage(app);
         this.levelUp = new LevelUpWidget(app);
      }
      
      public function Init() : void
      {
         this.linkButton.Init();
         this.playAgainButton.Init();
         this.mainMenuButton.Init();
         this.window.Init();
         this.submittingScoreMessage.Init();
         this.levelUp.Init();
         this.linkButton.x = 0;
         this.linkButton.y = 355;
         this.window.x = Blitz3Game.SCREEN_WIDTH / 2 - this.window.width / 2;
         this.window.y = Blitz3Game.SCREEN_HEIGHT / 2 - this.window.height / 2;
         this.playAgainButton.x = 180;
         this.playAgainButton.y = 345;
         this.mainMenuButton.x = 350;
         this.mainMenuButton.y = 345;
         this.submittingScoreMessage.x = this.linkButton.width / 2 - this.submittingScoreMessage.width / 2;
         this.submittingScoreMessage.y = this.linkButton.y - this.submittingScoreMessage.height - 10;
         addChild(this.window);
         addChild(this.playAgainButton);
         this.mApp.network.AddHandler(this);
         this.mApp.sessionData.userData.AddHandler(this);
         this.window.levelView.xpBar.AddHandler(this);
         this.playAgainButton.addEventListener(MouseEvent.CLICK,this.HandleContinueClicked);
      }
      
      public function Reset() : void
      {
         this.window.Reset();
         this.linkButton.Reset();
         this.submittingScoreMessage.Reset();
         this.levelUp.Reset();
         this.window.visible = true;
         this.linkButton.x = stage.stageWidth * 0.5 - this.linkButton.width * 0.5;
         this.linkButton.y = stage.stageHeight - this.linkButton.height - 5;
         this.window.x = Blitz3Game.SCREEN_WIDTH / 2 - this.window.width / 2;
         this.window.y = Blitz3Game.SCREEN_HEIGHT / 2 - this.window.height / 2;
         this.playAgainButton.x = 270;
         this.playAgainButton.y = 345;
         this.mainMenuButton.x = 350;
         this.mainMenuButton.y = 345;
         this.submittingScoreMessage.x = this.playAgainButton.x - this.submittingScoreMessage.width / 2;
         this.submittingScoreMessage.y = this.playAgainButton.y - this.submittingScoreMessage.height / 2;
         this.linkButton.visible = true;
         this.playAgainButton.SetEnabled(true);
         this.mainMenuButton.SetEnabled(true);
      }
      
      public function ResetButtonState() : void
      {
         this.showPlayAgainButton = false;
         this.playAgainButton.visible = false;
         this.mainMenuButton.visible = false;
         this.submittingScoreMessage.visible = true;
      }
      
      public function Update() : void
      {
         if(this.showPlayAgainButton)
         {
            this.playAgainButton.visible = true;
            this.mainMenuButton.visible = true;
            this.submittingScoreMessage.visible = false;
         }
         else
         {
            this.playAgainButton.visible = false;
            this.mainMenuButton.visible = true;
            this.submittingScoreMessage.visible = true;
            --this.m_Timeout;
            if(this.m_Timeout < 0)
            {
               this.OnTimeout();
               this.m_Timeout = TIMEOUT_TIME;
            }
         }
      }
      
      public function SetOffline(isOffline:Boolean) : void
      {
      }
      
      public function SetScores(values:Vector.<ScoreValue>, maxTime:int) : void
      {
         this.window.graph.SetScores(values,maxTime);
         this.window.UpdateTicks();
      }
      
      public function SetPowerGemCounts(flameGems:int, starGems:int, hypercubes:int) : void
      {
         this.window.flameCount.htmlText = "x" + flameGems;
         this.window.starCount.htmlText = "x" + starGems;
         this.window.hyperCount.htmlText = "x" + hypercubes;
      }
      
      public function AddMultiplier(time:int, value:int, color:int) : void
      {
         this.window.graph.AddMultiplier(time,value,color);
      }
      
      public function AddHandler(handler:IPostGameStatsHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         this.window.SetCoinBalance(balance);
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
         this.window.levelView.SetData(xp);
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
         this.showPlayAgainButton = true;
         this.m_Timeout = TIMEOUT_TIME;
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      public function HandleXPBarAnimBegin() : void
      {
         this.playAgainButton.SetEnabled(false);
      }
      
      public function HandleXPBarAnimEnd() : void
      {
         this.playAgainButton.SetEnabled(true);
      }
      
      public function HandleLevelUp() : void
      {
      }
      
      protected function OnTimeout() : void
      {
         this.mApp.network.ForceNetworkError();
      }
      
      protected function DispatchContinueClicked() : void
      {
         var handler:IPostGameStatsHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePostGameContinueClicked();
         }
      }
      
      protected function DispatchMainMenuClicked() : void
      {
         var handler:IPostGameStatsHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePostGameContinueClicked();
         }
      }
      
      protected function HandleContinueClicked(event:MouseEvent) : void
      {
         this.mApp.mAdAPI.SetScore(this.mApp.logic.GetScore());
         this.mApp.mAdAPI.ScoreSubmit();
         this.mApp.mAdAPI.GameEnd();
         visible = false;
         this.mApp.logic.Quit();
         this.DispatchContinueClicked();
      }
      
      protected function HandleMainMenuClicked(event:MouseEvent) : void
      {
         visible = false;
         this.DispatchMainMenuClicked();
      }
   }
}
