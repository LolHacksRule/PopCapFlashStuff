package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class GlowEmitBottomParticle extends BaseParticle
   {
      
      private static var Asset:Class = GlowEmitBottomParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function GlowEmitBottomParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
