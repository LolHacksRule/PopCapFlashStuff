package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PointPopup extends Sprite
   {
      
      public static const BASE_BUBBLE:int = 0;
      
      public static const BONUS_BUBBLE:int = 1;
      
      public static const HURRAH_BUBBLE:int = 2;
       
      
      private var m_Label:TextField;
      
      private var m_Background:Bitmap;
      
      private var m_App:Blitz3App;
      
      private var m_Bubbles:Vector.<BitmapData>;
      
      public function PointPopup(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Bubbles = new Vector.<BitmapData>(3);
         this.m_Bubbles[BASE_BUBBLE] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_POINT_POPUP_BASE_BUBBLE);
         this.m_Bubbles[BONUS_BUBBLE] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_POINT_POPUP_BONUS_BUBBLE);
         this.m_Bubbles[HURRAH_BUBBLE] = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_POINT_POPUP_HURRAH_BUBBLE);
         this.m_Background = new Bitmap();
         this.m_Label = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,14,16777215);
         format.align = TextFormatAlign.CENTER;
         format.leading = -2;
         this.m_Label.defaultTextFormat = format;
         this.m_Label.autoSize = TextFieldAutoSize.CENTER;
         this.m_Label.embedFonts = true;
         this.m_Label.selectable = false;
         this.m_Label.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_LAST_HURRAH_POPUP);
         this.m_Label.filters = [new GlowFilter(1191748,1,2,2,4)];
         mouseEnabled = false;
         mouseChildren = false;
         addChild(this.m_Background);
         addChild(this.m_Label);
      }
      
      public function SetContent(type:int, labelText:String, points:int) : void
      {
         if(type >= 0 && type < this.m_Bubbles.length)
         {
            this.m_Background.bitmapData = this.m_Bubbles[type];
            this.m_Background.x = -this.m_Background.width;
            this.m_Background.y = this.m_Background.height * -0.5 + 5;
         }
         this.m_Label.width = this.m_Background.width;
         this.m_Label.height = this.m_Background.height;
         var content:String = labelText;
         content = content.replace("%s",StringUtils.InsertNumberCommas(points));
         content = content.replace(/<[bB][rR]>/g,"\n");
         this.m_Label.htmlText = content;
         this.m_Label.x = this.m_Background.x + (this.m_Background.width - 6) * 0.5 - this.m_Label.width * 0.5;
         this.m_Label.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_Label.height * 0.5;
      }
   }
}
