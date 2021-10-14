package idv.cjcat.stardustextended.twoD.deflectors
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4DPool;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class BoundingCircle extends Deflector
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var radius:Number;
      
      private var cr:Number;
      
      private var r:Vec2D;
      
      private var len:Number;
      
      private var v:Vec2D;
      
      private var factor:Number;
      
      public function BoundingCircle(param1:Number = 0, param2:Number = 0, param3:Number = 100)
      {
         super();
         this.bounce = 1;
         this.x = param1;
         this.y = param2;
         this.radius = param3;
      }
      
      override protected function calculateMotionData4D(param1:Particle2D) : MotionData4D
      {
         this.cr = param1.collisionRadius * param1.scale;
         this.r = Vec2DPool.get(param1.x - this.x,param1.y - this.y);
         this.len = this.r.length + this.cr;
         if(this.len < this.radius)
         {
            Vec2DPool.recycle(this.r);
            return null;
         }
         this.r.length = this.radius - this.cr;
         this.v = Vec2DPool.get(param1.vx,param1.vy);
         this.v.projectThis(this.r);
         this.factor = 1 + bounce;
         Vec2DPool.recycle(this.r);
         Vec2DPool.recycle(this.v);
         return MotionData4DPool.get(this.x + this.r.x,this.y + this.r.y,param1.vx - this.factor * this.v.x,param1.vy - this.factor * this.v.y);
      }
      
      override public function getXMLTagName() : String
      {
         return "BoundingCircle";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@radius = this.radius;
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
         if(param1.@radius.length())
         {
            this.radius = parseFloat(param1.@radius);
         }
      }
   }
}
