package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class GlowEmitTopParticle extends BaseParticle
   {
      
      private static var Asset:Class = GlowEmitTopParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function GlowEmitTopParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
