package com.popcap.flash.framework.resources.sounds
{
   import flash.media.Sound;
   import flash.utils.getTimer;
   
   public class SoundResource
   {
       
      
      private var §_-EY§:Number = 1.0;
      
      public var §_-6s§:int = -1;
      
      public var sound:Sound;
      
      private var §_-BZ§:int = 0;
      
      private var §_-CY§:Vector.<SoundInst>;
      
      public function SoundResource()
      {
         super();
         this.§_-CY§ = new Vector.<SoundInst>();
      }
      
      public function §_-fe§() : SoundInst
      {
         var _loc4_:SoundInst = null;
         var _loc1_:SoundInst = null;
         var _loc2_:int = this.§_-CY§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = this.§_-CY§[_loc3_]).§_-nM§())
            {
               _loc1_ = _loc4_;
               break;
            }
            _loc3_++;
         }
         if(_loc1_ == null)
         {
            _loc1_ = new SoundInst();
            this.§_-CY§.push(_loc1_);
         }
         _loc1_.§_-P0§(this);
         _loc1_.§_-aL§ = -1;
         _loc1_.play(this.§_-EY§);
         return _loc1_;
      }
      
      public function resume() : void
      {
         var _loc3_:SoundInst = null;
         var _loc1_:int = this.§_-CY§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-CY§[_loc2_];
            _loc3_.resume();
            _loc2_++;
         }
      }
      
      public function play(param1:int) : SoundInst
      {
         var _loc6_:SoundInst = null;
         var _loc2_:int = getTimer();
         if(_loc2_ - 10 <= this.§_-BZ§)
         {
            return null;
         }
         this.§_-BZ§ = _loc2_;
         var _loc3_:SoundInst = null;
         var _loc4_:int = this.§_-CY§.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = this.§_-CY§[_loc5_]).§_-nM§())
            {
               _loc3_ = _loc6_;
               break;
            }
            _loc5_++;
         }
         if(_loc3_ == null)
         {
            _loc3_ = new SoundInst();
            this.§_-CY§.push(_loc3_);
         }
         _loc3_.§_-P0§(this);
         _loc3_.§_-aL§ = param1;
         _loc3_.play(this.§_-EY§);
         return _loc3_;
      }
      
      public function pause() : void
      {
         var _loc3_:SoundInst = null;
         var _loc1_:int = this.§_-CY§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-CY§[_loc2_];
            _loc3_.pause();
            _loc2_++;
         }
      }
      
      public function stop() : void
      {
         var _loc3_:SoundInst = null;
         var _loc1_:int = this.§_-CY§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-CY§[_loc2_];
            _loc3_.stop();
            _loc2_++;
         }
      }
      
      public function §_-Zo§(param1:Number) : void
      {
         var _loc4_:SoundInst = null;
         this.§_-EY§ = param1;
         var _loc2_:int = this.§_-CY§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.§_-CY§[_loc3_]).§_-Zo§(param1);
            _loc3_++;
         }
      }
   }
}
