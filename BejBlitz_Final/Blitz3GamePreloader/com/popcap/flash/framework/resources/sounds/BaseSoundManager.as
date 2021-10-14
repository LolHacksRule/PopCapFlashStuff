package com.popcap.flash.framework.resources.sounds
{
   import com.popcap.flash.bejeweledblitz.Utils;
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
      
      public function BaseSoundManager(param1:ResourceManager)
      {
         super();
         this.m_ResourceManager = param1;
         this.m_Resources = new Vector.<SoundResource>();
         this.m_Trans = new SoundTransform();
         var _loc2_:Sound = new Sound();
         _loc2_.addEventListener(SampleDataEvent.SAMPLE_DATA,this.HandleBlankSound,false,0,true);
         _loc2_.play();
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
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.m_Resources.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.m_Resources[_loc2_];
            _loc3_.stop();
            _loc2_++;
         }
      }
      
      public function pauseAll() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.m_Resources.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.m_Resources[_loc2_];
            _loc3_.pause();
            _loc2_++;
         }
      }
      
      public function resumeAll() : void
      {
         var _loc3_:SoundResource = null;
         var _loc1_:int = this.m_Resources.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.m_Resources[_loc2_];
            _loc3_.resume();
            _loc2_++;
         }
      }
      
      public function setVolume(param1:Number) : void
      {
         if(this.m_Muted)
         {
            this.m_MutedVolume = param1;
            return;
         }
         this.m_Trans.volume = param1;
         SoundMixer.soundTransform = this.m_Trans;
      }
      
      public function isMuted() : Boolean
      {
         return this.m_Muted;
      }
      
      public function playSound(param1:String, param2:int = 1, param3:Number = -1) : SoundInst
      {
         var _loc4_:SoundResource;
         if((_loc4_ = this.getSoundResource(param1)) == null)
         {
            Utils.log(this,"playSound Could not find sound id " + param1);
            return new SoundInst();
         }
         return _loc4_.play(param2,param3);
      }
      
      public function playMusic(param1:String, param2:Number = 0.5) : SoundInst
      {
         var _loc3_:SoundResource = this.getSoundResource(param1);
         if(_loc3_ == null)
         {
            Utils.log(this,"playMusic Could not find sound id " + param1);
            return null;
         }
         return _loc3_.play(-1,param2);
      }
      
      public function stopSound(param1:String) : void
      {
         var _loc2_:SoundResource = this.getSoundResource(param1);
         if(_loc2_ == null)
         {
            Utils.log(this,"playSound Could not find sound id " + param1);
            return;
         }
         _loc2_.stop();
      }
      
      public function loopSound(param1:String) : SoundInst
      {
         var _loc2_:SoundResource = this.getSoundResource(param1);
         if(_loc2_ == null)
         {
            throw new Error("Could not find sound id " + param1);
         }
         return _loc2_.loop();
      }
      
      public function getSoundResource(param1:String) : SoundResource
      {
         var _loc2_:Object = this.m_ResourceManager.GetResource(param1);
         var _loc3_:SoundDescriptor = _loc2_ as SoundDescriptor;
         if(_loc3_ == null)
         {
            Utils.log(this,"getSoundResource Could not find sound id: " + param1 + " in resource manager.");
            return null;
         }
         var _loc4_:SoundResource;
         if((_loc4_ = _loc3_.getResource()) == null)
         {
            Utils.log(this,"getSoundResource Could not find sound id: " + param1 + " in sound resource.");
            return null;
         }
         if(_loc4_.resourceId < 0)
         {
            _loc4_.resourceId = this.m_Resources.length;
            this.m_Resources[this.m_Resources.length] = _loc4_;
         }
         return _loc4_;
      }
      
      private function HandleBlankSound(param1:SampleDataEvent) : void
      {
      }
   }
}
