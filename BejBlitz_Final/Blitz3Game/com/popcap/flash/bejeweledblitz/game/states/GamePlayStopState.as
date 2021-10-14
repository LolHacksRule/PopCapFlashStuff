package com.popcap.flash.bejeweledblitz.game.states
{
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
       
      
      private var m_App:Blitz3Game;
      
      private var mTimer:int = 0;
      
      private var mVelocities:Vector.<Point>;
      
      private var mShakes:Vector.<Point>;
      
      private var mInit:Vector.<Point>;
      
      private var mIsIdle:Boolean = true;
      
      private var mIsShaking:Boolean = true;
      
      private var mIsStarted:Boolean = false;
      
      public function GamePlayStopState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
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
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         if(!this.mIsStarted)
         {
            this.m_App.questManager.UpdateQuestCompletion("GamePlayStopState");
            this.m_App.sessionData.configManager.CommitChanges();
            this.m_App.network.FinishGame();
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
      
      private function StartShakes() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:Point = null;
         var _loc1_:Vector.<Gem> = this.m_App.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = new Point(_loc4_.col,_loc4_.row);
            this.mInit.push(_loc5_);
            this.mShakes.push(new Point(0,0));
            _loc3_++;
         }
      }
      
      private function UpdateShakes() : void
      {
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:Gem = null;
         var _loc1_:Vector.<Gem> = this.m_App.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.mShakes[_loc3_]).x = Math.random() * 0.1 - 0.05;
            _loc4_.y = Math.random() * 0.1 - 0.05;
            _loc5_ = this.mInit[_loc3_];
            (_loc6_ = _loc1_[_loc3_]).x = _loc5_.x + _loc4_.x;
            _loc6_.y = _loc5_.y + _loc4_.y;
            _loc3_++;
         }
      }
      
      private function StartExplosion() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:Vector.<Gem> = this.m_App.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = Math.random() * 0.1 - 0.05;
            _loc5_ = -0.1 - Math.random() * 0.05;
            this.mVelocities.push(new Point(_loc4_,_loc5_));
            _loc3_++;
         }
      }
      
      private function UpdateExplosion() : void
      {
         var _loc4_:Point = null;
         var _loc5_:Gem = null;
         var _loc1_:Vector.<Gem> = this.m_App.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.mVelocities[_loc3_];
            _loc4_.y += GRAVITY;
            _loc5_ = this.m_App.logic.board.mGems[_loc3_];
            _loc5_.x += _loc4_.x;
            _loc5_.y += _loc4_.y;
            _loc3_++;
         }
      }
   }
}
