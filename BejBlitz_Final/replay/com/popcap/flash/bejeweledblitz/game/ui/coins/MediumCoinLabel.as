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
      
      public function MediumCoinLabel(app:Blitz3App, fontSize:int = 16)
      {
         super();
         this.m_App = app;
         this._icon = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN));
         this._icon.smoothing = true;
         this._icon.width = fontSize + 1;
         this._icon.height = fontSize + 1;
         this._icon.filters = [new GlowFilter(0,1,2,2,4)];
         var format:TextFormat = new TextFormat();
         format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         format.size = fontSize;
         format.color = DEFAULT_COLOR;
         format.align = TextFormatAlign.LEFT;
         this._text = new TextField();
         this._text.defaultTextFormat = format;
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
      
      public function SetSize(w:int, h:int) : void
      {
         this._width = w;
         this._height = h;
         this._icon.y = h * 0.5 - this._icon.height * 0.5;
         this.Center();
      }
      
      public function SetText(value:String) : void
      {
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
            throw err;
         }
         this._text.setTextFormat(format);
         this.Center();
      }
      
      private function Center() : void
      {
         var totalWidth:int = this._icon.width + this._text.width;
         this._icon.x = this._width * 0.5 - totalWidth * 0.5;
         this._text.x = this._icon.x + this._icon.width;
      }
   }
}
