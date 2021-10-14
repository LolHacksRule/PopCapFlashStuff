package com.popcap.flash.games.blitz3.ui.widgets.coins
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class OfferRadioButton extends Sprite
   {
       
      
      public var §_-VE§:TextField;
      
      public var cost:int = 0;
      
      public var downState:Sprite;
      
      public var §_-k8§:TextField;
      
      public var §_-nN§:TextField;
      
      public var overState:Sprite;
      
      public var §_-1L§:Sprite;
      
      private var §_-An§:Boolean = false;
      
      public var §_-IR§:Sprite;
      
      private var §_-W8§:Boolean = false;
      
      public var §_-Uv§:Sprite;
      
      public var §super§:Sprite;
      
      public var §_-Xl§:TextField;
      
      public var upState:Sprite;
      
      public var §_-MU§:int = -1;
      
      public function OfferRadioButton(param1:§_-0Z§, param2:int, param3:int, param4:int, param5:int = 0, param6:Boolean = false)
      {
         super();
         this.§_-MU§ = param2;
         mouseChildren = false;
         hitArea = this.§super§;
         this.§super§.visible = false;
         buttonMode = true;
         useHandCursor = true;
         cacheAsBitmap = true;
         addEventListener(MouseEvent.MOUSE_DOWN,this.§_-aj§);
         addEventListener(MouseEvent.MOUSE_UP,this.§_-GV§);
         addEventListener(MouseEvent.MOUSE_OVER,this.§_-GC§);
         addEventListener(MouseEvent.MOUSE_OUT,this.§_-5T§);
         this.overState.visible = false;
         this.upState.visible = true;
         this.downState.visible = false;
         this.§_-nN§.x += 4;
         this.§_-nN§.width = 0;
         this.§_-nN§.multiline = false;
         this.§_-nN§.wordWrap = false;
         this.§_-nN§.autoSize = TextFieldAutoSize.LEFT;
         this.§_-nN§.text = §_-Ze§.§_-2P§(param3);
         this.§_-VE§.width = 0;
         this.§_-VE§.multiline = false;
         this.§_-VE§.wordWrap = false;
         this.§_-VE§.autoSize = TextFieldAutoSize.LEFT;
         this.§_-VE§.text = param1.§_-JC§.GetLocString("UI_BUTTON_OFFER_RADIO");
         this.§_-VE§.x = this.§_-nN§.x + this.§_-nN§.width;
         this.§_-Xl§.width = 0;
         this.§_-Xl§.multiline = false;
         this.§_-Xl§.wordWrap = false;
         this.§_-Xl§.autoSize = TextFieldAutoSize.LEFT;
         this.§_-Xl§.text = §_-Ze§.§_-2P§(param4);
         this.§_-Xl§.x = this.§_-VE§.x + this.§_-VE§.width;
         this.cost = param4;
         this.§_-Uv§.x = this.§_-Xl§.x;
         this.§_-Uv§.width = this.§_-Xl§.width;
         this.§_-Uv§.visible = param5 > 0;
         this.§_-IR§.visible = param5 > 0;
         if(param5 > 0)
         {
            this.§_-k8§.width = 0;
            this.§_-k8§.multiline = false;
            this.§_-k8§.wordWrap = false;
            this.§_-k8§.autoSize = TextFieldAutoSize.LEFT;
            this.§_-k8§.text = §_-Ze§.§_-2P§(param5);
            this.§_-k8§.x = this.§_-Xl§.x + this.§_-Xl§.width + 4;
            this.§_-1L§.x = this.§_-k8§.x + this.§_-k8§.width + 4;
            this.cost = param5;
         }
         else
         {
            this.§_-k8§.visible = false;
            this.§_-1L§.x = this.§_-Xl§.x + this.§_-Xl§.width + 4;
         }
         this.§super§.width = this.§_-1L§.x + this.§_-1L§.width;
         this.§_-IR§.x = hitArea.width / 2 - this.§_-IR§.width / 2;
         if(this.§_-MU§ == -1)
         {
            this.§_-nN§.visible = false;
            this.§_-VE§.visible = false;
            this.§_-Xl§.visible = false;
            this.§_-1L§.visible = false;
            this.§_-k8§.visible = false;
            this.§_-Uv§.visible = false;
            this.§_-IR§.visible = false;
         }
      }
      
      private function §_-GC§(param1:MouseEvent) : void
      {
         if(this.§_-An§)
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
      
      private function §_-aj§(param1:MouseEvent) : void
      {
         this.§_-k7§();
      }
      
      public function Select() : void
      {
         dispatchEvent(new Event("Selected"));
         this.§_-W8§ = false;
         this.§_-An§ = true;
         this.overState.visible = false;
         this.upState.visible = false;
         this.downState.visible = true;
      }
      
      private function §_-GV§(param1:MouseEvent) : void
      {
         if(this.§_-W8§)
         {
            this.Select();
         }
      }
      
      private function §_-5T§(param1:MouseEvent) : void
      {
         this.§_-ba§();
         if(this.§_-An§)
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
      
      public function §_-ba§() : void
      {
         this.§_-W8§ = false;
      }
      
      public function Deselect() : void
      {
         this.§_-W8§ = false;
         this.§_-An§ = false;
         this.overState.visible = false;
         this.upState.visible = true;
         this.downState.visible = false;
      }
      
      public function §_-k7§() : void
      {
         if(this.§_-An§)
         {
            return;
         }
         this.§_-W8§ = true;
         this.overState.visible = false;
         this.upState.visible = false;
         this.downState.visible = true;
      }
   }
}
