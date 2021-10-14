package idv.cjcat.stardustextended.twoD.deflectors
{
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Deflector extends StardustElement
   {
       
      
      public var active:Boolean;
      
      public var bounce:Number;
      
      public function Deflector()
      {
         super();
         this.active = true;
         this.bounce = 0.8;
      }
      
      public final function getMotionData4D(param1:Particle2D) : MotionData4D
      {
         if(this.active)
         {
            return this.calculateMotionData4D(param1);
         }
         return null;
      }
      
      protected function calculateMotionData4D(param1:Particle2D) : MotionData4D
      {
         return null;
      }
      
      override public function getXMLTagName() : String
      {
         return "Deflector";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <deflectors/>;
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@active = this.active;
         _loc1_.@bounce = this.bounce;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@active.length())
         {
            this.active = param1.@active == "true";
         }
         if(param1.@bounce.length())
         {
            this.bounce = parseFloat(param1.@bounce);
         }
      }
   }
}
