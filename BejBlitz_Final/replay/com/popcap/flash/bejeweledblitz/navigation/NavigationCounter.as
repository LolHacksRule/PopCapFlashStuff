package com.popcap.flash.bejeweledblitz.navigation
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3navigation.resources.Blitz3NavigationImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class NavigationCounter extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_NavCounterBackground:Bitmap;
      
      private var m_NavCounterText:TextField;
      
      private var m_Value:int;
      
      public function NavigationCounter(app:Blitz3App, value:int)
      {
         super();
         this.m_App = app;
         this.m_NavCounterBackground = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_BUTTON_COUNTER));
         this.m_NavCounterText = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_NavCounterText.defaultTextFormat = format;
         this.m_NavCounterText.autoSize = TextFieldAutoSize.CENTER;
         this.m_NavCounterText.multiline = false;
         this.m_NavCounterText.embedFonts = true;
         this.m_NavCounterText.selectable = false;
         this.m_NavCounterText.mouseEnabled = false;
         this.m_NavCounterText.filters = [new GlowFilter(0,1,2,2,2)];
         addChild(this.m_NavCounterBackground);
         addChild(this.m_NavCounterText);
         this.Value = value;
      }
      
      public function set Value(value:int) : void
      {
         this.m_Value = value;
         this.m_NavCounterText.htmlText = this.m_Value.toString();
         this.m_NavCounterText.x = this.m_NavCounterBackground.width * 0.5 - this.m_NavCounterText.width * 0.5;
         visible = this.m_Value > 0;
      }
   }
}
