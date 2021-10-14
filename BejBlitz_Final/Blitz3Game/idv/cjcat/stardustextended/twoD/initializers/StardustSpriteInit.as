package idv.cjcat.stardustextended.twoD.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.twoD.display.IStardustSprite;
   
   public class StardustSpriteInit extends Initializer2D
   {
       
      
      public function StardustSpriteInit()
      {
         super();
      }
      
      override public function initialize(param1:Particle) : void
      {
         var _loc2_:IStardustSprite = param1.target as IStardustSprite;
         if(_loc2_)
         {
            _loc2_.init(param1);
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "StardustSpriteInit";
      }
   }
}
