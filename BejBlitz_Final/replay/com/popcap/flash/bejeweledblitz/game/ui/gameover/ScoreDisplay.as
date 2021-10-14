package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ScoreDisplay extends Sprite
   {
       
      
      private var mDynamic:TextField;
      
      private var mStatic:TextField;
      
      private var m_App:Blitz3App;
      
      public function ScoreDisplay(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.mDynamic = new TextField();
         this.mStatic = new TextField();
      }
      
      public function Init() : void
      {
         var dFormat:TextFormat = null;
         dFormat = new TextFormat();
         dFormat.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         dFormat.size = 30;
         this.mDynamic.textColor = 16777215;
         this.mDynamic.filters = [new GlowFilter(0,1,5,5,8)];
         this.mDynamic.x = 0;
         this.mDynamic.y = 0;
         this.mDynamic.defaultTextFormat = dFormat;
         this.mDynamic.embedFonts = true;
         this.mDynamic.selectable = false;
         this.mDynamic.mouseEnabled = false;
         this.mDynamic.autoSize = TextFieldAutoSize.LEFT;
         var sFormat:TextFormat = new TextFormat();
         sFormat.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         sFormat.size = 20;
         this.mStatic.textColor = 16777215;
         this.mStatic.filters = [new GlowFilter(0,1,5,5,8)];
         this.mStatic.defaultTextFormat = sFormat;
         this.mStatic.embedFonts = true;
         this.mStatic.selectable = false;
         this.mStatic.mouseEnabled = false;
         this.mStatic.autoSize = TextFieldAutoSize.LEFT;
         this.SetScore(500000);
         this.mStatic.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_PTS);
         addChild(this.mStatic);
         addChild(this.mDynamic);
      }
      
      public function SetScore(score:int) : void
      {
         this.mDynamic.htmlText = StringUtils.InsertNumberCommas(score);
         this.mDynamic.width = this.mDynamic.textWidth + 5;
         this.mStatic.x = this.mDynamic.width;
         this.mStatic.y = this.mDynamic.height - this.mStatic.height - 5;
      }
   }
}
