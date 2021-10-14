package idv.cjcat.stardustextended.common
{
   import flash.utils.Dictionary;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.common.xml.XMLConvertible;
   
   public class StardustElement implements XMLConvertible
   {
      
      private static var elementCounter:Dictionary = new Dictionary();
       
      
      public var name:String;
      
      public function StardustElement()
      {
         super();
         var _loc1_:String = this.getXMLTagName();
         if(elementCounter[_loc1_] == undefined)
         {
            elementCounter[_loc1_] = 0;
         }
         else
         {
            ++elementCounter[_loc1_];
         }
         this.name = _loc1_ + "_" + elementCounter[_loc1_];
      }
      
      public function getRelatedObjects() : Array
      {
         return [];
      }
      
      public function getXMLTagName() : String
      {
         return "StardustElement";
      }
      
      public final function getXMLTag() : XML
      {
         var _loc1_:XML = XML("<" + this.getXMLTagName() + "/>");
         _loc1_.@name = this.name;
         return _loc1_;
      }
      
      public function getElementTypeXMLTag() : XML
      {
         return <elements/>;
      }
      
      public function toXML() : XML
      {
         return this.getXMLTag();
      }
      
      public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         this.name = param1.@name;
      }
   }
}
