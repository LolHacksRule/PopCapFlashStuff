package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class OfferRadioButton extends Sprite
   {
       
      
      public var skuID:int = -1;
      
      public var cost:int = 0;
      
      public var amount:int = 0;
      
      public var upState:Sprite;
      
      public var overState:Sprite;
      
      public var downState:Sprite;
      
      public var hitBox:Sprite;
      
      public var coinsLabel:TextField;
      
      public var textLabel:TextField;
      
      public var creditsLabel:TextField;
      
      public var creditIcon:Sprite;
      
      public var salePriceLabel:TextField;
      
      public var saleSlash:Sprite;
      
      public var saleFrame:Sprite;
      
      private var isArmed:Boolean = false;
      
      private var isSelected:Boolean = false;
      
      public function OfferRadioButton(app:Blitz3App, sku:int, amount:int, price:int, discount:int = 0, isExclusive:Boolean = false)
      {
         super();
         this.skuID = sku;
         this.amount = amount;
         mouseChildren = false;
         hitArea = this.hitBox;
         this.hitBox.visible = false;
         buttonMode = true;
         useHandCursor = true;
         cacheAsBitmap = true;
         addEventListener(MouseEvent.MOUSE_DOWN,this.HandlePress);
         addEventListener(MouseEvent.MOUSE_UP,this.HandleRelease);
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
         this.overState.visible = false;
         this.upState.visible = true;
         this.downState.visible = false;
         this.coinsLabel.x += 4;
         this.coinsLabel.width = 0;
         this.coinsLabel.multiline = false;
         this.coinsLabel.wordWrap = false;
         this.coinsLabel.autoSize = TextFieldAutoSize.LEFT;
         this.coinsLabel.htmlText = StringUtils.InsertNumberCommas(amount);
         this.textLabel.width = 0;
         this.textLabel.multiline = false;
         this.textLabel.wordWrap = false;
         this.textLabel.autoSize = TextFieldAutoSize.LEFT;
         this.textLabel.htmlText = app.locManager.GetLocString("UI_BUTTON_OFFER_RADIO");
         this.textLabel.x = this.coinsLabel.x + this.coinsLabel.width;
         this.creditsLabel.width = 0;
         this.creditsLabel.multiline = false;
         this.creditsLabel.wordWrap = false;
         this.creditsLabel.autoSize = TextFieldAutoSize.LEFT;
         this.creditsLabel.htmlText = StringUtils.InsertNumberCommas(price);
         this.creditsLabel.x = this.textLabel.x + this.textLabel.width;
         this.cost = price;
         this.saleSlash.x = this.creditsLabel.x;
         this.saleSlash.width = this.creditsLabel.width;
         this.saleSlash.visible = discount > 0;
         this.saleFrame.visible = discount > 0;
         if(discount > 0)
         {
            this.salePriceLabel.width = 0;
            this.salePriceLabel.multiline = false;
            this.salePriceLabel.wordWrap = false;
            this.salePriceLabel.autoSize = TextFieldAutoSize.LEFT;
            this.salePriceLabel.htmlText = StringUtils.InsertNumberCommas(discount);
            this.salePriceLabel.x = this.creditsLabel.x + this.creditsLabel.width + 4;
            this.creditIcon.x = this.salePriceLabel.x + this.salePriceLabel.width + 4;
            this.cost = discount;
         }
         else
         {
            this.salePriceLabel.visible = false;
            this.creditIcon.x = this.creditsLabel.x + this.creditsLabel.width + 4;
         }
         this.hitBox.width = this.creditIcon.x + this.creditIcon.width;
         this.saleFrame.x = hitArea.width / 2 - this.saleFrame.width / 2;
         if(this.skuID == -1)
         {
            this.coinsLabel.visible = false;
            this.textLabel.visible = false;
            this.creditsLabel.visible = false;
            this.creditIcon.visible = false;
            this.salePriceLabel.visible = false;
            this.saleSlash.visible = false;
            this.saleFrame.visible = false;
         }
      }
      
      public function Arm() : void
      {
         if(this.isSelected)
         {
            return;
         }
         this.isArmed = true;
         this.overState.visible = false;
         this.upState.visible = false;
         this.downState.visible = true;
      }
      
      public function Disarm() : void
      {
         this.isArmed = false;
      }
      
      public function Select() : void
      {
         dispatchEvent(new Event("Selected"));
         this.isArmed = false;
         this.isSelected = true;
         this.overState.visible = false;
         this.upState.visible = false;
         this.downState.visible = true;
      }
      
      public function Deselect() : void
      {
         this.isArmed = false;
         this.isSelected = false;
         this.overState.visible = false;
         this.upState.visible = true;
         this.downState.visible = false;
      }
      
      private function HandlePress(e:MouseEvent) : void
      {
         this.Arm();
      }
      
      private function HandleRelease(e:MouseEvent) : void
      {
         if(this.isArmed)
         {
            this.Select();
         }
      }
      
      private function HandleOver(e:MouseEvent) : void
      {
         if(this.isSelected)
         {
            this.overState.visible = false;
            this.upState.visible = false;
            this.downState.visible = true;
         }
         else
         {
            this.overState.visible = true;
            this.upState.visible = false;
            this.downState.visible = false;
         }
      }
      
      private function HandleOut(e:MouseEvent) : void
      {
         this.Disarm();
         if(this.isSelected)
         {
            this.overState.visible = false;
            this.upState.visible = false;
            this.downState.visible = true;
         }
         else
         {
            this.overState.visible = false;
            this.upState.visible = true;
            this.downState.visible = false;
         }
      }
   }
}
