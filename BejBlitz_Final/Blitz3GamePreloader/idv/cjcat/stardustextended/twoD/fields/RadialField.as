package idv.cjcat.stardustextended.twoD.fields
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData2DPool;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class RadialField extends Field
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var strength:Number;
      
      public var attenuationPower:Number;
      
      public var epsilon:Number;
      
      private var r:Vec2D;
      
      private var len:Number;
      
      public function RadialField(param1:Number = 0, param2:Number = 0, param3:Number = 1, param4:Number = 0, param5:Number = 1)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.strength = param3;
         this.attenuationPower = param4;
         this.epsilon = param5;
      }
      
      override protected function calculateMotionData2D(param1:Particle2D) : MotionData2D
      {
         this.r = Vec2DPool.get(param1.x - this.x,param1.y - this.y);
         this.len = this.r.length;
         if(this.len < this.epsilon)
         {
            this.len = this.epsilon;
         }
         this.r.length = this.strength * Math.pow(this.len,-0.5 * this.attenuationPower);
         Vec2DPool.recycle(this.r);
         return MotionData2DPool.get(this.r.x,this.r.y);
      }
      
      override public function getXMLTagName() : String
      {
         return "RadialField";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@strength = this.strength;
         _loc1_.@attenuationPower = this.attenuationPower;
         _loc1_.@epsilon = this.epsilon;
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         super.parseXML(param1,param2);
         if(param1.@x.length())
         {
            this.x = parseFloat(param1.@x);
         }
         if(param1.@y.length())
         {
            this.y = parseFloat(param1.@y);
         }
         if(param1.@strength.length())
         {
            this.strength = parseFloat(param1.@strength);
         }
         if(param1.@attenuationPower.length())
         {
            this.attenuationPower = parseFloat(param1.@attenuationPower);
         }
         if(param1.@epsilon.length())
         {
            this.epsilon = parseFloat(param1.@epsilon);
         }
      }
   }
}
