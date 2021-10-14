package idv.cjcat.stardustextended.common.actions.triggers
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class LifeTrigger extends ActionTrigger
   {
       
      
      public var triggerWithinBounds:Boolean;
      
      public var triggerEvery:Number;
      
      private var _lowerBound:Number;
      
      private var _upperBound:Number;
      
      public function LifeTrigger(param1:Number = 0, param2:Number = 1.7976931348623157E308, param3:Boolean = true, param4:Number = 1)
      {
         super();
         priority = 5;
         this.lowerBound = param1;
         this.upperBound = param2;
         this.triggerWithinBounds = param3;
         this.triggerEvery = param4;
      }
      
      override public final function testTrigger(param1:Emitter, param2:Particle, param3:Number) : Boolean
      {
         if(this.triggerWithinBounds)
         {
            if(param2.life >= this.lowerBound && param2.life <= this.upperBound)
            {
               return param2.life % this.triggerEvery < param3;
            }
         }
         else if(param2.life < this.lowerBound || param2.life > this.upperBound)
         {
            return param2.life % this.triggerEvery < param3;
         }
         return false;
      }
      
      public function get lowerBound() : Number
      {
         return this._lowerBound;
      }
      
      public function set lowerBound(param1:Number) : void
      {
         if(param1 > this._upperBound)
         {
            this._upperBound = param1;
         }
         this._lowerBound = param1;
      }
      
      public function get upperBound() : Number
      {
         return this._upperBound;
      }
      
      public function set upperBound(param1:Number) : void
      {
         if(param1 < this._lowerBound)
         {
            this._lowerBound = param1;
         }
         this._upperBound = param1;
      }
      
      override public function getXMLTagName() : String
      {
         return "LifeTrigger";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         if(_loc1_.@triggerWithinBounds.length())
         {
            _loc1_.@triggerWithinBounds = this.triggerWithinBounds;
         }
         if(_loc1_.@triggerEvery.length())
         {
            _loc1_.@triggerEvery = this.triggerEvery;
         }
         if(_loc1_.@lowerBound.length())
         {
            _loc1_.@lowerBound = this.lowerBound;
         }
         if(_loc1_.@upperBound.length())
         {
            _loc1_.@upperBound = this.upperBound;
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         this.triggerWithinBounds = param1.@triggerWithinBounds == "true";
         this.triggerEvery = parseFloat(param1.@triggerEvery);
         this.lowerBound = parseFloat(param1.@lowerBound);
         this.upperBound = parseFloat(param1.@upperBound);
      }
   }
}
