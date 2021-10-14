package com.popcap.flash.bejeweledblitz.endgamepopups.view
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PopUpMessageTextfields extends TextField
   {
       
      
      public function PopUpMessageTextfields()
      {
         super();
         autoSize = TextFieldAutoSize.CENTER;
         embedFonts = true;
         multiline = true;
         selectable = false;
         mouseEnabled = false;
         cacheAsBitmap = true;
      }
      
      public function makeHeaderText(param1:String) : void
      {
         defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,null,16764239,true,null,null,null,null,TextFormatAlign.CENTER);
         filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         htmlText = param1;
      }
      
      public function makeBodyText(param1:String) : void
      {
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215,true);
         _loc2_.align = TextFormatAlign.CENTER;
         defaultTextFormat = _loc2_;
         filters = [new GlowFilter(0,1,2,2,20)];
         htmlText = param1;
      }
      
      public function makeGenericText(param1:String = "") : void
      {
         autoSize = TextFieldAutoSize.CENTER;
         htmlText = param1;
      }
      
      public function getTextWidth() : Number
      {
         return width;
      }
   }
}
