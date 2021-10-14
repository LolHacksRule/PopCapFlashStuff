package idv.cjcat.stardustextended.twoD.deflectors
{
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4D;
   import idv.cjcat.stardustextended.twoD.geom.MotionData4DPool;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class LineDeflector extends Deflector
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      private var _normal:Vec2D;
      
      private var r:Vec2D;
      
      private var dot:Number;
      
      private var radius:Number;
      
      private var dist:Number;
      
      private var v:Vec2D;
      
      private var factor:Number;
      
      public function LineDeflector(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = -1)
      {
         super();
         this.x = param1;
         this.y = param2;
         this._normal = new Vec2D(param3,param4);
      }
      
      public function get normal() : Vec2D
      {
         return this._normal;
      }
      
      override protected function calculateMotionData4D(param1:Particle2D) : MotionData4D
      {
         this.r = Vec2DPool.get(param1.x - this.x,param1.y - this.y);
         this.r = this.r.project(this.normal);
         this.dot = this.r.dot(this.normal);
         this.radius = param1.collisionRadius * param1.scale;
         this.dist = this.r.length;
         if(this.dot > 0)
         {
            if(this.dist > this.radius)
            {
               Vec2DPool.recycle(this.r);
               return null;
            }
            this.r.length = this.radius - this.dist;
         }
         else
         {
            this.r.length = -(this.dist + this.radius);
         }
         this.v = Vec2DPool.get(param1.vx,param1.vy);
         this.v = this.v.project(this.normal);
         this.factor = 1 + bounce;
         Vec2DPool.recycle(this.r);
         Vec2DPool.recycle(this.v);
         return MotionData4DPool.get(param1.x + this.r.x,param1.y + this.r.y,param1.vx - this.v.x * this.factor,param1.vy - this.v.y * this.factor);
      }
      
      override public function getXMLTagName() : String
      {
         return "LineDeflector";
      }
      
      override public function toXML() : XML
      {
         var _loc1_:XML = super.toXML();
         _loc1_.@x = this.x;
         _loc1_.@y = this.y;
         _loc1_.@normalX = this.normal.x;
         _loc1_.@normalY = this.normal.y;
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
         if(param1.@normalX.length())
         {
            this.normal.x = parseFloat(param1.@normalX);
         }
         if(param1.@normalY.length())
         {
            this.normal.y = parseFloat(param1.@normalY);
         }
      }
   }
}
