package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.Blitz3App;
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
      
      private var mApp:Blitz3App;
      
      public function CoinDisplay(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.mCoins = new TextField();
      }
      
      public function Init() : void
      {
         this.mCoins.defaultTextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,12,16770048);
         this.mCoins.embedFonts = true;
         this.mCoins.selectable = false;
         this.mCoins.mouseEnabled = false;
         this.mCoins.multiline = false;
         this.mCoins.autoSize = TextFieldAutoSize.LEFT;
         this.mCoins.filters = [new GlowFilter(0,1,5,5,8)];
         this.SetCoins(1600);
      }
      
      public function SetCoins(coins:int) : void
      {
         var coinString:String = this.mApp.locManager.GetLocString("UI_GAMESTATS_EARNED");
         coinString = coinString.replace("%s",StringUtils.InsertNumberCommas(coins));
      }
   }
}
