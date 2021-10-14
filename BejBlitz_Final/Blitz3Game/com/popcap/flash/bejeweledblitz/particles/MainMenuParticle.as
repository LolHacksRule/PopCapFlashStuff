package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class MainMenuParticle extends BaseParticle
   {
      
      private static var Asset:Class = MainMenuParticle_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function MainMenuParticle()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
