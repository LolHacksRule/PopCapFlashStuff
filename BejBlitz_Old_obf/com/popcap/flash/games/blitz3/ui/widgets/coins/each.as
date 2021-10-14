package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import §_-4M§.§_-Ze§;
   import §_-G2§.§_-eH§;
   import §_-u§.§_-CS§;
   import com.jambool.net.§_-7i§;
   import com.jambool.net.§_-Q7§;
   import com.jambool.net.§_-QG§;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.§_-lK§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class each extends Sprite implements IBlitz3NetworkHandler
   {
      
      public static const §_-lw§:int = 250;
      
      public static const §_-Iq§:int = 1;
      
      public static const §_-K2§:int = 0;
      
      public static const §_-i0§:int = 2;
       
      
      private var §_-dU§:§_-98§;
      
      public var screenID:int = 0;
      
      private var §_-BI§:Bitmap;
      
      private var §_-f4§:Boolean = false;
      
      private var §_-Kq§:Boolean = true;
      
      private var §_-Ti§:Sprite;
      
      private var §_-Lp§:Blitz3Game;
      
      private var §continue§:int = 0;
      
      private var §_-f9§:int = 0;
      
      private var §_-kn§:int = 0;
      
      private var §_-3Q§:Sprite;
      
      private var §_-Uc§:int = 0;
      
      private var §_-oK§:Function;
      
      private var §_-9t§:§_-CS§;
      
      private var §_-kw§:Boolean = false;
      
      public function each(param1:Blitz3Game)
      {
         super();
         this.§_-Lp§ = param1;
         if(stage)
         {
            this.Init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.§_-Ma§);
         }
      }
      
      private function §_-Oo§(param1:§_-eH§) : void
      {
         if(this.§_-Lp§.network)
         {
            this.§_-Lp§.network.buy_coins_callback(false);
         }
      }
      
      private function §_-pc§(param1:Event) : void
      {
         this.§_-9t§.Update();
         this.§_-gf§();
      }
      
      public function §_-Kw§(param1:int) : void
      {
         var _loc2_:String = null;
         if(!this.§_-Kq§)
         {
            return;
         }
         if(param1 < 0)
         {
            _loc2_ = this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIPS_MORE_COINS");
            _loc2_ = _loc2_.replace("%s",§_-Ze§.§_-2P§(Math.abs(param1)));
            this.§_-dU§.§_-bA§(_loc2_);
         }
         else
         {
            this.§_-dU§.§_-bA§("");
         }
         this.§_-jI§();
      }
      
      private function §_-jP§(param1:Event) : void
      {
         if(this.§_-Uc§ != §_-K2§)
         {
            return;
         }
         this.§_-Lp§.network.RestoreBoosts();
         this.§_-kX§();
      }
      
      private function §_-Ma§(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.§_-Ma§);
         this.Init();
      }
      
      public function Show(param1:int = 0, param2:Function = null, param3:Boolean = false) : void
      {
         this.§_-Kw§(this.§_-Lp§.§_-3A§);
         this.§_-Kq§ = false;
         this.§_-f4§ = true;
         this.§_-kn§ = Number.MIN_VALUE;
         this.§_-f9§ = 1;
         this.§_-Ti§.alpha = 0;
         this.§_-Ti§.visible = true;
         this.§_-BI§.scaleX = 0;
         this.§_-BI§.scaleY = 0;
         this.§_-BI§.visible = true;
         this.§_-dU§.§_-GB§.§_-lB§();
         this.§_-Lp§.§_-Ba§.menu.HideBoostBar();
         visible = true;
         this.§continue§ = getTimer();
         this.§_-oK§ = param2;
      }
      
      public function §_-ey§(param1:Dictionary) : void
      {
      }
      
      private function Init() : void
      {
         this.§_-kw§ = this.§_-Lp§.§_-FC§.IsEnabled(§_-lK§.§_-9y§);
         if(this.§_-kw§)
         {
            this.§_-3Q§ = new Sprite();
         }
         this.§_-Lp§.network.AddHandler(this);
         this.§_-Ti§ = new Sprite();
         this.§_-Ti§.graphics.beginFill(0,0.5);
         this.§_-Ti§.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         this.§_-Ti§.graphics.endFill();
         this.§_-dU§ = new §_-98§(this.§_-Lp§,this.§_-kw§);
         this.§_-dU§.x = stage.stageWidth / 2;
         this.§_-dU§.y = stage.stageHeight / 2;
         this.§_-dU§.closeButton.addEventListener(MouseEvent.CLICK,this.§_-jP§);
         this.§_-dU§.§_-P3§.addEventListener(MouseEvent.CLICK,this.§_-ks§);
         addChild(this.§_-Ti§);
         addChild(this.§_-dU§);
         this.§_-dU§.visible = false;
         this.§_-dU§.§_-GB§.§_-nu§();
         this.§_-9t§ = new §_-CS§(this.§_-Lp§);
         this.§_-BI§ = new Bitmap();
         this.§_-jI§();
         this.§_-BI§.visible = false;
         this.§_-BI§.x = stage.stageWidth / 2 - this.§_-BI§.width / 2;
         this.§_-BI§.y = stage.stageHeight / 2 - this.§_-BI§.height / 2;
         addChild(this.§_-BI§);
         addEventListener(Event.ENTER_FRAME,this.§_-pc§);
         visible = false;
      }
      
      public function §_-Ae§(param1:int) : void
      {
      }
      
      private function §_-Vz§(param1:§_-eH§) : void
      {
         this.§_-3Q§.x = 47.5;
         this.§_-3Q§.y = 16;
      }
      
      private function §_-gf§() : void
      {
         if(!this.§_-f4§)
         {
            return;
         }
         var _loc1_:int = getTimer();
         var _loc2_:int = _loc1_ - this.§continue§;
         var _loc3_:int = _loc2_ * this.§_-f9§;
         this.§_-kn§ += _loc3_;
         var _loc4_:Number = Math.max(0,Math.min(1,this.§_-kn§ / §_-lw§));
         this.§_-Ti§.alpha = _loc4_;
         this.§continue§ = _loc1_;
         this.§_-BI§.scaleX = _loc4_;
         this.§_-BI§.scaleY = _loc4_;
         this.§_-dU§.scaleX = _loc4_;
         this.§_-dU§.scaleY = _loc4_;
         this.§_-BI§.x = stage.stageWidth / 2 - this.§_-BI§.width / 2;
         this.§_-BI§.y = stage.stageHeight / 2 - this.§_-BI§.height / 2;
         this.§_-Lp§.§_-Ba§.menu.playButton.alpha = 1 - _loc4_;
         this.§_-Lp§.§_-Ba§.menu.boostView.alpha = 1 - _loc4_;
         this.§_-Lp§.§_-Ba§.game.board.alpha = 1 - _loc4_;
         this.§_-Lp§.§_-Ba§.game.sidebar.alpha = 1 - _loc4_;
         this.§_-Lp§.§_-Ba§.stats.alpha = 1 - _loc4_;
         if(_loc4_ == 0 && this.§_-f9§ == -1)
         {
            this.§_-f4§ = false;
            this.§_-Kq§ = true;
            visible = false;
         }
         if(_loc4_ == 1 && this.§_-f9§ == 1)
         {
            this.§_-f4§ = false;
            this.§_-BI§.visible = false;
            this.§_-dU§.visible = true;
         }
      }
      
      public function §_-2i§() : void
      {
      }
      
      private function §_-oU§() : void
      {
         var offerId:String = null;
         var signingKey:String = null;
         var userId:String = null;
         var isProduction:Boolean = false;
         var blacklist:String = null;
         var params:Object = null;
         var service:§_-Q7§ = null;
         var sgRequest:§_-7i§ = null;
         if(!this.§_-kw§)
         {
            return;
         }
         try
         {
            offerId = "";
            signingKey = "";
            userId = "";
            isProduction = false;
            blacklist = "zong, kwedit, my_card, gash, cherry_credit";
            if(stage.loaderInfo && stage.loaderInfo.parameters)
            {
               params = stage.loaderInfo.parameters;
               if("sgSignature" in params)
               {
                  signingKey = params.sgSignature;
               }
               if("offer_id" in params)
               {
                  offerId = params.offer_id;
               }
               if("sgBlacklist" in params)
               {
                  blacklist = params.sgBlacklist;
               }
               if("fb_user" in params)
               {
                  userId = params.fb_user;
               }
               if("production" in params)
               {
                  isProduction = params.production == "1";
               }
               else
               {
                  isProduction = false;
               }
               if(!signingKey || signingKey.length == 0)
               {
                  return;
               }
               this.§_-Uc§ = §_-Iq§;
               service = new §_-QG§();
               service.offerId = offerId;
               service.signingKey = signingKey;
               service.userId = userId;
               service.§_-bJ§ = this.§_-3Q§;
               service.§_-Ii§ = true;
               service.§_-4l§ = !!isProduction ? "production" : "sandbox";
               service.§_-RZ§ = service.§_-4l§ != "production";
               sgRequest = service.§_-DB§({"exclude_payment_methods":blacklist});
               sgRequest.addEventListener(§_-eH§.COMPLETE,this.§else §);
               sgRequest.addEventListener(§_-eH§.§_-JV§,this.§_-Oo§);
               sgRequest.addEventListener(§_-eH§.§_-Kt§,this.§_-9s§);
               sgRequest.addEventListener(§_-eH§.§_-N8§,this.§_-0P§);
               sgRequest.addEventListener(§_-eH§.§_-9L§,this.§_-ll§);
               sgRequest.addEventListener(§_-eH§.§_-4B§,this.§_-Vz§);
               this.§_-9t§.x = -this.§_-dU§.x;
               this.§_-9t§.y = -this.§_-dU§.y;
               this.§_-dU§.addChild(this.§_-9t§);
               this.§_-9t§.visible = true;
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public function §_-M-§(param1:Boolean) : void
      {
      }
      
      public function §use§(param1:Dictionary) : void
      {
      }
      
      public function get §_-Sd§() : Boolean
      {
         return this.§_-kw§;
      }
      
      public function §_-kX§() : void
      {
         this.§_-f4§ = true;
         this.§_-kn§ = §_-lw§ - Number.MIN_VALUE;
         this.§_-f9§ = -1;
         this.§_-Ti§.alpha = 1;
         this.§_-dU§.visible = false;
         this.§_-BI§.scaleX = 1;
         this.§_-BI§.scaleY = 1;
         this.§_-BI§.visible = true;
         this.§continue§ = getTimer();
         this.§_-Lp§.§_-Ba§.menu.ShowBoostBar();
         if(this.§_-oK§ != null)
         {
            this.§_-oK§();
            this.§_-oK§ = null;
         }
      }
      
      private function §_-ll§(param1:§_-eH§) : void
      {
         this.§_-9t§.§_-YG§();
         addChild(this.§_-3Q§);
         this.§_-Uc§ = §_-i0§;
      }
      
      private function §else §(param1:§_-eH§) : void
      {
         this.§_-Uc§ = §_-K2§;
         this.§_-9t§.Reset();
         this.§_-dU§.removeChild(this.§_-9t§);
      }
      
      private function §_-jI§() : void
      {
         if(this.§_-BI§.bitmapData == null)
         {
            this.§_-BI§.bitmapData = new BitmapData(stage.stageWidth,stage.stageHeight,true,0);
         }
         else
         {
            this.§_-BI§.bitmapData.fillRect(new Rectangle(0,0,stage.stageWidth,stage.stageHeight),0);
         }
         var _loc1_:Matrix = new Matrix();
         _loc1_.translate(stage.stageWidth / 2,stage.stageHeight / 2);
         this.§_-BI§.bitmapData.draw(this.§_-dU§,_loc1_,null,BlendMode.NORMAL,null,true);
      }
      
      private function §_-ks§(param1:Event) : void
      {
         var _loc2_:OfferRadioButton = this.§_-dU§.§_-GB§.§_-m7§();
         var _loc3_:int = _loc2_.§_-MU§;
         if(_loc3_ == -1)
         {
            this.§_-oU§();
         }
         else
         {
            this.§_-Lp§.network.AddCoinsWithCredits(_loc3_,this.screenID,this.§_-kX§);
         }
      }
      
      public function §_-fX§() : void
      {
      }
      
      private function §_-9s§(param1:§_-eH§) : void
      {
         if(this.§_-Lp§.network)
         {
            this.§_-Lp§.network.buy_coins_callback(false);
         }
      }
      
      private function §_-0P§(param1:§_-eH§) : void
      {
         if(this.§_-Lp§.network)
         {
            this.§_-Lp§.network.buy_coins_callback(true);
         }
         if(this.§_-Uc§ != §_-K2§)
         {
            this.§_-kX§();
         }
      }
   }
}
