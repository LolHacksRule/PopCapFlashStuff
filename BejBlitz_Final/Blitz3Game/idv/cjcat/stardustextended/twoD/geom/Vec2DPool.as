package idv.cjcat.stardustextended.twoD.geom
{
   public class Vec2DPool
   {
      
      private static const _vec:Vector.<Vec2D> = new <Vec2D>[new Vec2D()];
      
      private static var _position:int = 0;
       
      
      public function Vec2DPool()
      {
         super();
      }
      
      public static function get(param1:Number = 0, param2:Number = 0) : Vec2D
      {
         var _loc4_:int = 0;
         if(_position == _vec.length)
         {
            _vec.length <<= 1;
            _loc4_ = _position;
            while(_loc4_ < _vec.length)
            {
               _vec[_loc4_] = new Vec2D();
               _loc4_++;
            }
         }
         var _loc3_:Vec2D = _vec[_position];
         _loc3_.setTo(param1,param2);
         ++_position;
         return _loc3_;
      }
      
      public static function recycle(param1:Vec2D) : void
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
