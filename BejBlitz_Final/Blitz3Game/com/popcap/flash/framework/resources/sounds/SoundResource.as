package com.popcap.flash.framework.resources.sounds
{
   import flash.media.Sound;
   import flash.utils.getTimer;
   
   public class SoundResource
   {
       
      
      public var sound:Sound;
      
      public var resourceId:int = -1;
      
      private var mInstances:Vector.<SoundInst>;
      
      private var mVolume:Number = 1.0;
      
      private var mLastTime:int = 0;
      
      public function SoundResource()
      {
         super();
         this.mInstances = new Vector.<SoundInst>();
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
      
      public function play(param1:int, param2:Number = -1) : SoundInst
      {
         var _loc7_:SoundInst = null;
         var _loc3_:int = getTimer();
         if(_loc3_ - 10 <= this.mLastTime)
         {
            return null;
         }
         this.mLastTime = _loc3_;
         var _loc4_:SoundInst = null;
         var _loc5_:int = this.mInstances.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if((_loc7_ = this.mInstances[_loc6_]).isDone())
            {
               _loc4_ = _loc7_;
               break;
            }
            _loc6_++;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new SoundInst();
            this.mInstances.push(_loc4_);
         }
         _loc4_.reset(this);
         _loc4_.numPlays = param1;
         if(param2 == -1)
         {
            param2 = this.mVolume;
         }
         _loc4_.play(param2);
         return _loc4_;
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
   }
}
