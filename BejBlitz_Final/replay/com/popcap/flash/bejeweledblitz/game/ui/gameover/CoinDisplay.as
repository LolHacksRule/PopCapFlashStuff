package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class CoinDisplay extends Sprite
   {
       
      
      private var mIcon:Bitmap;
      
      private var mCoins:TextField;
      
      private var m_App:Blitz3App;
      
      public function CoinDisplay(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.mIcon = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN));
         this.mIcon.smoothing = true;
         this.mIcon.width = 12;
         this.mIcon.height = 12;
         this.mIcon.filters = [new GlowFilter(0,1,2,2,4)];
         this.mCoins = new TextField();
      }
      
      public function Init() : void
      {
         this.mCoins.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,16767036);
         this.mCoins.embedFonts = true;
         this.mCoins.selectable = false;
         this.mCoins.mouseEnabled = false;
         this.mCoins.multiline = false;
         this.mCoins.autoSize = TextFieldAutoSize.LEFT;
         this.mCoins.filters = [new GlowFilter(0,1,2,2,4)];
         addChild(this.mIcon);
         addChild(this.mCoins);
         this.SetCoins(1600);
      }
      
      public function SetCoins(coins:int) : void
      {
         var coinString:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_EARNED);
         coinString = coinString.replace("%s",StringUtils.InsertNumberCommas(coins));
         this.mCoins.htmlText = coinString;
         this.mCoins.x = this.mIcon.x + this.mIcon.width;
         this.mCoins.y = 0;
         this.mIcon.y = this.mCoins.height * 0.5 - this.mIcon.height * 0.5 - 1;
      }
   }
}
