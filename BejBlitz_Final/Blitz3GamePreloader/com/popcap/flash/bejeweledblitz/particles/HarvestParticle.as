package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class HarvestParticle extends BaseParticle
   {
      
      private static var Asset:Class = HarvestParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function HarvestParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
