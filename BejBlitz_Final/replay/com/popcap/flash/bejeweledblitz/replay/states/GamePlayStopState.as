package com.popcap.flash.bejeweledblitz.replay.states
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class GamePlayStopState extends Sprite implements IAppState
   {
      
      public static const IDLE_TIME:int = 10;
      
      public static const SHAKE_TIME:int = 50;
      
      public static const EXPLODE_TIME:int = 200;
      
      public static const GRAVITY:Number = 0.003;
       
      
      private var m_App:Blitz3App;
      
      private var mTimer:int = 0;
      
      private var mVelocities:Vector.<Point>;
      
      private var mShakes:Vector.<Point>;
      
      private var mInit:Vector.<Point>;
      
      private var mIsIdle:Boolean = true;
      
      private var mIsShaking:Boolean = true;
      
      private var mIsStarted:Boolean = false;
      
      public function GamePlayStopState(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.mVelocities = new Vector.<Point>();
         this.mShakes = new Vector.<Point>();
         this.mInit = new Vector.<Point>();
      }
      
      public function Reset() : void
      {
         this.mIsStarted = false;
      }
      
      public function update() : void
      {
         --this.mTimer;
         if(this.mIsShaking)
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
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_FINAL_EXPLOSION);
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
         if(!this.mIsStarted)
         {
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
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      private function StartShakes() : void
      {
         var gem:Gem = null;
         var init:Point = null;
         var gems:Vector.<Gem> = this.m_App.logic.board.mGems;
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
         var gems:Vector.<Gem> = this.m_App.logic.board.mGems;
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
         var gems:Vector.<Gem> = this.m_App.logic.board.mGems;
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
         var gems:Vector.<Gem> = this.m_App.logic.board.mGems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            velo = this.mVelocities[i];
            velo.y += GRAVITY;
            gem = this.m_App.logic.board.mGems[i];
            gem.x += velo.x;
            gem.y += velo.y;
         }
      }
   }
}
