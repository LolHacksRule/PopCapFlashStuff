package idv.cjcat.stardustextended.common.clocks
{
   import idv.cjcat.stardustextended.common.StardustElement;
   
   public class Clock extends StardustElement
   {
       
      
      public function Clock()
      {
         super();
      }
      
      public function getTicks(param1:Number) : int
      {
         return 0;
      }
      
      public function reset() : void
      {
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <clocks/>;
      }
   }
}
