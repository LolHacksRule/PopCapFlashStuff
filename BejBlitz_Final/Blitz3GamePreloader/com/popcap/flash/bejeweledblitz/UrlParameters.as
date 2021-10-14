package com.popcap.flash.bejeweledblitz
{
   import flash.external.ExternalInterface;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class UrlParameters
   {
      
      private static var instance:UrlParameters;
       
      
      private var url:String;
      
      private var params:Dictionary;
      
      public function UrlParameters()
      {
         super();
         this.params = new Dictionary();
         this.LoadUrlParams();
      }
      
      public static function Get() : UrlParameters
      {
         if(instance == null)
         {
            instance = new UrlParameters();
         }
         return instance;
      }
      
      public function GetUrl() : String
      {
         return this.url;
      }
      
      public function GetParams() : Dictionary
      {
         return this.params;
      }
      
      public function GetParam(param1:String) : String
      {
         if(this.params.hasOwnProperty(param1))
         {
            return this.params[param1];
         }
         return "";
      }
      
      public function InjectParams(param1:URLVariables) : void
      {
         var _loc2_:* = null;
         var _loc3_:String = null;
         for(_loc2_ in this.params)
         {
            _loc3_ = this.params[_loc2_] as String;
            param1[_loc2_] = _loc3_;
         }
      }
      
      private function LoadUrlParams() : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         this.url = String(ExternalInterface.call("window.location.href.toString"));
         var _loc1_:String = ExternalInterface.call("window.location.search.substring");
         _loc1_ = _loc1_.slice(1,_loc1_.length);
         var _loc2_:Array = _loc1_.split("&");
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.split("=");
            this.params[_loc4_[0]] = _loc4_[1];
         }
      }
   }
}
