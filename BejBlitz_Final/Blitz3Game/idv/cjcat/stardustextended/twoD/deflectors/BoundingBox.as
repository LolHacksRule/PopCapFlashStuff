package idv.cjcat.stardustextended.twoD.deflectors
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class BoundingBox extends Deflector
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      private var radius:Number;
      
      private var left:Number;
      
      private var right:Number;
      
      private var top:Number;
      
      private var bottom:Number;
      
      private var factor:Number;
      
      private var finalX:Number;
      
      private var finalY:Number;
      
      private var finalVX:Number;
      
      private var finalVY:Number;
      
      private var deflected:Boolean;
      
      public function BoundingBox(param1:Number = 0, param2:Number = 0, param3:Number = 640, param4:Number = 480)
      {
         super();
         this.bounce = 1;
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
      }
      
      override protected function calculateMotionData4D(param1:Particle2D) : MotionData4D
      {
         this.radius = param1.collisionRadius * param1.scale;
         this.left = this.x + this.radius;
         this.right = this.x + this.width - this.radius;
         this.top = this.y + this.radius;
         this.bottom = this.y + this.height - this.radius;
         this.factor = -bounce;
         this.finalX = param1.x;
         this.finalY = param1.y;
         this.finalVX = param1.vx;
         this.finalVY = param1.vy;
         this.deflected = false;
         if(param1.x <= this.left)
         {
            this.finalX = this.left;
            this.finalVX *= this.factor;
            this.deflected = true;
         }
         else if(param1.x >= this.right)
         {
            this.finalX = this.right;
            this.finalVX *= this.factor;
            this.deflected = true;
         }
         if(param1.y <= this.top)
         {
            this.finalY = this.top;
            this.finalVY *= this.factor;
            this.deflected = true;
         }
         else if(param1.y >= this.bottom)
         {
            this.finalY = this.bottom;
            this.finalVY *= this.factor;
            this.deflected = true;
         }
         if(this.deflected)
         {
            return MotionData4DPool.get(this.finalX,this.finalY,this.finalVX,this.finalVY);
         }
         return null;
      }
      
      override public function getXMLTagName() : String
      {
         return "BoundingBox";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@width = this.width;
         _loc1_.@height = this.height;
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
         if(param1.@width.length())
         {
            this.width = parseFloat(param1.@width);
         }
         if(param1.@height.length())
         {
            this.height = parseFloat(param1.@height);
         }
      }
   }
}
