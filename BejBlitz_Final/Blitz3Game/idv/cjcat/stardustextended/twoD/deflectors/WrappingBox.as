package idv.cjcat.stardustextended.twoD.deflectors
{
   import idv.cjcat.stardustextended.common.math.StardustMath;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class WrappingBox extends Deflector
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var width:Number;
      
      public var height:Number;
      
      private var left:Number;
      
      private var right:Number;
      
      private var top:Number;
      
      private var bottom:Number;
      
      private var deflected:Boolean;
      
      private var newX:Number;
      
      private var newY:Number;
      
      public function WrappingBox(param1:Number = 0, param2:Number = 0, param3:Number = 640, param4:Number = 480)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.width = param3;
         this.height = param4;
      }
      
      override protected function calculateMotionData4D(param1:Particle2D) : MotionData4D
      {
         this.left = this.x;
         this.right = this.x + this.width;
         this.top = this.y;
         this.bottom = this.y + this.height;
         this.deflected = false;
         if(param1.x < this.x)
         {
            this.deflected = true;
         }
         else if(param1.x > this.x + this.width)
         {
            this.deflected = true;
         }
         if(param1.y < this.y)
         {
            this.deflected = true;
         }
         else if(param1.y > this.y + this.height)
         {
            this.deflected = true;
         }
         this.newX = StardustMath.mod(param1.x - this.x,this.width);
         this.newY = StardustMath.mod(param1.y - this.y,this.height);
         if(this.deflected)
         {
            return MotionData4DPool.get(this.x + this.newX,this.y + this.newY,param1.vx,param1.vy);
         }
         return null;
      }
      
      override public function getXMLTagName() : String
      {
         return "WrappingBox";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         delete _loc1_.@bounce;
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
