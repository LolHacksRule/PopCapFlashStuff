package idv.cjcat.stardustextended.common.actions.triggers
{
   import idv.cjcat.stardustextended.common.actions.Action;
   import idv.cjcat.stardustextended.common.actions.CompositeAction;
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   
   use namespace sd;
   
   public class ActionTrigger extends CompositeAction
   {
       
      
      public var inverted:Boolean;
      
      public function ActionTrigger(param1:Boolean = false)
      {
         super();
         this.inverted = param1;
      }
      
      public function testTrigger(param1:Emitter, param2:Particle, param3:Number) : Boolean
      {
         return false;
      }
      
      override public final function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         var _loc7_:Action = null;
         var _loc5_:Array = sd::actionCollection.actions;
         var _loc6_:* = Boolean(this.testTrigger(param1,param2,param3));
         if(this.inverted)
         {
            _loc6_ = !_loc6_;
         }
         if(_loc6_)
         {
            for each(_loc7_ in _loc5_)
            {
               _loc7_.update(param1,param2,param3,param4);
            }
         }
      }
      
      override public function getXMLTagName() : String
      {
         return "ActionTrigger";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <triggers/>;
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         if(_loc1_.@inverted.length())
         {
            _loc1_.@inverted = this.inverted;
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         this.inverted = param1.@inverted == "true";
      }
   }
}
