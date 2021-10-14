package com.popcap.flash.framework.utils
{
   public class StringUtils
   {
      
      public static var thousandsSeparator:String = ",";
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function InsertNumberCommas(value:int) : String
      {
         var str:String = "";
         var needsNegative:Boolean = false;
         if(value < 0)
         {
            needsNegative = true;
         }
         var front:String = Math.abs(value).toString();
         while(front.length > 3)
         {
            str = thousandsSeparator + front.substr(front.length - 3,front.length) + str;
            front = front.substr(0,front.length - 3);
         }
         str = front + str;
         if(needsNegative)
         {
            str = "-" + str;
         }
         return str;
      }
   }
}
