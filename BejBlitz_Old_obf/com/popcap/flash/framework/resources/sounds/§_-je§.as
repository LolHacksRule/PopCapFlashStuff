package com.popcap.flash.framework.resources.sounds
{
   import flash.events.EventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.media.Sound;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class §_-je§ extends EventDispatcher implements §_-V6§
   {
       
      
      private var §_-O-§:SoundTransform;
      
      private var §_-Ht§:Vector.<SoundResource>;
      
      protected var §_-GM§:Dictionary;
      
      private var §_-Mb§:Number = 1.0;
      
      private var §_-Qr§:Boolean = false;
      
      public function §_-je§()
      {
         super();
         this.§_-GM§ = new Dictionary();
         this.§_-Ht§ = new Vector.<SoundResource>();
         this.§_-O-§ = new SoundTransform();
         var _loc1_:Sound = new Sound();
         _loc1_.addEventListener(SampleDataEvent.SAMPLE_DATA,this.§_-Et§);
         _loc1_.play();
      }
      
      private function §_-Et§(param1:SampleDataEvent) : void
      {
      }
      
      public function playSound(param1:String, param2:int = 1) : SoundInst
      {
         var _loc3_:SoundResource = this.§_-Jl§(param1);
         if(_loc3_ == null)
         {
            throw new Error("Could not find sound id " + param1);
         }
         return _loc3_.play(param2);
      }
      
      public function §_-BS§() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.§_-Ht§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-Ht§[_loc2_];
            _loc3_.pause();
            _loc2_++;
         }
      }
      
      public function §_-n3§() : void
      {
         if(this.§_-Qr§)
         {
            this.unmute();
         }
         else
         {
            this.mute();
         }
      }
      
      public function §_-Jl§(param1:String) : SoundResource
      {
         var _loc2_:§_-R1§ = this.§_-GM§[param1];
         if(_loc2_ == null)
         {
            throw new Error("Could not find sound id " + param1);
         }
         var _loc3_:SoundResource = _loc2_.§_-C§();
         if(_loc3_ == null)
         {
            throw new Error("Could not find sound id " + param1);
         }
         if(_loc3_.§_-6s§ < 0)
         {
            _loc3_.§_-6s§ = this.§_-Ht§.length;
            this.§_-Ht§[this.§_-Ht§.length] = _loc3_;
         }
         return _loc3_;
      }
      
      public function §_-pT§(param1:String) : SoundInst
      {
         var _loc2_:SoundResource = this.§_-Jl§(param1);
         if(_loc2_ == null)
         {
            throw new Error("Could not find sound id " + param1);
         }
         return _loc2_.§_-fe§();
      }
      
      public function §_-Zo§(param1:Number) : void
      {
         if(this.§_-Qr§)
         {
            this.§_-Mb§ = param1;
            return;
         }
         this.§_-O-§.volume = param1;
         SoundMixer.soundTransform = this.§_-O-§;
      }
      
      public function mute() : void
      {
         this.§_-Mb§ = this.§_-O-§.volume;
         this.§_-Zo§(0);
         this.§_-Qr§ = true;
         dispatchEvent(§_-Ol§.§ var§());
      }
      
      public function isMuted() : Boolean
      {
         return this.§_-Qr§;
      }
      
      public function §_-F9§() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.§_-Ht§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-Ht§[_loc2_];
            _loc3_.resume();
            _loc2_++;
         }
      }
      
      public function unmute() : void
      {
         this.§_-Qr§ = false;
         this.§_-Zo§(this.§_-Mb§);
         dispatchEvent(§_-Ol§.§_-19§());
      }
      
      public function §_-6y§() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.§_-Ht§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-Ht§[_loc2_];
            _loc3_.stop();
            _loc2_++;
         }
      }
   }
}
