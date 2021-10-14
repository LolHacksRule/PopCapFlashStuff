package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.bej3.blitz.IBlitzLogicHandler;
   import com.popcap.flash.games.blitz3.ui.widgets.game.stats.IPostGameStatsHandler;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameOverInfoState extends Sprite implements IAppState, IBlitz3NetworkHandler, IPostGameStatsHandler, IBlitzLogicHandler
   {
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_IsShowing:Boolean = false;
      
      private var m_HasLoggedRareGemEvent:Boolean = false;
      
      private var m_HasBoughtCoins:Boolean = false;
      
      private var m_previousHighScore:int = 0;
      
      public function GameOverInfoState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_App.network.AddHandler(this);
         this.m_App.ui.stats.AddHandler(this);
         this.m_App.logic.AddBlitzLogicHandler(this);
      }
      
      public function update() : void
      {
         this.m_App.ui.stats.Update();
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var eventName:String = Blitz3Sequencer.SEQEVENT_GAME_END;
         trace("game end event id: " + eventName);
         this.m_App.dispatchEvent(new Event(eventName));
         this.m_HasLoggedRareGemEvent = false;
         this.m_HasBoughtCoins = false;
         this.m_App.creditsScreen.screenID = this.m_App.logic.multiLogic.multiplier;
         this.m_App.ui.optionsButton.visible = true;
         this.ShowScreen();
      }
      
      public function onExit() : void
      {
         this.HideScreen();
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
         if(success)
         {
            this.m_HasBoughtCoins = true;
         }
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
      
      public function HandlePostGameContinueClicked() : void
      {
         this.m_App.m_menu.ReturnToMainMenu();
      }
      
      public function HandleGameEnd() : void
      {
         this.m_previousHighScore = this.m_App.currentHighScore;
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      protected function HideScreen() : void
      {
         if(!this.m_IsShowing)
         {
            return;
         }
         this.m_App.ui.stats.ResetButtonState();
         this.m_App.ui.stats.visible = false;
         this.m_IsShowing = false;
      }
      
      protected function ShowScreen() : void
      {
         var useData:Object = null;
         if(this.m_IsShowing)
         {
            return;
         }
         if(this.m_App.logic.GetScore() > this.m_previousHighScore)
         {
            this.m_App.soundManager.playSound(Blitz3Sounds.SOUND_VOICE_NEW_HIGH_SCORE);
         }
         this.m_App.ui.stats.visible = true;
         this.m_App.ui.game.board.visible = false;
         this.m_App.ui.game.sidebar.visible = false;
         this.m_App.ui.stats.SetOffline(this.m_App.network.isOffline);
         this.m_App.ui.stats.SetPowerGemCounts(this.m_App.logic.m_totalFlameGems,this.m_App.logic.m_totalStarGems,this.m_App.logic.m_totalHyperCubes);
         this.m_App.ui.stats.SetScores(this.m_App.logic.scoreKeeper.scores,this.m_App.logic.timerLogic.GetGameDuration());
         var used:Array = this.m_App.logic.multiLogic.used;
         var numData:int = used.length;
         for(var i:int = 0; i < numData; i++)
         {
            useData = used[i];
            this.m_App.ui.stats.AddMultiplier(useData.time,useData.number,useData.color);
         }
         this.m_IsShowing = true;
         this.m_App.ui.stats.Reset();
      }
   }
}
