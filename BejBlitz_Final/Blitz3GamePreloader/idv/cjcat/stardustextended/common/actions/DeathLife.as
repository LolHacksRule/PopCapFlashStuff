package idv.cjcat.stardustextended.common.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   
   public class DeathLife extends Action
   {
       
      
      public var threshold:Number;
      
      public function DeathLife()
      {
         super();
      }
      
      override public final function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         if(param2.life <= 0)
         {
            param2.isDead = true;
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "DeathLife";
      }
   }
}
