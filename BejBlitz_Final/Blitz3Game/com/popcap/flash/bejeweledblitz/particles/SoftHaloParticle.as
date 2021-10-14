package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class SoftHaloParticle extends BaseParticle
   {
      
      private static var Asset:Class = SoftHaloParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function SoftHaloParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
