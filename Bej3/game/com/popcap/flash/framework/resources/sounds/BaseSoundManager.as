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
       
      
      protected var mSounds:Dictionary;
      
      private var mMuted:Boolean = false;
      
      private var mMutedVolume:Number = 1.0;
      
      private var mTrans:SoundTransform;
      
      private var mResources:Vector.<SoundResource>;
      
      public function BaseSoundManager()
      {
         super();
         this.mSounds = new Dictionary();
         this.mResources = new Vector.<SoundResource>();
         this.mTrans = new SoundTransform();
         var blankSound:Sound = new Sound();
         blankSound.addEventListener(SampleDataEvent.SAMPLE_DATA,this.HandleBlankSound);
         blankSound.play();
      }
      
      public function mute() : void
      {
         this.mMutedVolume = this.mTrans.volume;
         this.setVolume(0);
         this.mMuted = true;
         dispatchEvent(SoundEvent.Muted());
      }
      
      public function unmute() : void
      {
         this.mMuted = false;
         this.setVolume(this.mMutedVolume);
         dispatchEvent(SoundEvent.Unmuted());
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
      
      public function stopAll() : void
      {
         var res:SoundResource = null;
         var len:int = this.mResources.length;
         for(var i:int = 0; i < len; i++)
         {
            res = this.mResources[i];
            res.stop();
         }
      }
      
      public function pauseAll() : void
      {
         var res:SoundResource = null;
         var len:int = this.mResources.length;
         for(var i:int = 0; i < len; i++)
         {
            res = this.mResources[i];
            res.pause();
         }
      }
      
      public function resumeAll() : void
      {
         var res:SoundResource = null;
         var len:int = this.mResources.length;
         for(var i:int = 0; i < len; i++)
         {
            res = this.mResources[i];
            res.resume();
         }
      }
      
      public function setVolume(volume:Number) : void
      {
         if(this.mMuted)
         {
            this.mMutedVolume = volume;
            return;
         }
         this.mTrans.volume = volume;
         SoundMixer.soundTransform = this.mTrans;
      }
      
      public function isMuted() : Boolean
      {
         return this.mMuted;
      }
      
      public function playSound(id:String, numPlays:int = 1) : SoundInst
      {
         var res:SoundResource = this.getSoundResource(id);
         if(res == null)
         {
            return new SoundInst();
         }
         return res.play(numPlays);
      }
      
      public function loopSound(id:String) : SoundInst
      {
         var res:SoundResource = this.getSoundResource(id);
         if(res == null)
         {
            return new SoundInst();
         }
         return res.loop();
      }
      
      public function getSoundResource(id:String) : SoundResource
      {
         var desc:SoundDescriptor = this.mSounds[id];
         if(desc == null)
         {
            return null;
         }
         var res:SoundResource = desc.getResource();
         if(res == null)
         {
            return null;
         }
         if(res.resourceId < 0)
         {
            res.resourceId = this.mResources.length;
            this.mResources[this.mResources.length] = res;
         }
         return res;
      }
      
      private function HandleBlankSound(e:SampleDataEvent) : void
      {
      }
   }
}
