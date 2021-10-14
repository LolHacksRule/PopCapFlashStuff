package idv.cjcat.stardustextended.twoD.zones
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   
   public class Contour extends Zone
   {
       
      
      private var _virtualThickness:Number;
      
      public function Contour()
      {
         super();
         this._virtualThickness = 1;
      }
      
      public final function get virtualThickness() : Number
      {
         return this._virtualThickness;
      }
      
      public final function set virtualThickness(param1:Number) : void
      {
         this._virtualThickness = param1;
         updateArea();
      }
      
      override public function getXMLTagName() : String
      {
         return "Contour";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@virtualThickness = this.virtualThickness;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@virtualThickness.length())
         {
            this.virtualThickness = parseFloat(param1.@virtualThickness);
         }
      }
   }
}
