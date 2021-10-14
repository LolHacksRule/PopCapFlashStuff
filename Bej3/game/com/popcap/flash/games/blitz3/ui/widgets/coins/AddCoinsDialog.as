package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class AddCoinsDialog extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      public var closeButton:MovieClip;
      
      public var buttons:Vector.<OfferRadioButton>;
      
      public var buttonGroup:ButtonGroup;
      
      public var buttonPanel:Sprite;
      
      public var acceptButton:MovieClip;
      
      public var background:Sprite;
      
      public var headline:MovieClip;
      
      public var fbCreditText:DisplayObject;
      
      public var otherPaymentText:DisplayObject;
      
      public var logosImage:DisplayObject;
      
      private var m_CloseWrapper:FadeButtonWrapper;
      
      private var m_AcceptWrapper:FadeButtonWrapper;
      
      public function AddCoinsDialog(app:Blitz3Game, includeSG:Boolean = false)
      {
         super();
         this.m_App = app;
         this.buttons = new Vector.<OfferRadioButton>();
         this.buttonGroup = new ButtonGroup();
      }
      
      public function SetDeficitText(str:String) : void
      {
         this.headline.txtDeficit.htmlText = str;
         if(str == "")
         {
            this.headline.gotoAndStop(1);
            this.headline.txtDeficit.visible = false;
         }
         else
         {
            this.headline.gotoAndStop(2);
            this.headline.txtDeficit.visible = true;
         }
      }
      
      public function AddButton(sku:int, amount:int, price:int, discount:int, numDiscounts:int) : void
      {
         var button:OfferRadioButton = new OfferRadioButton(this.m_App,sku,amount,price,discount,numDiscounts == 1);
         this.buttons.push(button);
         this.buttonGroup.AddButton(button);
         this.buttonPanel.addChild(button);
      }
      
      private function LayoutButtons() : void
      {
         var b:OfferRadioButton = null;
         var numButtons:int = this.buttons.length;
         var width:int = 0;
         var y:int = 0;
         for(var i:int = 0; i < numButtons; i++)
         {
            b = this.buttons[i];
            if(b.skuID == -1)
            {
               y += 38;
            }
            b.y = y;
            if(b.saleFrame.visible)
            {
               y += b.saleFrame.height;
            }
            else
            {
               y += b.hitBox.height;
            }
            width = Math.max(width,b.hitBox.width);
         }
         this.buttonPanel.x = -(width / 2);
      }
   }
}
