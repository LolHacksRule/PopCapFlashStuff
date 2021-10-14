package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ScoreWidget extends Sprite
   {
      
      public static const ANIM_TIME:int = 50;
       
      
      private var m_App:Blitz3App;
      
      private var mScoreCap:int = -1;
      
      private var mScoreRoll:int = 0;
      
      private var mLastScore:int = 0;
      
      private var mTimer:int = 0;
      
      private var mMultiValue:int = 0;
      
      private var mBackdrop:Bitmap;
      
      private var mScoreText:TextField;
      
      public var multiText:TextField;
      
      private var mBlackGlow:GlowFilter;
      
      public function ScoreWidget(app:Blitz3App)
      {
         this.mBlackGlow = new GlowFilter(0,1,4,4,2);
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         var format:TextFormat = null;
         this.mBackdrop = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_UI_SCORE));
         format = new TextFormat();
         format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         format.size = 16;
         format.align = TextFormatAlign.CENTER;
         this.mScoreText = new TextField();
         this.mScoreText.embedFonts = true;
         this.mScoreText.textColor = 16777215;
         this.mScoreText.defaultTextFormat = format;
         this.mScoreText.filters = [this.mBlackGlow];
         this.mScoreText.selectable = false;
         this.mScoreText.x = 8;
         this.mScoreText.y = 5;
         this.mScoreText.width = 106;
         this.mScoreText.height = 24;
         this.multiText = new TextField();
         this.multiText.embedFonts = true;
         this.multiText.textColor = 16777215;
         this.multiText.defaultTextFormat = format;
         this.multiText.filters = [this.mBlackGlow];
         this.multiText.selectable = false;
         this.multiText.x = 44;
         this.multiText.y = 33;
         this.multiText.width = 32;
         this.multiText.height = 22;
         addChild(this.mBackdrop);
         addChild(this.mScoreText);
         addChild(this.multiText);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.mScoreCap = -1;
         this.mScoreRoll = 0;
         this.mLastScore = 0;
         this.mTimer = 0;
         this.mMultiValue = 0;
         this.mScoreText.htmlText = "0";
         this.multiText.htmlText = "x1";
      }
      
      public function Update() : void
      {
         var percent:Number = NaN;
         var scoreString:String = null;
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         var redrawScore:Boolean = false;
         var redrawMulti:Boolean = false;
         var newScore:int = this.m_App.logic.scoreKeeper.GetScore();
         if(this.mScoreCap != newScore)
         {
            this.mLastScore = this.mScoreRoll;
            this.mScoreCap = newScore;
            this.mTimer = 0;
         }
         if(this.mScoreRoll < this.mScoreCap)
         {
            ++this.mTimer;
            percent = this.mTimer / ANIM_TIME;
            percent = percent > 1 ? Number(1) : Number(percent);
            this.mScoreRoll = (this.mScoreCap - this.mLastScore) * percent + this.mLastScore;
            redrawScore = true;
         }
         else if(this.mScoreRoll > this.mScoreCap)
         {
            this.mScoreRoll = this.mScoreCap;
            redrawScore = true;
         }
         if(this.mMultiValue != this.m_App.logic.coinTokenLogic.multiCoins)
         {
            this.mMultiValue = this.m_App.logic.coinTokenLogic.multiCoins;
            redrawMulti = true;
         }
         if(redrawScore)
         {
            scoreString = StringUtils.InsertNumberCommas(this.mScoreRoll);
            this.mScoreText.htmlText = scoreString;
         }
         if(redrawMulti)
         {
            this.multiText.htmlText = "x" + this.mMultiValue;
            this.multiText.visible = this.mMultiValue > 0;
         }
      }
   }
}
