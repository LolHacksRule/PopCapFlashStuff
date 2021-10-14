package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class SmallCoinLabel extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _prefix:TextField;
      
      private var _text:TextField;
      
      private var _icon:Bitmap;
      
      public function SmallCoinLabel(app:Blitz3App)
      {
         var format:TextFormat = null;
         super();
         this.m_App = app;
         this._icon = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN));
         this._icon.smoothing = true;
         this._icon.width = 12;
         this._icon.height = 12;
         this._icon.filters = [new GlowFilter(0,1,2,2,4)];
         format = new TextFormat();
         format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         format.size = 12;
         format.color = 16777215;
         format.align = "left";
         this._text = new TextField();
         this._text.defaultTextFormat = format;
         this._text.embedFonts = true;
         this._text.htmlText = "0";
         this._text.selectable = false;
         this._text.autoSize = TextFieldAutoSize.LEFT;
         this._text.filters = [new GlowFilter(0,1,2,2,4)];
         this._prefix = new TextField();
         this._prefix.defaultTextFormat = format;
         this._prefix.embedFonts = true;
         this._prefix.htmlText = "";
         this._prefix.selectable = false;
         this._prefix.autoSize = TextFieldAutoSize.RIGHT;
         this._prefix.filters = [new GlowFilter(0,1,2,2,4)];
         addChild(this._prefix);
         addChild(this._text);
         addChild(this._icon);
      }
      
      public function HideCoin() : void
      {
         this._icon.visible = false;
         this._prefix.visible = false;
         this.Center();
      }
      
      public function ShowCoin() : void
      {
         this._icon.visible = true;
         this._prefix.visible = true;
         this.Center();
      }
      
      public function SetSize(width:int, height:int) : void
      {
         this._width = width;
         this._height = height;
         this._icon.y = height * 0.5 - this._icon.height * 0.5 - 1;
         this.Center();
      }
      
      public function SetText(prefix:String, value:String) : void
      {
         this._prefix.htmlText = prefix;
         this._text.htmlText = value;
         this.Center();
      }
      
      public function SetColor(color:uint) : void
      {
         this._prefix.textColor = color;
         this._text.textColor = color;
      }
      
      private function Center() : void
      {
         var totalWidth:int = 0;
         if(this._icon.visible)
         {
            totalWidth = this._prefix.width + this._icon.width + this._text.width;
            this._prefix.x = this._width * 0.5 - totalWidth * 0.5;
            this._icon.x = this._prefix.x + this._prefix.width;
            this._text.x = this._icon.x + this._icon.width;
         }
         else
         {
            this._text.x = this._width * 0.5 - this._text.width * 0.5;
         }
      }
   }
}
