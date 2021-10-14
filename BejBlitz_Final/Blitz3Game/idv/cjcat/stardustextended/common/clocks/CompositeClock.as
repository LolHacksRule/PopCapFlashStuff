package idv.cjcat.stardustextended.common.clocks
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.sd;
   
   public class CompositeClock extends Clock implements ClockCollector
   {
       
      
      protected var clockCollection:ClockCollection;
      
      public function CompositeClock()
      {
         super();
         this.clockCollection = new ClockCollection();
      }
      
      override public final function getTicks(param1:Number) : int
      {
         var _loc3_:Clock = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.clockCollection.sd::clocks)
         {
            _loc2_ += _loc3_.getTicks(param1);
         }
         return _loc2_;
      }
      
      public final function addClock(param1:Clock) : void
      {
         this.clockCollection.addClock(param1);
      }
      
      public final function removeClock(param1:Clock) : void
      {
         this.clockCollection.removeClock(param1);
      }
      
      public final function clearClocks() : void
      {
         this.clockCollection.clearClocks();
      }
      
      override public function getRelatedObjects() : Array
      {
         return this.clockCollection.sd::clocks.concat();
      }
      
      override public function getXMLTagName() : String
      {
         return "CompositeClock";
      }
      
      override public function toXML() : XML
      {
         var _loc2_:Clock = null;
         var _loc1_:XML = super.toXML();
         if(this.clockCollection.sd::clocks.length > 0)
         {
            _loc1_.appendChild(<clocks/>);
            for each(_loc2_ in this.clockCollection.sd::clocks)
            {
               _loc1_.clocks.appendChild(_loc2_.getXMLTag());
            }
         }
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         super.parseXML(param1,param2);
         this.clearClocks();
         for each(_loc3_ in param1.clocks.*)
         {
            this.addClock(param2.getElementByName(_loc3_.@name) as Clock);
         }
      }
   }
}
