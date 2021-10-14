package com.popcap.flash.bejeweledblitz.messages.common
{
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MessageHeader extends TextField
   {
       
      
      private var m_App:App;
      
      public function MessageHeader(app:App, textId:String)
      {
         super();
         this.m_App = app;
         var format:TextFormat = new TextFormat();
         format.font = this.m_App.FontManager.GetFont(Blitz3GameFonts.FONT_FLARE_GOTHIC).fontName;
         format.color = 16764239;
         format.bold = true;
         format.align = "center";
         embedFonts = true;
         multiline = true;
         selectable = false;
         mouseEnabled = false;
         defaultTextFormat = format;
         htmlText = this.m_App.TextManager.GetLocString(textId);
         filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         width = textWidth + 15;
         height = textHeight + 5;
         cacheAsBitmap = true;
      }
      
      public function getTextWidth() : Number
      {
         return width;
      }
      
      public function setHeaderText(text:String) : void
      {
         htmlText = text;
         width = textWidth + 15;
         height = textHeight + 5;
      }
      
      public function getHeaderText() : String
      {
         return htmlText;
      }
   }
}
