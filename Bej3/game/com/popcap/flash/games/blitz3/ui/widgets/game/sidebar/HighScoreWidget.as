package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.framework.utils.StringUtils;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class HighScoreWidget extends Sprite
   {
       
      
      private var mApp:Blitz3Game;
      
      private var mIsInited:Boolean = false;
      
      private var mSprite:Sprite;
      
      private var mBackground:Sprite;
      
      private var mText:TextField;
      
      private var mFormat:TextFormat;
      
      private var mScore:int = -1;
      
      public function HighScoreWidget(app:Blitz3Game)
      {
         super();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         this.mFormat = new TextFormat();
         this.mFormat.font = Blitz3Fonts.BLITZ_STANDARD;
         this.mFormat.size = 10;
         this.mFormat.align = TextFormatAlign.CENTER;
         this.mText = new TextField();
         this.mText.embedFonts = true;
         this.mText.textColor = 16777215;
         this.mText.defaultTextFormat = this.mFormat;
         this.FormatScore();
         this.mText.width = this.mText.textWidth + 5;
         this.mText.height = this.mText.textHeight + 5;
         this.mText.x = 0;
         this.mText.y = 0;
         this.mText.filters = [new GlowFilter(0)];
         this.mText.selectable = false;
         this.mBackground = new Sprite();
         with(this.mBackground.graphics)
         {
            beginFill(0,0.01);
            drawRoundRect(0,0,mText.width,mText.height,8,8);
            endFill();
         }
         this.mBackground.x = 0;
         this.mBackground.y = 0;
         this.Reset();
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         var score:int = this.mApp.currentHighScore;
         if(score > this.mScore)
         {
            this.mScore = score;
            this.FormatScore();
         }
      }
      
      public function Update() : void
      {
      }
      
      public function Draw() : void
      {
      }
      
      private function FormatScore() : void
      {
         var s:String = "HIGH SCORE";
         if(this.mApp.network.isOffline)
         {
            s += "\nFOR THIS SESSION";
            this.mFormat.size = 10;
            this.mText.defaultTextFormat = this.mFormat;
         }
         else
         {
            this.mFormat.size = 12;
            this.mText.defaultTextFormat = this.mFormat;
         }
         s += "\n" + StringUtils.InsertNumberCommas(this.mScore);
         this.mText.htmlText = s;
      }
   }
}
