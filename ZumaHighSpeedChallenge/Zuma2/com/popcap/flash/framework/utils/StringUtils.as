package com.popcap.flash.framework.utils
{
   public class StringUtils
   {
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function InsertNumberCommas(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = param1.toString();
         while(_loc3_.length > 3)
         {
            _loc2_ = "," + _loc3_.substr(_loc3_.length - 3,_loc3_.length) + _loc2_;
            _loc3_ = _loc3_.substr(0,_loc3_.length - 3);
         }
         return _loc3_ + _loc2_;
      }
   }
}
