package com.popcap.flash.bejeweledblitz.game.ui.gameover
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
   import flash.text.TextFormatAlign;
   
   public class LegendPopup extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Label:TextField;
      
      protected var m_Background:Bitmap;
      
      public function LegendPopup(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LEGEND_TOOLTIP));
         this.m_Background.x = -this.m_Background.width;
         this.m_Background.y = this.m_Background.height * -0.5 + 5;
         this.m_Label = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,13,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_Label.defaultTextFormat = format;
         this.m_Label.autoSize = TextFieldAutoSize.CENTER;
         this.m_Label.embedFonts = true;
         this.m_Label.selectable = false;
         this.m_Label.multiline = true;
         this.m_Label.wordWrap = true;
         this.m_Label.filters = [new GlowFilter(1191748,1,2,2,4)];
         addChild(this.m_Background);
         addChild(this.m_Label);
         this.SetLabel("This is the message for hypers, powers, etc.");
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function SetLabel(content:String) : void
      {
         this.m_Label.width = this.m_Background.width * 0.9;
         this.m_Label.height = this.m_Background.height * 0.9;
         this.m_Label.htmlText = content;
         this.m_Label.x = this.m_Background.x + (this.m_Background.width - 9) * 0.5 - this.m_Label.width * 0.5;
         this.m_Label.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_Label.height * 0.55;
      }
   }
}
