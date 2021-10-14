package idv.cjcat.stardustextended.twoD.actions
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.display.AddChildMode;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class ReorderDisplayObject extends Action2D
   {
       
      
      public var addChildMode:int;
      
      public function ReorderDisplayObject(param1:int = 0)
      {
         super();
         this.addChildMode = param1;
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc6_:DisplayObject;
         var _loc5_:Particle2D;
         var _loc7_:DisplayObjectContainer = (_loc6_ = (_loc5_ = Particle2D(param2)).target as DisplayObject).parent as DisplayObjectContainer;
         switch(this.addChildMode)
         {
            case AddChildMode.TOP:
               _loc7_.addChild(_loc6_);
               break;
            case AddChildMode.BOTTOM:
               _loc7_.addChildAt(_loc6_,0);
               break;
            default:
               _loc7_.addChildAt(_loc6_,Math.floor(Math.random() * _loc7_.numChildren));
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "ReorderDisplayObject";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@addChildMode = this.addChildMode;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@addChildMode.length())
         {
            this.addChildMode = parseInt(param1.@addChildMode);
         }
      }
   }
}
