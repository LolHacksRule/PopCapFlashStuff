package com.popcap.flash.framework.utils
{
   public class VectorFactory
   {
       
      
      public function VectorFactory()
      {
         super();
      }
      
      public static function createForString(param1:Array) : Vector.<String>
      {
         var _loc3_:String = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function createForInt(param1:Array) : Vector.<int>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
   }
}
