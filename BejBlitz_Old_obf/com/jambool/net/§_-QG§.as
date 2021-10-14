package com.jambool.net
{
   import §_-0q§.§null §;
   import §_-12§.§_-XM§;
   import §_-AV§.§_-WS§;
   import §_-G2§.§_-eH§;
   import com.adobe.serialization.json.§_-3V§;
   import com.jambool.display.§_-7F§;
   import com.jambool.display.§_-X2§;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.setTimeout;
   import patternpark.net.navigateToWindow;
   
   public final class §_-QG§ implements §_-Q7§
   {
      
      private static const §_-Z9§:String = "https://api.sandbox.jambool.com";
      
      private static const §_-lV§:String = "../test/fixtures/general";
      
      private static const §_-eF§:String = "https://api.staging.jambool.com";
      
      private static const §_-MJ§:String = "test";
      
      private static const §_-SI§:String = "https://flash.staging.jambool.com/socialgold/flash/api";
      
      public static const §_-6U§:String = "new_user_credit";
      
      private static const §_-e5§:String = "http://api.development.jambool.com";
      
      private static const §_-0L§:String = "http://flash.development.jambool.com/socialgold/flash/api";
      
      private static var §_-J2§:int;
      
      private static const §_-I2§:String = "https://flash.sandbox.jambool.com/socialgold/flash/api";
      
      private static const § case§:String = "d";
      
      private static const §_-Vm§:String = "buy_currency_ui";
      
      private static const §_-4§:String = "https://flash-api.jambool.com/socialgold/flash/api";
      
      private static const §_-M5§:String = "https://api.jambool.com";
      
      private static const §_-9X§:String = "staging";
      
      private static const §_-dB§:int = 5000;
      
      public static const §_-fj§:String = "sandbox";
      
      public static const §_-Gc§:String = "production";
      
      private static const §_-gn§:String = "..";
      
      private static const §_-QA§:String = "buy_goods_ui";
      
      public static const §_-R8§:String = "item_sold_credit";
      
      private static const §_-DU§:String = "development";
      
      private static const §_-0O§:Array = [§_-9X§,§_-DU§,§_-MJ§,§_-Gc§,§_-fj§];
       
      
      private var §_-PW§:DisplayObject;
      
      private var §_-Av§:Boolean;
      
      private var §_-KZ§:String;
      
      private var §_-b6§:String;
      
      private var pendingModalRequest:§_-7i§;
      
      private var §_-j9§:Boolean;
      
      private var §_-2f§:String;
      
      private var §_-Wu§:String;
      
      private var §_-h7§:String;
      
      private var §_-2W§:String;
      
      private var §_-26§:int;
      
      private var §_-Re§:DisplayObjectContainer;
      
      private var §_-JL§:Object;
      
      public function §_-QG§()
      {
         super();
         §_-4l§ = §_-Gc§;
         §_-WQ§ = "socialgold";
         version = "v1";
      }
      
      public function credit(param1:int, param2:String, param3:String, param4:String = null, param5:Object = null) : §_-7i§
      {
         param4 = param4 || §_-Ev§();
         §_-le§();
         (param5 = param5 || {}).amount = param1;
         param5.credit_type = param3;
         param5.description = param2;
         param5.external_ref_id = param4;
         var _loc6_:§_-7i§ = §_-Po§(§_-FR§("credit"),"credit",param5);
         return §_-KJ§(_loc6_);
      }
      
      private function §_-Ao§(param1:§_-7i§, param2:§_-7i§, param3:String) : Function
      {
         var request:§_-7i§ = param1;
         var originalRequest:§_-7i§ = param2;
         var externalReferenceId:String = param3;
         return function(param1:§_-eH§):void
         {
            var event:§_-eH§ = param1;
            if(originalRequest.data != null)
            {
               return;
            }
            var status:* = new TransactionStatus();
            status.code = request.data.transaction_status;
            if(!isNaN(request.data.polling_interval))
            {
               originalRequest.pollingIntervalMilliseconds = request.data.polling_interval_seconds * 1000;
            }
            if(!isNaN(request.data.polling_expiration_seconds))
            {
               originalRequest.pollingExpirationMilliseconds = request.data.polling_expiration_seconds * 1000;
            }
            if(status.pending)
            {
               pollForRequestStatus(originalRequest,externalReferenceId);
            }
            else if(status.success)
            {
               setTimeout(function():void
               {
                  originalRequest.data = request.data;
                  originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-N8§));
                  originalRequest.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
                  §_-3g§(originalRequest);
               },§_-dB§);
            }
            else
            {
               originalRequest.data = new §_-XM§("There was a problem with the transaction",§_-XM§.§_-A9§);
               originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
               originalRequest.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
               §_-3g§(originalRequest);
            }
         };
      }
      
      private function §_-Ev§() : String
      {
         return §_-PY§() + "r" + §_-J2§++;
      }
      
      private function §_-5W§(param1:§_-7i§, param2:String, param3:String, param4:Number = NaN) : void
      {
         param4 = !!isNaN(param4) ? Number(§_-XM§.§_-Eu§) : Number(param4);
         param1.data = new §_-XM§(param3,param4);
         param1.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
         param1.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
      }
      
      private function §_-ip§() : String
      {
         switch(§_-4l§)
         {
            case §_-Gc§:
               return §_-M5§;
            case §_-fj§:
               return §_-Z9§;
            case §_-9X§:
               return §_-eF§;
            case §_-DU§:
               return §_-e5§;
            case §_-MJ§:
               return §_-gn§;
            default:
               return null;
         }
      }
      
      private function §_-mo§(param1:§_-7i§, param2:§_-7i§, param3:String) : Function
      {
         var request:§_-7i§ = param1;
         var originalRequest:§_-7i§ = param2;
         var externalReferenceId:String = param3;
         return function(param1:§_-eH§):void
         {
            if(originalRequest.data != null)
            {
               return;
            }
            var _loc2_:* = new TransactionStatus();
            _loc2_.code = request.data.transaction_status;
            if(_loc2_.success)
            {
               originalRequest.data = request.data;
               originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-N8§));
            }
            else
            {
               originalRequest.data = new §_-XM§("There was a problem with the payment of currency process",§_-XM§.§_-Eu§);
               originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
            }
            originalRequest.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
            §_-3g§(originalRequest);
         };
      }
      
      public function get §_-4l§() : String
      {
         return §_-KZ§ = §_-KZ§ || §_-QG§.§_-Gc§;
      }
      
      private function §_-4p§(param1:String) : String
      {
         var _loc2_:String = param1.toLowerCase();
         if(§_-0O§.indexOf(_loc2_) == -1)
         {
            throw new §_-XM§("Unknown environment provided [" + _loc2_ + "]. Should be one of: " + §_-0O§.join(", "));
         }
         return _loc2_;
      }
      
      protected function §_-35§(param1:Object) : Object
      {
         var _loc2_:* = null;
         param1 = param1 || {};
         for(_loc2_ in param1)
         {
            if(param1[_loc2_] == "" || param1[_loc2_] == null)
            {
               delete param1[_loc2_];
            }
         }
         return param1;
      }
      
      private function §_-le§(param1:Object = null) : void
      {
         var _loc2_:* = null;
         if(signingKey == null)
         {
            throw new §_-XM§("SocialGoldService.signingKey must not be null",§_-XM§.§_-JG§);
         }
         if(offerId == null)
         {
            throw new §_-XM§("SocialGoldService.offerId must not be null",§_-XM§.§_-JG§);
         }
         if(userId == null)
         {
            throw new §_-XM§("SocialGoldService.userId must not be null",§_-XM§.§_-JG§);
         }
         if(§_-bJ§ == null)
         {
            throw new §_-XM§("SocialGoldService.modalParent must not be null",§_-XM§.§_-JG§);
         }
         for(_loc2_ in param1)
         {
            if(param1[_loc2_] == null)
            {
               throw new §_-XM§("SocialGoldService " + _loc2_ + " should not be null",§_-XM§.§_-JG§);
            }
         }
      }
      
      private function §_-PY§() : String
      {
         return Math.round(new Date().time / 1000).toString();
      }
      
      public function get signingKey() : String
      {
         return §_-2W§;
      }
      
      private function §_-fo§() : String
      {
         switch(§_-4l§)
         {
            case §_-Gc§:
               return §_-4§;
            case §_-fj§:
               return §_-I2§;
            case §_-9X§:
               return §_-SI§;
            case §_-DU§:
               return §_-0L§;
            case §_-MJ§:
               return §_-lV§;
            default:
               return null;
         }
      }
      
      public function set §_-4l§(param1:String) : void
      {
         §_-KZ§ = §_-4p§(param1);
      }
      
      public function set offerId(param1:String) : void
      {
         §_-b6§ = param1;
      }
      
      public function set signingKey(param1:String) : void
      {
         §_-2W§ = param1;
      }
      
      private function get winFeatures() : Object
      {
         return {
            "scrolling":0,
            "frameborder":0,
            "menubar":0,
            "toolbar":0,
            "width":485,
            "height":365
         };
      }
      
      private function §_-om§(param1:Object, param2:String) : §_-7i§
      {
         var loadCompletedDispatched:Boolean = false;
         var uiLoadCompletedHandler:Function = null;
         var originalRequest:§_-7i§ = null;
         var completeHandler:Function = null;
         var options:Object = param1;
         var externalReferenceId:String = param2;
         if(pendingModalRequest)
         {
            return new §_-cL§();
         }
         uiLoadCompletedHandler = function(param1:§_-eH§):void
         {
            loadCompletedDispatched = true;
         };
         originalRequest = new §_-7i§();
         setTimeout(function():void
         {
            originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-4B§));
            originalRequest.addEventListener(§_-eH§.§_-9L§,uiLoadCompletedHandler);
         },0);
         var startTransactionRequest:§_-7i§ = §_-nC§(originalRequest,externalReferenceId);
         startTransactionRequest.addEventListener(§_-eH§.§_-N8§,function(param1:Event):void
         {
            showModalWindow(originalRequest,externalReferenceId,§_-QG§.§_-Vm§,options);
         });
         completeHandler = function(param1:Event):void
         {
            pendingModalRequest = null;
            if(!loadCompletedDispatched)
            {
               originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-9L§));
            }
            originalRequest.removeEventListener(§_-eH§.COMPLETE,completeHandler);
         };
         pendingModalRequest = originalRequest;
         originalRequest.addEventListener(§_-eH§.COMPLETE,completeHandler);
         return originalRequest;
      }
      
      public function get userId() : String
      {
         return §_-2f§;
      }
      
      public function get §_-WQ§() : String
      {
         return §_-Wu§;
      }
      
      public function get §_-RZ§() : Boolean
      {
         return §_-j9§;
      }
      
      public function get §_-Du§() : String
      {
         return §_-fo§();
      }
      
      public function get §_-Oc§() : DisplayObject
      {
         return §_-PW§;
      }
      
      public function §_-ao§(param1:String, param2:int, param3:int, param4:Object = null, param5:Object = null) : §_-7i§
      {
         var _loc6_:* = null;
         var _loc7_:§_-7i§ = null;
         §_-le§();
         param4 = param4 || {};
         param5 = param5 || {};
         param5.external_ref_id = param5.external_ref_id || §null §.§_-ho§();
         for(_loc6_ in param5)
         {
            param4[_loc6_] = param5[_loc6_];
         }
         param4.name = param1;
         param4.amount = param2;
         param4.quantity = param3;
         param4.external_ref_id = param5.external_ref_id;
         _loc7_ = §_-Po§(§_-FR§("buy_goods"),"buy_goods",param4,"iframe");
         §_-Fy§(_loc7_.urlRequest.url,winFeatures);
         §_-nC§(_loc7_,param5.external_ref_id);
         showPopUpModalWindow(_loc7_,param5.external_ref_id);
         return _loc7_;
      }
      
      public function set §_-bJ§(param1:DisplayObjectContainer) : void
      {
         §_-Re§ = param1;
      }
      
      private function §_-nC§(param1:§_-7i§, param2:String) : §_-7i§
      {
         var originalRequest:§_-7i§ = param1;
         var externalReferenceId:String = param2;
         var request:§_-7i§ = §_-Po§(§_-FR§("start_transaction"),"start_transaction",{"external_ref_id":externalReferenceId});
         request.addEventListener(§_-eH§.§_-Kt§,function(param1:§_-eH§):void
         {
            originalRequest.data = new §_-XM§("There was a problem with starting the currency process",§_-XM§.§_-A9§);
            originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
            originalRequest.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
         });
         request.addEventListener(§_-eH§.§_-N8§,function(param1:§_-eH§):void
         {
            pollForRequestStatus(originalRequest,externalReferenceId);
         });
         §_-KJ§(request);
         return request;
      }
      
      public function refund(param1:String, param2:String, param3:String = null, param4:Object = null) : §_-7i§
      {
         param3 = param3 || §_-Ev§();
         §_-le§({
            "socialGoldTransactionId":param1,
            "description":param2
         });
         (param4 = param4 || {}).description = param2;
         param4.external_ref_id = param3;
         param4.socialgold_transaction_id = param1;
         var _loc5_:§_-7i§ = §_-Po§(§_-FR§("refund"),"refund",param4);
         return §_-KJ§(_loc5_);
      }
      
      private function §_-2r§(param1:String) : void
      {
         if(§_-RZ§)
         {
            navigateToWindow(param1,{
               "width":800,
               "height":640
            },"social_gold_error_messages");
         }
      }
      
      private function §_-fb§(param1:Date) : String
      {
         return Math.round(param1.time / 1000).toString();
      }
      
      private function §_-KJ§(param1:§_-7i§) : §_-7i§
      {
         var loader:URLLoader = null;
         var request:§_-7i§ = param1;
         loader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var event:Event = param1;
            try
            {
               request.rawData = loader.data;
               request.data = §_-3V§.§_-Vf§(loader.data);
               request.dispatchEvent(new §_-eH§(§_-eH§.§_-N8§));
            }
            catch(e:Error)
            {
               request.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
               request.rawData = loader.data;
               request.data = new §_-XM§("JSON Parse Error with: " + e.toString(),§_-XM§.§_-Sq§);
            }
            request.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            request.rawData = loader.data;
            request.data = new §_-XM§("IO ERROR: " + param1.text,§_-XM§.§_-A9§);
            request.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
            request.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
            §_-2r§(request.url);
         });
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:SecurityErrorEvent):void
         {
            request.rawData = loader.data;
            request.data = new §_-XM§("SECURITY ERROR: " + param1.text,§_-XM§.§_-A9§);
            request.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
            request.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
         });
         loader.load(request.urlRequest);
         return request;
      }
      
      private function §_-3g§(param1:§_-7i§) : void
      {
         if(§_-JL§ && §_-JL§.parent === §_-bJ§)
         {
            if(!(§_-JL§ is §_-7F§) || §_-JL§ is §_-7F§ && §_-JL§.pendingRequest === param1)
            {
               §_-bJ§.removeChild(DisplayObject(§_-JL§));
               §_-JL§ = null;
            }
         }
      }
      
      protected function §_-Fy§(param1:String, param2:Object) : void
      {
         navigateToWindow(param1,param2);
      }
      
      public function set §_-Ii§(param1:Boolean) : void
      {
         §_-Av§ = param1;
      }
      
      public function set userId(param1:String) : void
      {
         §_-2f§ = param1;
      }
      
      public function get offerId() : String
      {
         return §_-b6§;
      }
      
      public function §_-8B§(param1:int = 0, param2:Object = null) : §_-7i§
      {
         §_-le§();
         return §_-KJ§(§_-Po§(§_-FR§("get_balance"),"get_balance",param2));
      }
      
      public function set §_-WQ§(param1:String) : void
      {
         §_-Wu§ = param1;
      }
      
      public function get host() : String
      {
         return §_-ip§();
      }
      
      private function showPopUpModalWindow(param1:§_-7i§, param2:String) : void
      {
         var modalWindowCloseHandler:Function = null;
         var originalRequest:§_-7i§ = param1;
         var externalReferenceId:String = param2;
         if(§_-Oc§)
         {
            §_-JL§ = §_-Oc§;
         }
         else
         {
            §_-JL§ = new §_-X2§();
         }
         modalWindowCloseHandler = function(param1:Event):void
         {
            §_-bJ§.removeEventListener(Event.CLOSE,modalWindowCloseHandler);
            §_-9M§(originalRequest,externalReferenceId);
         };
         §_-JL§.addEventListener(Event.CLOSE,modalWindowCloseHandler);
         §_-bJ§.addChild(DisplayObject(§_-JL§));
      }
      
      public function set §_-RZ§(param1:Boolean) : void
      {
         §_-j9§ = param1;
      }
      
      private function §_-lN§(param1:Object, param2:String) : §_-7i§
      {
         var request:§_-7i§ = null;
         var options:Object = param1;
         var externalReferenceId:String = param2;
         request = §_-Po§(§_-FR§("buy_currency"),"buy_currency",options,"iframe");
         var startTransactionRequest:§_-7i§ = §_-nC§(request,externalReferenceId);
         startTransactionRequest.addEventListener(§_-eH§.§_-N8§,function(param1:Event):void
         {
            §_-Fy§(request.urlRequest.url,winFeatures);
            showPopUpModalWindow(request,externalReferenceId);
         });
         return request;
      }
      
      public function get §_-bJ§() : DisplayObjectContainer
      {
         return §_-Re§;
      }
      
      public function §_-jh§(param1:String) : §_-7i§
      {
         var _loc2_:§_-7i§ = §_-Po§(§_-FR§("get_transaction_status"),"get_transaction_status",{"external_ref_id":param1});
         return §_-KJ§(_loc2_);
      }
      
      public function set version(param1:String) : void
      {
         §_-h7§ = param1;
      }
      
      private function §_-gF§(param1:§_-7i§, param2:§_-7i§) : Function
      {
         var request:§_-7i§ = param1;
         var originalRequest:§_-7i§ = param2;
         return function(param1:§_-eH§):void
         {
            if(originalRequest.data != null)
            {
               return;
            }
            originalRequest.data = new §_-XM§("There was a problem continuing with the currency process",§_-XM§.§_-A9§);
            originalRequest.dispatchEvent(new §_-eH§(§_-eH§.§_-Kt§));
            originalRequest.dispatchEvent(new §_-eH§(§_-eH§.COMPLETE));
            §_-3g§(originalRequest);
         };
      }
      
      public function get §_-Ii§() : Boolean
      {
         return §_-Av§;
      }
      
      private function §_-bZ§(param1:String, param2:String, param3:String, param4:Object = null) : String
      {
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:Array;
         (_loc5_ = []).push({
            "key":"action",
            "value":param3
         });
         _loc5_.push({
            "key":"offer_id",
            "value":param1
         });
         _loc5_.push({
            "key":"user_id",
            "value":param2
         });
         for(_loc6_ in param4)
         {
            if(param4[_loc6_] != null)
            {
               _loc5_.push({
                  "key":_loc6_,
                  "value":param4[_loc6_]
               });
            }
         }
         _loc5_.sortOn("key");
         _loc7_ = "";
         _loc8_ = _loc5_.length;
         while(_loc9_ < _loc8_)
         {
            _loc7_ += _loc5_[_loc9_].key + _loc5_[_loc9_].value;
            _loc9_++;
         }
         _loc7_ += signingKey;
         return §_-WS§.§_-IG§(_loc7_);
      }
      
      private function §_-9M§(param1:§_-7i§, param2:String) : void
      {
         var _loc3_:§_-7i§ = §_-Po§(§_-FR§("get_transaction_status"),"get_transaction_status",{"external_ref_id":param2});
         _loc3_.addEventListener(§_-eH§.§_-Kt§,§_-gF§(_loc3_,param1));
         _loc3_.addEventListener(§_-eH§.§_-N8§,§_-mo§(_loc3_,param1,param2));
         §_-KJ§(_loc3_);
      }
      
      private function showModalWindow(param1:§_-7i§, param2:String, param3:String, param4:Object) : void
      {
         var modalWindowAbandonHandler:Function = null;
         var modalWindowCloseHandler:Function = null;
         var modalWindowFailureHandler:Function = null;
         var originalRequest:§_-7i§ = param1;
         var externalReferenceId:String = param2;
         var action:String = param3;
         var options:Object = param4;
         options = options || {};
         if(§_-JL§)
         {
            §_-JL§.pendingRequest.abandon();
            setTimeout(function():void
            {
               showModalWindow(originalRequest,externalReferenceId,action,options);
            },1000);
            return;
         }
         var modalWindowRequest:§_-7i§ = §_-Po§(§_-MS§(action),action,options,"swf");
         §_-JL§ = new §_-7F§(modalWindowRequest.urlRequest,originalRequest,§_-bJ§);
         modalWindowAbandonHandler = function(param1:Event):void
         {
            originalRequest.removeEventListener(§_-eH§.§_-JV§,modalWindowAbandonHandler);
            §_-5W§(originalRequest,externalReferenceId,"The payment process was abandoned by the user.");
            §_-3g§(originalRequest);
         };
         modalWindowFailureHandler = function(param1:Event):void
         {
            §_-JL§.removeEventListener(§_-eH§.§_-Kt§,modalWindowFailureHandler);
            §_-2r§(§_-JL§.windowRequest.url);
            §_-5W§(originalRequest,externalReferenceId,"There was a problem loading the payment interface.",§_-XM§.§_-A9§);
            §_-3g§(originalRequest);
         };
         modalWindowCloseHandler = function(param1:Event):void
         {
            §_-bJ§.removeEventListener(Event.CLOSE,modalWindowCloseHandler);
            §_-9M§(originalRequest,externalReferenceId);
         };
         originalRequest.addEventListener(§_-eH§.§_-JV§,modalWindowAbandonHandler);
         §_-bJ§.addEventListener(Event.CLOSE,modalWindowCloseHandler);
         §_-JL§.addEventListener(§_-eH§.§_-Kt§,modalWindowFailureHandler);
         §_-bJ§.addChild(DisplayObject(§_-JL§));
      }
      
      public function §_-EB§(param1:Date, param2:Date = null, param3:int = 1000, param4:String = null, param5:Object = null) : §_-7i§
      {
         §_-le§({"startTime":param1});
         (param5 = param5 || {}).start_ts = §_-fb§(param1);
         if(param2)
         {
            param5.end_ts = §_-fb§(param2);
         }
         if(param3 != 1000)
         {
            param5.limit = param3;
         }
         return §_-KJ§(§_-Po§(§_-FR§("get_transactions"),"get_transactions",param5));
      }
      
      private function §_-MS§(param1:String) : String
      {
         return [§_-Du§,offerId,userId,param1].join("/");
      }
      
      public function §_-DB§(param1:Object = null) : §_-7i§
      {
         §_-le§();
         param1 = param1 || {};
         param1.external_ref_id = param1.external_ref_id || §null §.§_-ho§();
         if(§_-Ii§)
         {
            param1.buy_currency_pop_up_url = §_-Po§(§_-FR§("buy_currency"),"buy_currency",param1,"iframe").urlRequest.url;
            return §_-om§(param1,param1.external_ref_id);
         }
         return §_-lN§(param1,param1.external_ref_id);
      }
      
      private function §_-FR§(param1:String) : String
      {
         return [host,§_-WQ§,version,offerId,userId,param1].join("/");
      }
      
      public function get version() : String
      {
         return §_-h7§;
      }
      
      public function set §_-Oc§(param1:DisplayObject) : void
      {
         §_-PW§ = param1;
      }
      
      public function debit(param1:int, param2:String, param3:String = null, param4:Object = null) : §_-7i§
      {
         param3 = param3 || §_-Ev§();
         §_-le§({
            "amount":param1,
            "description":param2
         });
         (param4 = param4 || {}).amount = param1;
         param4.description = param2;
         param4.external_ref_id = param3;
         var _loc5_:§_-7i§ = §_-Po§(§_-FR§("debit"),"debit",param4);
         return §_-KJ§(_loc5_);
      }
      
      private function §_-Po§(param1:String, param2:String, param3:Object = null, param4:String = "json") : §_-7i§
      {
         var _loc6_:* = null;
         param3 = §_-35§(param3);
         param3.ts = §_-PY§();
         var _loc5_:URLVariables = new URLVariables();
         for(_loc6_ in param3)
         {
            _loc5_[_loc6_] = param3[_loc6_];
         }
         _loc5_.sig = §_-bZ§(offerId,userId,param2,_loc5_);
         _loc5_.format = param4;
         _loc5_.client_swc_version = § case§;
         param1 += "?" + _loc5_.toString().split("%5F").join("_");
         if(§_-RZ§)
         {
            trace(">> createRequest for: " + param1);
         }
         var _loc7_:URLRequest = new URLRequest(param1);
         var _loc8_:§_-7i§;
         (_loc8_ = new §_-7i§()).urlRequest = _loc7_;
         return _loc8_;
      }
      
      private function pollForRequestStatus(param1:§_-7i§, param2:String) : void
      {
         var originalRequest:§_-7i§ = param1;
         var externalReferenceId:String = param2;
         setTimeout(function():void
         {
            if(originalRequest.abandoned)
            {
               return;
            }
            var _loc1_:§_-7i§ = §_-jh§(externalReferenceId);
            _loc1_.addEventListener(§_-eH§.§_-Kt§,§_-gF§(_loc1_,originalRequest));
            _loc1_.addEventListener(§_-eH§.§_-N8§,§_-Ao§(_loc1_,originalRequest,externalReferenceId));
         },originalRequest.pollingIntervalMilliseconds);
      }
   }
}

class TransactionStatus
{
   
   public static const RESERVED:int = 0;
   
   public static const TXN_START:int = 1;
   
   public static const TXN_SUCCESS:int = 4;
   
   public static const TXN_FRAUD:int = 666;
   
   public static const UNKNOWN:int = -1;
   
   public static const TXN_FAILURE:int = 2;
   
   public static const TXN_INITIATED:int = 3;
   
   public static const TXN_ABANDONED:int = 5;
    
   
   public var code:int = -1;
   
   function TransactionStatus()
   {
      super();
   }
   
   public function get success() : Boolean
   {
      return code == TXN_SUCCESS;
   }
   
   public function get pending() : Boolean
   {
      return code == UNKNOWN || code == RESERVED || code == TXN_START || code == TXN_INITIATED;
   }
   
   public function get failure() : Boolean
   {
      return code == TXN_FAILURE || code == TXN_ABANDONED || code == TXN_FRAUD;
   }
}
