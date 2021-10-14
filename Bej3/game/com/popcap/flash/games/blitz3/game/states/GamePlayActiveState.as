package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.framework.widgets.ButtonListener;
   import com.popcap.flash.games.bej3.blitz.CascadeScore;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayActiveState extends Sprite implements IAppState, ButtonListener, IBlitz3NetworkHandler
   {
      
      public static const IDLE_TIME:int = 175;
      
      public static const TIME_UP_TIME:int = 175;
       
      
      private var mApp:Blitz3UI;
      
      private var mTimer:int = 0;
      
      private var mTimePlayed:int = 0;
      
      private var mBestMove:int = 0;
      
      private var mTimerStarted:Boolean = false;
      
      private var mIsTimeUp:Boolean = false;
      
      private var mIsActive:Boolean = false;
      
      private var mNoMoreMoves:Boolean = false;
      
      private var mDisplayedLevelUp:Boolean = false;
      
      public function GamePlayActiveState(app:Blitz3UI)
      {
         super();
         this.mApp = app;
         app.network.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.mTimerStarted = false;
         this.mIsTimeUp = false;
         this.mNoMoreMoves = false;
         this.mDisplayedLevelUp = false;
      }
      
      public function ResetTime() : void
      {
         this.mTimePlayed = 0;
      }
      
      public function ResetBestMove() : void
      {
         this.mBestMove = 0;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var cascade:CascadeScore = null;
         ++this.mTimePlayed;
         if(!this.mApp.logic.isActive)
         {
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_VOICE_GO);
            this.mApp.ui.game.board.broadcast.PlayGo();
            this.mApp.mAdAPI.ResumeBroadcast();
         }
         if(this.mApp.logic.GetCurrentLevel() > 1 && !this.mDisplayedLevelUp)
         {
            this.mDisplayedLevelUp = true;
            this.mApp.ui.game.board.broadcast.PlayStartNewLevel(this.mApp.logic.GetCurrentLevel());
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_VOICE_GO);
         }
         this.mApp.logic.isActive = true;
         this.mApp.logic.update();
         if(this.mApp.logic.timerLogic.GetTimeRemaining() == 0 && this.mIsTimeUp == false)
         {
         }
         if(this.mApp.logic.NoMoreMoves() && !this.mNoMoreMoves)
         {
            this.mNoMoreMoves = true;
            this.mApp.ui.game.board.broadcast.PlayNoMoreMoves();
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_VOICE_NO_MORE_MOVES);
            this.mTimer = TIME_UP_TIME;
            this.mApp.logic.SetTimePlayed(this.mTimePlayed);
            this.mApp.ui.stats.window.breakout.SetStats(this.mApp.logic.GetCurrentLevel(),StringUtils.InsertNumberCommas(this.mApp.logic.GetBestMove()).toString(),this.mApp.logic.GetBestCascade(),StringUtils.GetTimeText(this.mApp.logic.GetTimePlayed()));
         }
         if(this.mApp.logic.NoMoreMoves())
         {
            if(this.mTimer > 0)
            {
               --this.mTimer;
            }
         }
         if(this.mApp.logic.NoMoreMoves() && this.mTimer == 0)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_STOP));
            this.mTimerStarted = false;
         }
         if(this.mApp.logic.CanLevelUp())
         {
            this.mApp.ui.game.sidebar.buttons.menuButton.SetEnabled(false);
            if(this.mApp.mAdAPI._isEnabled)
            {
               this.mApp.mAdAPI.PauseBroadcast();
               this.mApp.mAdAPI.SetScore(this.mApp.logic.GetScore());
            }
            this.mDisplayedLevelUp = false;
            this.mApp.ui.game.board.broadcast.PlayLevelComplete();
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_VOICE_LEVEL_COMPLETE);
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_LEVELUP));
            for(i = 0; i < this.mApp.logic.scoreKeeper.cascadeScores.length; i++)
            {
               cascade = this.mApp.logic.scoreKeeper.cascadeScores[i];
               if(cascade.score > this.mBestMove)
               {
                  this.mBestMove = cascade.score;
               }
            }
         }
         this.mApp.ui.game.board.frame.Update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.mApp.ui.game.board.frame.Draw();
      }
      
      public function onEnter() : void
      {
         this.mIsActive = true;
         if(!this.mTimerStarted)
         {
            this.mTimer = 0;
            this.mTimerStarted = true;
         }
         this.mApp.ui.game.sidebar.buttons.menuButton.SetEnabled(true);
         this.mApp.logic.Resume();
         this.mApp.mAdAPI.ResumeBroadcast();
      }
      
      public function onExit() : void
      {
         this.mIsActive = false;
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
      
      public function onButtonPress(id:String) : void
      {
      }
      
      public function onButtonRelease(id:String) : void
      {
      }
      
      public function onButtonClick(id:String) : void
      {
         trace("Menu button clicked");
         dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_PAUSE));
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
         if(!this.mIsActive)
         {
            return;
         }
         if(isPaused)
         {
            trace("Dispatching pause event");
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_PAUSE));
         }
         else
         {
            trace("Dispatching game play resume event");
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_RESUME));
         }
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
   }
}
