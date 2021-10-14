package com.popcap.flash.bejeweledblitz.particles
{
   import flash.utils.ByteArray;
   
   public class ColorBlast_PulseStarField extends BaseParticle
   {
      
      private static var Asset:Class = ColorBlast_PulseStarField_Asset;
      
      private static var assetInstance:ByteArray = new Asset();
       
      
      public function ColorBlast_PulseStarField()
      {
         super();
         loadSim(assetInstance);
      }
   }
}
