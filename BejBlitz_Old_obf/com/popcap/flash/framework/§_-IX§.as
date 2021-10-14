package com.popcap.flash.framework
{
   public class §_-IX§
   {
       
      
      public function §_-IX§()
      {
         super();
      }
      
      public static function §_-Br§(param1:String, param2:Number = 0) : Number
      {
         if(param1 == null)
         {
            return param2;
         }
         var _loc3_:Number = parseFloat(param1);
         if(isNaN(_loc3_))
         {
            return param2;
         }
         return _loc3_;
      }
      
      public static function §_-Gl§(param1:String, param2:Boolean = false) : Boolean
      {
         if(param1 == null || param1.length == 0)
         {
            return param2;
         }
         if(param1.toLowerCase() == "true")
         {
            return true;
         }
         var _loc3_:Number = parseFloat(param1);
         if(isNaN(_loc3_))
         {
            return false;
         }
         if(_loc3_ > 0)
         {
            return true;
         }
         return false;
      }
   }
}
