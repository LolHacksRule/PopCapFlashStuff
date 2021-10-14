package com.jambool.net
{
   import §_-G2§.§_-eH§;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   
   public class §_-7i§ extends EventDispatcher
   {
      
      private static const §_-Js§:int = 300000;
      
      private static const §in§:int = 15000;
       
      
      public var urlRequest:URLRequest;
      
      private var §_-1X§:int;
      
      public var data;
      
      public var pollingExpirationMilliseconds:Number;
      
      public var rawData;
      
      private var §_-Mz§:Boolean;
      
      public var pollingIntervalMilliseconds:Number;
      
      public function §_-7i§()
      {
         super();
         var _loc1_:Date = new Date();
         §_-1X§ = _loc1_.getTime();
         pollingIntervalMilliseconds = §in§;
         pollingExpirationMilliseconds = §_-Js§;
      }
      
      public function get abandoned() : Boolean
      {
         if(§_-NE§() && !§_-Mz§)
         {
            abandon();
         }
         return §_-Mz§;
      }
      
      public function get url() : String
      {
         return urlRequest.url;
      }
      
      public function §_-NE§() : Boolean
      {
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime();
         var _loc3_:int = _loc2_ - §_-1X§;
         return _loc3_ >= pollingExpirationMilliseconds;
      }
      
      public function abandon() : void
      {
         §_-Mz§ = true;
         dispatchEvent(new §_-eH§(§_-eH§.§_-JV§));
      }
   }
}
