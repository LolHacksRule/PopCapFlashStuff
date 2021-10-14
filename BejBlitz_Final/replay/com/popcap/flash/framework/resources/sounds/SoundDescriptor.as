package com.popcap.flash.framework.resources.sounds
{
   import flash.media.Sound;
   
   public class SoundDescriptor
   {
       
      
      private var mSoundClass:Class = null;
      
      private var mResource:SoundResource = null;
      
      public function SoundDescriptor(soundClass:Class)
      {
         super();
         this.mSoundClass = soundClass;
      }
      
      public function getResource() : SoundResource
      {
         if(this.mResource != null)
         {
            return this.mResource;
         }
         var sound:Sound = new this.mSoundClass();
         this.mResource = new SoundResource();
         this.mResource.sound = sound;
         return this.mResource;
      }
   }
}
