package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class MaxLevelParticle extends BaseParticle
   {
      
      private static var Asset:Class = MaxLevelParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function MaxLevelParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
