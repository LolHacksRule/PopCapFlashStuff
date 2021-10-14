package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class SpecialUpgradeParticle extends BaseParticle
   {
      
      private static var Asset:Class = SpecialUpgradeParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function SpecialUpgradeParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
