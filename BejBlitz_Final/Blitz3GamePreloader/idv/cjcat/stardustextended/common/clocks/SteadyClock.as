package idv.cjcat.stardustextended.common.clocks
{
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class SteadyClock extends Clock
   {
       
      
      private var _ticksPerCall:Number;
      
      public function SteadyClock(param1:Number = 0)
      {
         super();
         this.ticksPerCall = param1;
      }
      
      override public final function getTicks(param1:Number) : int
      {
         return StardustMath.randomFloor(this.ticksPerCall * param1);
      }
      
      public function get ticksPerCall() : Number
      {
         return this._ticksPerCall;
      }
      
      public function set ticksPerCall(param1:Number) : void
      {
         this._ticksPerCall = param1;
      }
      
      override public function getXMLTagName() : String
      {
         return "SteadyClock";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@ticksPerCall = this.ticksPerCall;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@ticksPerCall.length())
         {
            this.ticksPerCall = parseFloat(param1.@ticksPerCall);
         }
      }
   }
}
