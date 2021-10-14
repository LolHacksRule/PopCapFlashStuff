package idv.cjcat.stardustextended.common.clocks
{
   public interface ClockCollector
   {
       
      
      function addClock(param1:Clock) : void;
      
      function removeClock(param1:Clock) : void;
      
      function clearClocks() : void;
   }
}
