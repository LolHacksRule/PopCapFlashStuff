package com.popcap.flash.bejeweledblitz
{
   import flash.external.ExternalInterface;
   
   public class ServerURLResolver
   {
      
      private static const _JS_LOAD_RESOURCES_SHA_DICT:String = "Bej.ResourceURLGenerator.getResources";
      
      private static var _resourceJson:Object;
       
      
      public function ServerURLResolver()
      {
         super();
      }
      
      public static function init() : void
      {
         var _loc1_:Object = null;
         if(_resourceJson == null)
         {
            _loc1_ = ExternalCall(_JS_LOAD_RESOURCES_SHA_DICT);
            if(_loc1_ != null)
            {
               _resourceJson = JSON.parse(_loc1_.toString());
            }
         }
      }
      
      public static function resolveUrl(param1:String) : String
      {
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         try
         {
            init();
            _loc2_ = param1.lastIndexOf("/");
            _loc3_ = param1.slice(0,_loc2_);
            _loc4_ = param1.slice(_loc2_ + 1,param1.length);
            if(_resourceJson != null && _resourceJson[_loc3_] != null && _resourceJson[_loc3_][_loc4_] != null)
            {
               _loc5_ = _resourceJson[_loc3_][_loc4_];
               return "/v" + _loc5_ + param1;
            }
         }
         catch(err:Error)
         {
         }
         return param1;
      }
      
      public static function ExternalCall(param1:String, ... rest) : Object
      {
         if(!ExternalInterface.available)
         {
            return null;
         }
         return ExternalInterface.call(param1,rest);
      }
   }
}
