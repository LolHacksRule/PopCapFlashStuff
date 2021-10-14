package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.twoD.display.IStardustSprite;
   
   public class StardustSpriteUpdate extends Action2D
   {
       
      
      public function StardustSpriteUpdate()
      {
         super();
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc5_:IStardustSprite;
         if(_loc5_ = param2.target as IStardustSprite)
         {
            _loc5_.update(param1,param2,param3);
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "StardustSpriteUpdate";
      }
   }
}
