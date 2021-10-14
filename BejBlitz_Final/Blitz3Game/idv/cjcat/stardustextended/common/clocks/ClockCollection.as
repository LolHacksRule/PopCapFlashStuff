package idv.cjcat.stardustextended.common.clocks
{
   import idv.cjcat.stardustextended.sd;
   
   use namespace sd;
   
   public class ClockCollection implements ClockCollector
   {
       
      
      sd var clocks:Array;
      
      public function ClockCollection()
      {
         super();
         this.clocks = [];
      }
      
      public final function addClock(param1:Clock) : void
      {
         this.clocks.push(param1);
      }
      
      public final function removeClock(param1:Clock) : void
      {
         var _loc2_:int = 0;
         while((_loc2_ = this.clocks.indexOf(param1)) >= 0)
         {
            this.clocks.splice(_loc2_,1);
         }
      }
      
      public final function clearClocks() : void
      {
         this.clocks = [];
      }
   }
}
