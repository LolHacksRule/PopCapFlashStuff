package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class GlowBustParticle extends BaseParticle
   {
      
      private static var Asset:Class = GlowBustParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function GlowBustParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
