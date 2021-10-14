package com.popcap.flash.framework.resources.sounds
{
   import com.popcap.flash.framework.resources.ResourceManager;
   import flash.events.EventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.media.Sound;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class BaseSoundManager extends EventDispatcher
   {
       
      
      protected var m_ResourceManager:ResourceManager;
      
      private var m_Muted:Boolean = false;
      
      private var m_MutedVolume:Number = 1.0;
      
      private var m_Trans:SoundTransform;
      
      private var m_Resources:Vector.<SoundResource>;
      
      public function BaseSoundManager(resourceManager:ResourceManager)
      {
         super();
         this.m_ResourceManager = resourceManager;
         this.m_Resources = new Vector.<SoundResource>();
         this.m_Trans = new SoundTransform();
         var blankSound:Sound = new Sound();
         blankSound.addEventListener(SampleDataEvent.SAMPLE_DATA,this.HandleBlankSound);
         blankSound.play();
      }
      
      public function mute() : void
      {
         this.m_MutedVolume = this.m_Trans.volume;
         this.setVolume(0);
         this.m_Muted = true;
         dispatchEvent(SoundEvent.Muted());
      }
      
      public function unmute() : void
      {
         this.m_Muted = false;
         this.setVolume(this.m_MutedVolume);
         dispatchEvent(SoundEvent.Unmuted());
      }
      
      public function toggleMute() : void
      {
         if(this.m_Muted)
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
         var len:int = this.m_Resources.length;
         for(var i:int = 0; i < len; i++)
         {
            res = this.m_Resources[i];
            res.stop();
         }
      }
      
      public function pauseAll() : void
      {
         var res:SoundResource = null;
         var len:int = this.m_Resources.length;
         for(var i:int = 0; i < len; i++)
         {
            res = this.m_Resources[i];
            res.pause();
         }
      }
      
      public function resumeAll() : void
      {
         var res:SoundResource = null;
         var len:int = this.m_Resources.length;
         for(var i:int = 0; i < len; i++)
         {
            res = this.m_Resources[i];
            res.resume();
         }
      }
      
      public function setVolume(volume:Number) : void
      {
         if(this.m_Muted)
         {
            this.m_MutedVolume = volume;
            return;
         }
         this.m_Trans.volume = volume;
         SoundMixer.soundTransform = this.m_Trans;
      }
      
      public function isMuted() : Boolean
      {
         return this.m_Muted;
      }
      
      public function playSound(id:String, numPlays:int = 1) : SoundInst
      {
         var res:SoundResource = this.getSoundResource(id);
         if(res == null)
         {
            throw new Error("Could not find sound id " + id);
         }
         return res.play(numPlays);
      }
      
      public function loopSound(id:String) : SoundInst
      {
         var res:SoundResource = this.getSoundResource(id);
         if(res == null)
         {
            throw new Error("Could not find sound id " + id);
         }
         return res.loop();
      }
      
      public function getSoundResource(id:String) : SoundResource
      {
         var obj:Object = this.m_ResourceManager.GetResource(id);
         var desc:SoundDescriptor = obj as SoundDescriptor;
         if(desc == null)
         {
            throw new Error("Could not find sound id " + id);
         }
         var res:SoundResource = desc.getResource();
         if(res == null)
         {
            throw new Error("Could not find sound id " + id);
         }
         if(res.resourceId < 0)
         {
            res.resourceId = this.m_Resources.length;
            this.m_Resources[this.m_Resources.length] = res;
         }
         return res;
      }
      
      private function HandleBlankSound(e:SampleDataEvent) : void
      {
      }
   }
}
