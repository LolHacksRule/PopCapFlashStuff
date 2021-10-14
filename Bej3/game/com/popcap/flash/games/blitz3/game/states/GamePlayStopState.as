package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.tokens.CoinTokenLogic;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class GamePlayStopState extends Sprite implements IAppState
   {
      
      public static const IDLE_TIME:int = 10;
      
      public static const SHAKE_TIME:int = 50;
      
      public static const EXPLODE_TIME:int = 200;
      
      public static const GRAVITY:Number = 0.003;
       
      
      private var mApp:Blitz3UI;
      
      private var mTimer:int = 0;
      
      private var mVelocities:Vector.<Point>;
      
      private var mInit:Vector.<Point>;
      
      private var mShakes:Vector.<Point>;
      
      private var mIsIdle:Boolean = true;
      
      private var mIsShaking:Boolean = true;
      
      private var mTimeUpSprite:Sprite;
      
      private var mTimeUpText:TextField;
      
      private var mIsStarted:Boolean = false;
      
      public function GamePlayStopState(app:Blitz3UI)
      {
         super();
         this.mApp = app;
         this.mVelocities = new Vector.<Point>();
         this.mShakes = new Vector.<Point>();
         this.mInit = new Vector.<Point>();
         var format:TextFormat = new TextFormat();
         format.font = Blitz3Fonts.BLITZ_STANDARD;
         format.size = 48;
         format.align = TextFormatAlign.CENTER;
         this.mTimeUpText = new TextField();
         this.mTimeUpText.embedFonts = true;
         this.mTimeUpText.textColor = 16777215;
         this.mTimeUpText.defaultTextFormat = format;
         this.mTimeUpText.filters = [new GlowFilter(0)];
         this.mTimeUpText.width = 320;
         this.mTimeUpText.height = 64;
         this.mTimeUpText.x = -this.mTimeUpText.width / 2;
         this.mTimeUpText.y = -this.mTimeUpText.height / 2;
         this.mTimeUpText.htmlText = this.mApp.locManager.GetLocString("GAMEPLAY_TIPS_GAMEOVER");
         this.mTimeUpSprite = new Sprite();
         this.mTimeUpSprite.addChild(this.mTimeUpText);
         this.mTimeUpSprite.x = this.mApp.ui.game.board.x + 160;
         this.mTimeUpSprite.y = this.mApp.ui.game.board.y + 160;
      }
      
      public function Reset() : void
      {
         this.mIsStarted = false;
      }
      
      public function update() : void
      {
         --this.mTimer;
         if(this.mIsIdle)
         {
            this.UpdateIdle();
         }
         else if(this.mIsShaking)
         {
            this.UpdateShakes();
         }
         else
         {
            this.UpdateExplosion();
         }
         if(this.mTimer == 0)
         {
            if(this.mIsIdle)
            {
               this.mIsIdle = false;
               this.mTimer = SHAKE_TIME;
            }
            else if(this.mIsShaking)
            {
               this.mIsShaking = false;
               this.mTimer = EXPLODE_TIME;
               this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_FINAL_EXPLOSION);
            }
            else
            {
               this.mIsStarted = false;
               dispatchEvent(new Event(GamePlayState.SIGNAL_GAME_PLAY_END));
            }
         }
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var score:int = 0;
         var coins:int = 0;
         if(!this.mIsStarted)
         {
            score = this.mApp.logic.GetScore();
            coins = this.mApp.logic.coinTokenLogic.collected.length * CoinTokenLogic.COIN_VALUE;
            this.mApp.currentHighScore = Math.max(score,this.mApp.currentHighScore);
            this.mApp.network.FinishGame(score,coins);
            this.mTimeUpText.alpha = 0;
            this.mIsIdle = true;
            this.mIsShaking = true;
            this.mTimer = IDLE_TIME;
            this.mInit.length = 0;
            this.mShakes.length = 0;
            this.mVelocities.length = 0;
            this.StartExplosion();
            this.StartShakes();
            this.mIsStarted = true;
         }
      }
      
      public function onExit() : void
      {
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
      
      private function UpdateIdle() : void
      {
      }
      
      private function StartShakes() : void
      {
         var gem:Gem = null;
         var init:Point = null;
         var gems:Vector.<Gem> = this.mApp.logic.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            init = new Point(gem.col,gem.row);
            this.mInit.push(init);
            this.mShakes.push(new Point(0,0));
         }
      }
      
      private function UpdateShakes() : void
      {
         var delta:Point = null;
         var init:Point = null;
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.mApp.logic.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            delta = this.mShakes[i];
            delta.x = Math.random() * 0.1 - 0.05;
            delta.y = Math.random() * 0.1 - 0.05;
            init = this.mInit[i];
            gem = gems[i];
            gem.x = init.x + delta.x;
            gem.y = init.y + delta.y;
         }
      }
      
      private function StartExplosion() : void
      {
         var x:Number = NaN;
         var y:Number = NaN;
         var gems:Vector.<Gem> = this.mApp.logic.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            x = Math.random() * 0.1 - 0.05;
            y = -0.1 - Math.random() * 0.05;
            this.mVelocities.push(new Point(x,y));
         }
      }
      
      private function UpdateExplosion() : void
      {
         var velo:Point = null;
         var gem:Gem = null;
         var gems:Vector.<Gem> = this.mApp.logic.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            velo = this.mVelocities[i];
            velo.y += GRAVITY;
            gem = this.mApp.logic.board.mGems[i];
            gem.x += velo.x;
            gem.y += velo.y;
         }
      }
   }
}
