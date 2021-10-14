package idv.cjcat.stardustextended.twoD.initializers
{
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.utils.construct;
   
   public class DisplayObjectClass extends Initializer2D
   {
       
      
      public var displayObjectClass:Class;
      
      public var constructorParams:Array;
      
      public function DisplayObjectClass(param1:Class = null, param2:Array = null)
      {
         super();
         priority = 1;
         this.displayObjectClass = param1;
         this.constructorParams = param2;
      }
      
      override public function initialize(param1:Particle) : void
      {
         if(!this.displayObjectClass)
         {
            return;
         }
         param1.target = construct(this.displayObjectClass,this.constructorParams);
      }
      
      override public function getXMLTagName() : String
      {
         return "DisplayObjectClass";
      }
   }
}
