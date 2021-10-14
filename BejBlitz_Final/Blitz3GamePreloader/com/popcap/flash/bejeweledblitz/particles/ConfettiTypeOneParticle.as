package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class ConfettiTypeOneParticle extends BaseParticle
   {
      
      private static var Asset:Class = ConfettiTypeOneParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function ConfettiTypeOneParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
