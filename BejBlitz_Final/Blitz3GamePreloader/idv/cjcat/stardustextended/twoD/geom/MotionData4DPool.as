package idv.cjcat.stardustextended.twoD.geom
{
   public class MotionData4DPool
   {
      
      private static var _vec:Array = [new MotionData4D()];
      
      private static var _position:int = 0;
       
      
      public function MotionData4DPool()
      {
         super();
      }
      
      public static function get(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : MotionData4D
      {
         var _loc6_:int = 0;
         if(_position == _vec.length)
         {
            _vec.length <<= 1;
            _loc6_ = _position;
            while(_loc6_ < _vec.length)
            {
               _vec[_loc6_] = new MotionData4D();
               _loc6_++;
            }
         }
         ++_position;
         var _loc5_:MotionData4D;
         (_loc5_ = _vec[_position - 1]).x = param1;
         _loc5_.y = param2;
         _loc5_.vx = param3;
         _loc5_.vy = param4;
         return _loc5_;
      }
      
      public static function recycle(param1:MotionData4D) : void
      {
         if(_position == 0)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         _vec[_position - 1] = param1;
         if(_position)
         {
            --_position;
         }
      }
   }
}
