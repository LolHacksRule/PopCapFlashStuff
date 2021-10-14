package idv.cjcat.stardustextended.common.math
{
   public class StardustMath
   {
      
      public static const HALF_PI:Number = 0.5 * Math.PI;
      
      public static const TWO_PI:Number = 2 * Math.PI;
      
      public static const DEGREE_TO_RADIAN:Number = Math.PI / 180;
      
      public static const RADIAN_TO_DEGREE:Number = 180 / Math.PI;
       
      
      public function StardustMath()
      {
         super();
      }
      
      public static function clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function interpolate(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         return param2 - (param2 - param4) * (param1 - param5) / (param1 - param3);
      }
      
      public static function mod(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param1 % param2;
         return _loc3_ < 0 ? Number(_loc3_ + param2) : Number(_loc3_);
      }
      
      public static function randomFloor(param1:Number) : int
      {
         var _loc2_:* = param1 | 0;
         return _loc2_ + int(param1 - _loc2_ > Math.random() ? 1 : 0);
      }
   }
}
