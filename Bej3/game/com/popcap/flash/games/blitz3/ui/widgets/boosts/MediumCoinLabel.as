package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class MediumCoinLabel extends Sprite
   {
      
      public static const DEFAULT_COLOR:int = 16777024;
      
      public static const NEGATIVE_COLOR:int = 16711680;
       
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _text:TextField;
      
      private var _icon:Bitmap;
      
      public function MediumCoinLabel()
      {
         super();
         var format:TextFormat = new TextFormat();
         format.font = Blitz3Fonts.BLITZ_STANDARD;
         format.size = 16;
         format.color = DEFAULT_COLOR;
         format.align = TextFormatAlign.LEFT;
         this._text = new TextField();
         this._text.defaultTextFormat = format;
         this._text.embedFonts = true;
         this._text.htmlText = "0";
         this._text.selectable = false;
         this._text.autoSize = TextFieldAutoSize.LEFT;
         this._text.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         addChild(this._text);
      }
      
      public function ShowIcon() : void
      {
         this._text.x = this._icon.width;
      }
      
      public function HideIcon() : void
      {
         this._text.x = 0;
      }
      
      public function SetSize(w:int, h:int) : void
      {
         this._width = w;
         this._height = h;
         this.Center();
      }
      
      public function SetText(value:String) : void
      {
         this._text.htmlText = value;
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
      }
   }
}
