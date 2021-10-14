package com.popcap.flash.framework.resources.sounds
{
   import flash.media.Sound;
   
   public class SoundDescriptor
   {
       
      
      private var mResource:SoundResource = null;
      
      private var mSoundClass:Class = null;
      
      public function SoundDescriptor(param1:Class)
      {
         super();
         this.mSoundClass = param1;
      }
      
      public function getResource() : SoundResource
      {
         if(this.mResource != null)
         {
            return this.mResource;
         }
         var _loc1_:Sound = new this.mSoundClass();
         this.mResource = new SoundResource();
         this.mResource.sound = _loc1_;
         return this.mResource;
      }
   }
}
