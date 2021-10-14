package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.display.bitmapParticle.IAnimatedParticle;
   
   public class AnimateSpriteSheet extends Action2D
   {
       
      
      public function AnimateSpriteSheet()
      {
         super();
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:IAnimatedParticle;
         if(_loc5_ = param2.target as IAnimatedParticle)
         {
            _loc5_.stepSpriteSheet(param3);
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "AnimateSpriteSheet";
      }
      
      override public function toXML() : XML
      {
         return super.toXML();
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
      }
   }
}
