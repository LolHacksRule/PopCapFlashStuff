package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class MediumCoinLabel extends Sprite
   {
      
      public static const DEFAULT_COLOR:int = 16767036;
      
      public static const NEGATIVE_COLOR:int = 16711680;
       
      
      private var m_App:Blitz3App;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _text:TextField;
      
      private var _icon:Bitmap;
      
      public function MediumCoinLabel(param1:Blitz3App, param2:int = 16, param3:int = 0)
      {
         super();
         this.m_App = param1;
         this._icon = new Bitmap(param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN));
         this._icon.smoothing = true;
         if(param3 > 0)
         {
            this._icon.width = param3;
            this._icon.height = param3;
         }
         else if(param3 != -1)
         {
            this._icon.width = param2 + 1;
            this._icon.height = param2 + 1;
         }
         this._icon.filters = [new GlowFilter(0,1,2,2,4)];
         var _loc4_:TextFormat;
         (_loc4_ = new TextFormat()).font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         _loc4_.size = param2;
         _loc4_.color = DEFAULT_COLOR;
         _loc4_.align = TextFormatAlign.LEFT;
         this._text = new TextField();
         this._text.defaultTextFormat = _loc4_;
         this._text.embedFonts = true;
         this._text.htmlText = "0";
         this._text.selectable = false;
         this._text.autoSize = TextFieldAutoSize.LEFT;
         this._text.filters = [new BevelFilter(9,90,16777164,1,14315783,1,9,9),new DropShadowFilter(0,90,0,1,5,5,2.5)];
         addChild(this._text);
         addChild(this._icon);
      }
      
      public function ShowIcon() : void
      {
         this._icon.visible = true;
         this._text.x = this._icon.width;
      }
      
      public function HideIcon() : void
      {
         this._icon.visible = false;
         this._text.x = 0;
      }
      
      public function SetSize(param1:int, param2:int, param3:Boolean = true) : void
      {
         this._width = param1;
         this._height = param2;
         this._icon.y = param2 / 2 - this._icon.height / 2;
         if(param3)
         {
            this.Center();
         }
      }
      
      public function SetText(param1:String, param2:Boolean = true) : void
      {
         var value:String = param1;
         var pCenter:Boolean = param2;
         this._text.htmlText = value;
         this._text.x = this._icon.width;
         var format:TextFormat = this._text.defaultTextFormat;
         format.color = DEFAULT_COLOR;
         try
         {
            if(int(value.replace(",","")) < 0)
            {
               format.color = NEGATIVE_COLOR;
            }
         }
         catch(err:Error)
         {
         }
         this._text.setTextFormat(format);
         if(pCenter)
         {
            this.Center();
         }
         else
         {
            this._text.x = this._icon.x + this._icon.width;
         }
      }
      
      private function Center() : void
      {
         var _loc1_:int = this._icon.width + this._text.width;
         this._icon.x = this._width * 0.5 - _loc1_ * 0.5;
         this._text.x = this._icon.x + this._icon.width;
      }
   }
}
