package idv.cjcat.stardustextended.twoD.fields
{
   import idv.cjcat.stardustextended.common.StardustElement;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class Field extends StardustElement
   {
       
      
      public var active:Boolean;
      
      public var massless:Boolean;
      
      private var md2D:MotionData2D;
      
      private var mass_inv:Number;
      
      public function Field()
      {
         super();
         this.active = true;
         this.massless = true;
      }
      
      public final function getMotionData2D(param1:Particle2D) : MotionData2D
      {
         if(!this.active)
         {
            return MotionData2DPool.get(0,0);
         }
         this.md2D = this.calculateMotionData2D(param1);
         if(!this.massless)
         {
            this.mass_inv = 1 / param1.mass;
            this.md2D.x *= this.mass_inv;
            this.md2D.y *= this.mass_inv;
         }
         return this.md2D;
      }
      
      protected function calculateMotionData2D(param1:Particle2D) : MotionData2D
      {
         return null;
      }
      
      override public function getXMLTagName() : String
      {
         return "Field";
      }
      
      override public function getElementTypeXMLTag() : XML
      {
         return <fields/>;
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@active = this.active;
         _loc1_.@massless = this.massless;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@active.length())
         {
            this.active = param1.@active == "true";
         }
         if(param1.@massless.length())
         {
            this.massless = param1.@massless == "true";
         }
      }
   }
}
