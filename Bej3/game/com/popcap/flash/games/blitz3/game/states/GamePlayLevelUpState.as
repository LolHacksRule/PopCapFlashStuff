package com.popcap.flash.games.blitz3.game.states
{
   import caurina.transitions.Tweener;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.ads.AdAPIEvent;
   import com.popcap.flash.framework.widgets.ButtonListener;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GamePlayLevelUpState extends Sprite implements IAppState, ButtonListener, IBlitz3NetworkHandler
   {
      
      public static const IDLE_TIME:int = 175;
      
      public static const TIME_UP_TIME:int = 175;
       
      
      private var mApp:Blitz3UI;
      
      private var mIsActive:Boolean;
      
      private var mTimerStarted:Boolean;
      
      private var mTimer:int;
      
      private var mSideBarDone:Boolean = false;
      
      private var mBoardDone:Boolean = false;
      
      private var mCrystalDone:Boolean = false;
      
      private var mLeveledUp:Boolean = false;
      
      private var mReadyToLevelUp:Boolean = false;
      
      public function GamePlayLevelUpState(app:Blitz3UI)
      {
         super();
         this.mApp = app;
         app.network.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.mTimerStarted = false;
         this.mSideBarDone = false;
         this.mBoardDone = false;
         this.mCrystalDone = false;
         this.mLeveledUp = false;
         this.mApp.ui.game.ResetCrystal();
         this.mReadyToLevelUp = false;
      }
      
      public function update() : void
      {
         this.mApp.logic.update();
         this.mApp.ui.game.board.frame.Update();
         if(this.mApp.ui.game.IsCrystalDone() && !this.mCrystalDone && this.mLeveledUp)
         {
            this.mCrystalDone = true;
            this.mApp.ui.game.board.x = 168;
            Tweener.addTween(this.mApp.ui.game.board,{
               "alpha":1,
               "time":1,
               "delay":0,
               "transition":"easeOutQuad",
               "onComplete":function():*
               {
                  mBoardDone = true;
               }
            });
            Tweener.addTween(this.mApp.ui.game.sidebar,{
               "alpha":1,
               "time":1,
               "delay":0,
               "transition":"easeOutQuad",
               "onComplete":function():*
               {
                  mSideBarDone = true;
               }
            });
         }
         if(this.mBoardDone && this.mSideBarDone)
         {
            dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_START));
         }
      }
      
      public function draw(elapsed:int) : void
      {
         this.mApp.ui.game.board.frame.Draw();
      }
      
      public function onEnter() : void
      {
         this.Reset();
         this.mIsActive = true;
         if(!this.mTimerStarted)
         {
            this.mTimer = IDLE_TIME;
            this.mTimerStarted = true;
         }
         Tweener.addTween(this.mApp.ui.game.board,{
            "x":100,
            "time":1,
            "delay":0,
            "transition":"easeOutQuad",
            "onComplete":function():*
            {
               Tweener.addTween(mApp.ui.game.board,{
                  "alpha":0,
                  "time":1,
                  "delay":0,
                  "transition":"easeOutQuad",
                  "onComplete":TriggerCrystal
               });
            }
         });
         Tweener.addTween(this.mApp.ui.game.sidebar,{
            "alpha":0,
            "time":1,
            "delay":0,
            "transition":"easeOutQuad"
         });
      }
      
      public function onExit() : void
      {
         this.mIsActive = false;
         this.mReadyToLevelUp = false;
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
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      private function TriggerCrystal() : void
      {
         if(this.mApp.mAdAPI._isEnabled)
         {
            this.mApp.mAdAPI.addEventListener(AdAPIEvent.GAME_CONTINUE,this.ContinueLevelUp);
            this.mApp.mAdAPI.GameBreak(this.mApp.logic.GetCurrentLevel());
         }
         else
         {
            this.ContinueLevelUp(null);
         }
      }
      
      private function LevelUp() : void
      {
         this.mApp.logic.LevelUp();
         this.mApp.ui.game.Reset();
         this.mLeveledUp = true;
      }
      
      private function ContinueLevelUp(e:AdAPIEvent) : void
      {
         this.mApp.ui.game.background.flipBackgrounds();
         this.mApp.ui.game.SetOffCrystal();
         Tweener.addTween(this.mApp.ui.game.board,{
            "alpha":0,
            "time":1,
            "delay":0.5,
            "transition":"easeOutQuad",
            "onComplete":this.LevelUp
         });
         if(this.mApp.mAdAPI._isEnabled)
         {
            this.mApp.mAdAPI.ResumeBroadcast();
            this.mApp.mAdAPI.removeEventListener(AdAPIEvent.GAME_CONTINUE,this.ContinueLevelUp);
         }
      }
   }
}
