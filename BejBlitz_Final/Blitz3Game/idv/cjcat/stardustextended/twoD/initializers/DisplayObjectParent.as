package idv.cjcat.stardustextended.twoD.initializers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class DisplayObjectParent extends Initializer2D
   {
       
      
      public var container:DisplayObjectContainer;
      
      public function DisplayObjectParent(param1:DisplayObjectContainer = null)
      {
         super();
         priority = -100;
         this.container = param1;
      }
      
      override public function initialize(param1:Particle) : void
      {
         if(!this.container)
         {
            return;
         }
         var _loc2_:Particle2D = Particle2D(param1);
         var _loc3_:DisplayObject = _loc2_.target as DisplayObject;
         if(!_loc3_)
         {
            return;
         }
         this.container.addChild(_loc3_);
      }
      
      override public function getXMLTagName() : String
      {
         return "DisplayObjectParent";
      }
   }
}
