package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.IXpBarHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.PostGameMessageFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.PostGameMessage;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class GameOverWidget extends Sprite implements IBlitz3NetworkHandler, IXpBarHandler, IUserDataHandler
   {
      
      public static const TIMEOUT_TIME:int = 500;
       
      
      public var stats:StatsWidget;
      
      public var playAgainButton:PlayAgainButton;
      
      public var playAgainStreak:PlayAgainStreak;
      
      public var submittingScoreMessage:SubmittingScoreMessage;
      
      public var levelUp:LevelUpWidget;
      
      public var showPlayAgainButton:Boolean;
      
      public var messageFactory:PostGameMessageFactory;
      
      public var curMessage:PostGameMessage;
      
      private var m_App:Blitz3App;
      
      private var m_MainWidget:MainWidgetGame;
      
      private var m_Timeout:int = 500;
      
      private var m_Handlers:Vector.<IPostGameStatsHandler>;
      
      public function GameOverWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<IPostGameStatsHandler>();
         this.playAgainButton = new PlayAgainButton(app);
         this.playAgainStreak = new PlayAgainStreak(app);
         this.stats = new StatsWidget(app);
         this.submittingScoreMessage = new SubmittingScoreMessage(app);
         this.levelUp = new LevelUpWidget(app);
         this.messageFactory = new PostGameMessageFactory(app);
         visible = false;
      }
      
      public function Init() : void
      {
         this.m_MainWidget = this.m_App.ui as MainWidgetGame;
         this.playAgainButton.Init();
         this.playAgainStreak.Init();
         this.stats.Init();
         this.submittingScoreMessage.Init();
         this.levelUp.Init();
         this.m_App.network.AddHandler(this);
         this.m_App.sessionData.userData.AddHandler(this);
         this.stats.levelView.xpBar.AddHandler(this);
         this.playAgainButton.addEventListener(MouseEvent.CLICK,this.HandleContinueClicked);
         this.playAgainStreak.addEventListener(MouseEvent.CLICK,this.HandleContinueClicked);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.stats.Reset();
         this.submittingScoreMessage.Reset();
         this.levelUp.Reset();
         this.stats.x = 5;
         this.stats.y = 35;
         this.m_MainWidget.optionsButton.visible = false;
         if(this.curMessage != null && contains(this.curMessage))
         {
            removeChild(this.curMessage);
         }
         this.curMessage = this.messageFactory.GetMessage();
         addChild(this.curMessage);
         this.curMessage.x = Dimensions.GAME_WIDTH * 0.5 - this.curMessage.width * 0.5;
         this.curMessage.y = Dimensions.GAME_HEIGHT * 0.99 - this.curMessage.height;
         if(!contains(this.playAgainButton))
         {
            addChild(this.playAgainButton);
         }
         this.playAgainButton.x = 106 + this.playAgainButton.width * 0.5;
         this.playAgainButton.y = this.stats.y + 233 + 41;
         this.submittingScoreMessage.x = this.playAgainButton.x - this.submittingScoreMessage.width * 0.5;
         this.submittingScoreMessage.y = this.playAgainButton.y - this.submittingScoreMessage.height * 0.5;
         this.playAgainButton.SetEnabled(true);
         this.playAgainStreak.SetEnabled(true);
         var streakNum:int = this.m_App.sessionData.rareGemManager.GetStreakNum();
         if(streakNum > 0)
         {
            this.playAgainStreak.SetMessage(this.m_App.sessionData.rareGemManager.GetStreakId(),streakNum);
            this.playAgainStreak.x = this.playAgainButton.x;
            this.playAgainStreak.y = this.playAgainButton.y;
            addChild(this.playAgainStreak);
            removeChild(this.playAgainButton);
            removeChild(this.curMessage);
         }
         else if(contains(this.playAgainStreak))
         {
            removeChild(this.playAgainStreak);
         }
         if(contains(this.stats))
         {
            removeChild(this.stats);
         }
         addChild(this.stats);
         if(contains(this.levelUp))
         {
            removeChild(this.levelUp);
         }
         addChild(this.levelUp);
      }
      
      public function ResetButtonState() : void
      {
         this.showPlayAgainButton = false;
         this.playAgainButton.visible = false;
         this.playAgainStreak.visible = false;
         this.submittingScoreMessage.visible = true;
      }
      
      public function Update() : void
      {
         this.stats.Update();
         this.submittingScoreMessage.Update();
         this.m_MainWidget.networkWait.Update();
         if(this.showPlayAgainButton)
         {
            this.playAgainButton.visible = true;
            this.playAgainStreak.visible = true;
            this.submittingScoreMessage.visible = false;
         }
         else
         {
            this.playAgainButton.visible = false;
            this.playAgainStreak.visible = false;
            this.submittingScoreMessage.visible = true;
            --this.m_Timeout;
            if(this.m_Timeout < 0)
            {
               this.OnTimeout();
               this.m_Timeout = TIMEOUT_TIME;
            }
         }
      }
      
      public function SetScores(values:Vector.<ScoreValue>, maxTime:int) : void
      {
         this.stats.graph.SetScores(values,maxTime);
         this.stats.UpdateTicks();
      }
      
      public function SetPowerGemCounts(flameGems:int, starGems:int, hypercubes:int) : void
      {
         this.stats.flameCount.htmlText = "x" + flameGems;
         this.stats.starCount.htmlText = "x" + starGems;
         this.stats.hyperCount.htmlText = "x" + hypercubes;
      }
      
      public function AddHandler(handler:IPostGameStatsHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         this.stats.SetCoinBalance(balance);
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
         this.stats.levelView.SetData(xp);
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess(response:XML) : void
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
         this.playAgainStreak.SetEnabled(false);
      }
      
      public function HandleXPBarAnimEnd() : void
      {
         this.playAgainButton.SetEnabled(true);
         this.playAgainStreak.SetEnabled(true);
      }
      
      public function HandleLevelUp() : void
      {
      }
      
      protected function OnTimeout() : void
      {
         this.m_App.network.ForceNetworkError();
      }
      
      protected function DispatchContinueClicked() : void
      {
         var handler:IPostGameStatsHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePostGameContinueClicked();
         }
      }
      
      protected function HandleContinueClicked(event:MouseEvent) : void
      {
         this.m_MainWidget.optionsButton.visible = false;
         visible = false;
         this.DispatchContinueClicked();
      }
   }
}
