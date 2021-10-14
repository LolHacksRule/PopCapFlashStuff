package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class ConfettiTypeTwoParticle extends BaseParticle
   {
      
      private static var Asset:Class = ConfettiTypeTwoParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function ConfettiTypeTwoParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
