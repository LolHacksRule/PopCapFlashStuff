package idv.cjcat.stardustextended.twoD.geom
{
   import flash.geom.Point;
   import idv.cjcat.stardustextended.common.math.StardustMath;
   
   public class Vec2D extends Point
   {
       
      
      public function Vec2D(param1:Number = 0, param2:Number = 0)
      {
         super();
         x = param1;
         y = param2;
      }
      
      override public function clone() : Point
      {
         return new Vec2D(x,y);
      }
      
      public function set length(param1:Number) : void
      {
         if(x == 0 && y == 0)
         {
            return;
         }
         var _loc2_:Number = param1 / length;
         x *= _loc2_;
         y *= _loc2_;
      }
      
      public function dot(param1:Vec2D) : Number
      {
         return x * param1.x + y * param1.y;
      }
      
      public function project(param1:Vec2D) : Vec2D
      {
         var _loc2_:Vec2D = Vec2D(this.clone());
         _loc2_.projectThis(param1);
         return _loc2_;
      }
      
      public function projectThis(param1:Vec2D) : void
      {
         var _loc2_:Vec2D = Vec2DPool.get(param1.x,param1.y);
         _loc2_.length = 1;
         _loc2_.length = this.dot(_loc2_);
         x = _loc2_.x;
         y = _loc2_.y;
         Vec2DPool.recycle(_loc2_);
      }
      
      public function rotate(param1:Number, param2:Boolean = false) : Vec2D
      {
         var _loc3_:Vec2D = new Vec2D(x,y);
         _loc3_.rotateThis(param1,param2);
         return _loc3_;
      }
      
      public function rotateThis(param1:Number, param2:Boolean = false) : void
      {
         if(!param2)
         {
            param1 *= StardustMath.DEGREE_TO_RADIAN;
         }
         var _loc3_:Number = x;
         x = _loc3_ * Math.cos(param1) - y * Math.sin(param1);
         y = _loc3_ * Math.sin(param1) + y * Math.cos(param1);
      }
      
      public function get angle() : Number
      {
         return Math.atan2(y,x) * StardustMath.RADIAN_TO_DEGREE;
      }
      
      public function set angle(param1:Number) : void
      {
         var _loc2_:Number = length;
         var _loc3_:Number = param1 * StardustMath.DEGREE_TO_RADIAN;
         x = _loc2_ * Math.cos(_loc3_);
         y = _loc2_ * Math.sin(_loc3_);
      }
   }
}
