package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ScoreDisplay extends Sprite
   {
       
      
      private var mDynamic:TextField;
      
      private var mStatic:TextField;
      
      private var mApp:Blitz3App;
      
      public function ScoreDisplay(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.mDynamic = new TextField();
         this.mStatic = new TextField();
      }
      
      public function Init() : void
      {
         var dFormat:TextFormat = new TextFormat();
         dFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         dFormat.size = 24;
         dFormat.align = TextFormatAlign.CENTER;
         this.mDynamic.textColor = 16777215;
         this.mDynamic.filters = [new GlowFilter(11689519,1,5,5,8)];
         this.mDynamic.x = 0;
         this.mDynamic.y = 0;
         this.mDynamic.width = 150;
         this.mDynamic.height = 30;
         this.mDynamic.defaultTextFormat = dFormat;
         this.mDynamic.embedFonts = true;
         this.mDynamic.selectable = false;
         this.mDynamic.mouseEnabled = false;
         var sFormat:TextFormat = new TextFormat();
         sFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         sFormat.size = 20;
         sFormat.align = TextFormatAlign.CENTER;
         this.mStatic.textColor = 8408090;
         this.mStatic.filters = [new GlowFilter(15844760,1,5,5,8)];
         this.mStatic.defaultTextFormat = sFormat;
         this.mStatic.width = 150;
         this.mStatic.height = 30;
         this.mStatic.y = -30;
         this.mStatic.embedFonts = true;
         this.mStatic.selectable = false;
         this.mStatic.mouseEnabled = false;
         this.mStatic.autoSize = TextFieldAutoSize.CENTER;
         this.SetScore(500000);
         this.mStatic.htmlText = this.mApp.locManager.GetLocString("UI_GAMESTATS_PTS");
         addChild(this.mStatic);
         addChild(this.mDynamic);
      }
      
      public function SetScore(score:int) : void
      {
         this.mDynamic.htmlText = StringUtils.InsertNumberCommas(score);
      }
   }
}
