package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class BlazingSpeedParticle extends BaseParticle
   {
      
      private static var Asset:Class = BlazingSpeedParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function BlazingSpeedParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
