package idv.cjcat.stardustextended.common.particles
{
   public interface InfoRecycler
   {
       
      
      function recycleInfo(param1:Particle) : void;
      
      function get needsRecycle() : Boolean;
   }
}
