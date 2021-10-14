package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class §_-98§ extends Sprite
   {
       
      
      public var buttons:Vector.<OfferRadioButton>;
      
      public var closeButton:MovieClip;
      
      public var §_-co§:DisplayObject;
      
      public var §_-p3§:MovieClip;
      
      public var §_-P3§:MovieClip;
      
      public var §_-CC§:DisplayObject;
      
      public var §_-Bg§:DisplayObject;
      
      public var §_-GB§:§_-jY§;
      
      public var background:Sprite;
      
      private var §_-Lp§:§_-0Z§;
      
      public var §_-GY§:Sprite;
      
      private var §_-hw§:§_-aR§;
      
      private var §_-4J§:§_-aR§;
      
      public function §_-98§(param1:Blitz3Game, param2:Boolean = false)
      {
         super();
         this.§_-Lp§ = param1;
         this.buttons = new Vector.<OfferRadioButton>();
         this.§_-GB§ = new §_-jY§();
         this.background.cacheAsBitmap = true;
         this.§_-p3§.cacheAsBitmap = true;
         this.§_-p3§.txtDeficit.cacheAsBitmap = true;
         this.§_-co§.cacheAsBitmap = true;
         this.§_-CC§.cacheAsBitmap = true;
         this.§_-Bg§.cacheAsBitmap = true;
         this.§_-co§.visible = false;
         this.§_-CC§.visible = false;
         this.§_-Bg§.visible = false;
         this.§_-hw§ = new §_-aR§(param1,this.closeButton);
         this.§_-4J§ = new §_-aR§(param1,this.§_-P3§);
         var _loc3_:XML = new XML(param1.network.parameters.creditSkus);
         var _loc4_:XML = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_.offer.length())
         {
            _loc4_ = _loc3_.offer[_loc6_];
            if(int(_loc4_.@discountPrice) > 0)
            {
               _loc5_++;
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.offer.length())
         {
            _loc4_ = _loc3_.offer[_loc6_];
            this.§else§(Number(_loc4_.@sku),Number(_loc4_.@amount),Number(_loc4_.@price),Number(_loc4_.@discountPrice),_loc5_);
            _loc6_++;
         }
         if(param2)
         {
            this.§else§(-1,0,0,0,0);
            this.§_-co§.visible = true;
            this.§_-CC§.visible = true;
            this.§_-Bg§.visible = true;
         }
         this.§_-p3§.gotoAndStop(1);
         this.§_-Nu§();
      }
      
      private function §_-Nu§() : void
      {
         var _loc5_:OfferRadioButton = null;
         var _loc1_:int = this.buttons.length;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            if((_loc5_ = this.buttons[_loc4_]).§_-MU§ == -1)
            {
               _loc3_ += 38;
            }
            _loc5_.y = _loc3_;
            if(_loc5_.§_-IR§.visible)
            {
               _loc3_ += _loc5_.§_-IR§.height;
            }
            else
            {
               _loc3_ += _loc5_.§super§.height;
            }
            _loc2_ = Math.max(_loc2_,_loc5_.§super§.width);
            _loc4_++;
         }
         this.§_-GY§.x = -(_loc2_ / 2);
      }
      
      public function §else§(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:OfferRadioButton = new OfferRadioButton(this.§_-Lp§,param1,param2,param3,param4,param5 == 1);
         this.buttons.push(_loc6_);
         this.§_-GB§.§else§(_loc6_);
         this.§_-GY§.addChild(_loc6_);
      }
      
      public function §_-bA§(param1:String) : void
      {
         this.§_-p3§.txtDeficit.text = param1;
         if(param1 == "")
         {
            this.§_-p3§.gotoAndStop(1);
            this.§_-p3§.txtDeficit.visible = false;
         }
         else
         {
            this.§_-p3§.gotoAndStop(2);
            this.§_-p3§.txtDeficit.visible = true;
         }
      }
   }
}
