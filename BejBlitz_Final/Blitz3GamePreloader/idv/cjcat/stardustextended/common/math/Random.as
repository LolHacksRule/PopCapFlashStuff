package idv.cjcat.stardustextended.common.math
{
   import idv.cjcat.stardustextended.common.StardustElement;
   
   public class Random extends StardustElement
   {
       
      
      public function Random()
      {
         super();
      }
      
      public function random() : Number
      {
         return 0.5;
      }
      
      public function setRange(param1:Number, param2:Number) : void
      {
      }
      
      public function getRange() : Array
      {
         return [0.5,0.5];
      }
      
      override public function getXMLTagName() : String
      {
         return "Random";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <randoms/>;
      }
   }
}
