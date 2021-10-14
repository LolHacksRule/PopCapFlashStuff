package idv.cjcat.stardustextended.common.actions.triggers
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   
   public class DeathTrigger extends ActionTrigger
   {
       
      
      public function DeathTrigger()
      {
         super();
         priority = -20;
      }
      
      override public final function testTrigger(param1:Emitter, param2:Particle, param3:Number) : Boolean
      {
         return param2.isDead;
      }
      
      override public function getXMLTagName() : String
      {
         return "DeathTrigger";
      }
   }
}
