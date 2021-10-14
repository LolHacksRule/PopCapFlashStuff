package com.popcap.flash.framework.resources.sounds
{
   import flash.media.Sound;
   import flash.utils.getTimer;
   
   public class SoundResource
   {
       
      
      private var mVolume:Number = 1.0;
      
      public var resourceId:int = -1;
      
      public var sound:Sound;
      
      private var mLastTime:int = 0;
      
      private var mInstances:Vector.<SoundInst>;
      
      public function SoundResource()
      {
         super();
         this.mInstances = new Vector.<SoundInst>();
      }
      
      public function loop() : SoundInst
      {
         var _loc4_:SoundInst = null;
         var _loc1_:SoundInst = null;
         var _loc2_:int = this.mInstances.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = this.mInstances[_loc3_]).isDone())
            {
               _loc1_ = _loc4_;
               break;
            }
            _loc3_++;
         }
         if(_loc1_ == null)
         {
            _loc1_ = new SoundInst();
            this.mInstances.push(_loc1_);
         }
         _loc1_.reset(this);
         _loc1_.numPlays = -1;
         _loc1_.play(this.mVolume);
         return _loc1_;
      }
      
      public function resume() : void
      {
         var _loc3_:SoundInst = null;
         var _loc1_:int = this.mInstances.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mInstances[_loc2_];
            _loc3_.resume();
            _loc2_++;
         }
      }
      
      public function play(param1:int) : SoundInst
      {
         var _loc6_:SoundInst = null;
         var _loc2_:int = getTimer();
         if(_loc2_ - 10 <= this.mLastTime)
         {
            return null;
         }
         this.mLastTime = _loc2_;
         var _loc3_:SoundInst = null;
         var _loc4_:int = this.mInstances.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = this.mInstances[_loc5_]).isDone())
            {
               _loc3_ = _loc6_;
               break;
            }
            _loc5_++;
         }
         if(_loc3_ == null)
         {
            _loc3_ = new SoundInst();
            this.mInstances.push(_loc3_);
         }
         _loc3_.reset(this);
         _loc3_.numPlays = param1;
         _loc3_.play(this.mVolume);
         return _loc3_;
      }
      
      public function pause() : void
      {
         var _loc3_:SoundInst = null;
         var _loc1_:int = this.mInstances.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mInstances[_loc2_];
            _loc3_.pause();
            _loc2_++;
         }
      }
      
      public function stop() : void
      {
         var _loc3_:SoundInst = null;
         var _loc1_:int = this.mInstances.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mInstances[_loc2_];
            _loc3_.stop();
            _loc2_++;
         }
      }
      
      public function setVolume(param1:Number) : void
      {
         var _loc4_:SoundInst = null;
         this.mVolume = param1;
         var _loc2_:int = this.mInstances.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.mInstances[_loc3_]).setVolume(param1);
            _loc3_++;
         }
      }
   }
}
