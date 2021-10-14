package com.popcap.flash.framework.utils
{
   public class StringUtils
   {
      
      public static var thousandsSeparator:String = ",";
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function InsertNumberCommas(param1:Number) : String
      {
         var _loc2_:String = "";
         var _loc3_:Boolean = false;
         if(param1 < 0)
         {
            _loc3_ = true;
         }
         var _loc4_:String = Math.abs(param1).toString();
         while(_loc4_.length > 3)
         {
            _loc2_ = thousandsSeparator + _loc4_.substr(_loc4_.length - 3,_loc4_.length) + _loc2_;
            _loc4_ = _loc4_.substr(0,_loc4_.length - 3);
         }
         _loc2_ = _loc4_ + _loc2_;
         if(_loc3_)
         {
            _loc2_ = "-" + _loc2_;
         }
         return _loc2_;
      }
   }
}
