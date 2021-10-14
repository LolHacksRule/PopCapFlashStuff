package com.popcap.flash.framework.resources.sounds
{
   import flash.media.Sound;
   
   public class §_-R1§
   {
       
      
      private var §_-Ar§:SoundResource = null;
      
      private var §_-li§:Class = null;
      
      public function §_-R1§(param1:Class)
      {
         super();
         this.§_-li§ = param1;
      }
      
      public function §_-C§() : SoundResource
      {
         if(this.§_-Ar§ != null)
         {
            return this.§_-Ar§;
         }
         var _loc1_:Sound = new this.§_-li§();
         this.§_-Ar§ = new SoundResource();
         this.§_-Ar§.sound = _loc1_;
         return this.§_-Ar§;
      }
   }
}
