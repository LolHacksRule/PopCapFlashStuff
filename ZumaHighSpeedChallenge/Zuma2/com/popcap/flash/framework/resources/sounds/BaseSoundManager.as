package com.popcap.flash.framework.resources.sounds
{
   import flash.events.EventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.media.Sound;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class BaseSoundManager extends EventDispatcher implements SoundManager
   {
       
      
      private var mTrans:SoundTransform;
      
      private var mResources:Vector.<SoundResource>;
      
      protected var mSounds:Dictionary;
      
      private var mMutedVolume:Number = 1.0;
      
      private var mMuted:Boolean = false;
      
      public function BaseSoundManager()
      {
         super();
         this.mSounds = new Dictionary();
         this.mResources = new Vector.<SoundResource>();
         this.mTrans = new SoundTransform();
         var _loc1_:Sound = new Sound();
         _loc1_.addEventListener(SampleDataEvent.SAMPLE_DATA,this.HandleBlankSound);
         _loc1_.play();
      }
      
      private function HandleBlankSound(param1:SampleDataEvent) : void
      {
      }
      
      public function playSound(param1:String, param2:int = 1) : SoundInst
      {
         var _loc3_:SoundResource = this.getSoundResource(param1);
         if(_loc3_ == null)
         {
            return new SoundInst();
         }
         return _loc3_.play(param2);
      }
      
      public function pauseAll() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.mResources.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mResources[_loc2_];
            _loc3_.pause();
            _loc2_++;
         }
      }
      
      public function toggleMute() : void
      {
         if(this.mMuted)
         {
            this.unmute();
         }
         else
         {
            this.mute();
         }
      }
      
      public function getSoundResource(param1:String) : SoundResource
      {
         var _loc2_:SoundDescriptor = this.mSounds[param1];
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:SoundResource = _loc2_.getResource();
         if(_loc3_ == null)
         {
            return null;
         }
         if(_loc3_.resourceId < 0)
         {
            _loc3_.resourceId = this.mResources.length;
            this.mResources[this.mResources.length] = _loc3_;
         }
         return _loc3_;
      }
      
      public function loopSound(param1:String) : SoundInst
      {
         var _loc2_:SoundResource = this.getSoundResource(param1);
         if(_loc2_ == null)
         {
            return new SoundInst();
         }
         return _loc2_.loop();
      }
      
      public function setVolume(param1:Number) : void
      {
         if(this.mMuted)
         {
            this.mMutedVolume = param1;
            return;
         }
         this.mTrans.volume = param1;
         SoundMixer.soundTransform = this.mTrans;
      }
      
      public function mute() : void
      {
         this.mMutedVolume = this.mTrans.volume;
         this.setVolume(0);
         this.mMuted = true;
         dispatchEvent(SoundEvent.Muted());
      }
      
      public function isMuted() : Boolean
      {
         return this.mMuted;
      }
      
      public function resumeAll() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.mResources.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mResources[_loc2_];
            _loc3_.resume();
            _loc2_++;
         }
      }
      
      public function unmute() : void
      {
         this.mMuted = false;
         this.setVolume(this.mMutedVolume);
         dispatchEvent(SoundEvent.Unmuted());
      }
      
      public function stopAll() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.mResources.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mResources[_loc2_];
            _loc3_.stop();
            _loc2_++;
         }
      }
   }
}
