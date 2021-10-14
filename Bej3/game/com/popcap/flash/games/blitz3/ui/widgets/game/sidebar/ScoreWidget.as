package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ScoreWidget extends Sprite
   {
      
      public static const ANIM_TIME:int = 50;
       
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      private var mScoreCap:int = -1;
      
      private var mScoreRoll:int = 0;
      
      private var mLastScore:int = 0;
      
      private var mTimer:int = 0;
      
      private var mMultiValue:int = 0;
      
      private var mBackdrop:Bitmap;
      
      private var mScoreText:TextField;
      
      private var mMultiText:TextField;
      
      private var mBlackGlow:GlowFilter;
      
      public function ScoreWidget(app:Blitz3App)
      {
         this.mBlackGlow = new GlowFilter(0);
         super();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         var format:TextFormat = null;
         this.mBackdrop = new Bitmap(this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_UI_SCORE));
         this.mBackdrop.smoothing = true;
         format = new TextFormat();
         format.font = Blitz3Fonts.BLITZ_STANDARD;
         format.size = 16;
         format.align = TextFormatAlign.CENTER;
         this.mScoreText = new TextField();
         this.mScoreText.embedFonts = true;
         this.mScoreText.textColor = 16777215;
         this.mScoreText.defaultTextFormat = format;
         this.mScoreText.filters = [this.mBlackGlow];
         this.mScoreText.selectable = false;
         this.mScoreText.x = 10;
         this.mScoreText.y = 17;
         this.mScoreText.width = 106;
         this.mScoreText.height = 24;
         this.mMultiText = new TextField();
         this.mMultiText.embedFonts = true;
         this.mMultiText.textColor = 16777215;
         this.mMultiText.defaultTextFormat = format;
         this.mMultiText.filters = [this.mBlackGlow];
         this.mMultiText.selectable = false;
         this.mMultiText.x = 47;
         this.mMultiText.y = 41;
         this.mMultiText.width = 32;
         this.mMultiText.height = 22;
         addChild(this.mBackdrop);
         addChild(this.mScoreText);
         addChild(this.mMultiText);
         this.Reset();
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.mScoreCap = -1;
         this.mScoreRoll = 0;
         this.mLastScore = 0;
         this.mTimer = 0;
         this.mMultiValue = 0;
         this.mScoreText.htmlText = "0";
         this.mMultiText.htmlText = this.mApp.logic.GetCurrentLevel().toString();
      }
      
      public function Update() : void
      {
         var percent:Number = NaN;
         var scoreString:String = null;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         var redrawScore:Boolean = false;
         var redrawMulti:Boolean = false;
         var newScore:int = this.mApp.logic.GetScore();
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
         if(this.mMultiValue != this.mApp.logic.GetCurrentLevel())
         {
            this.mMultiValue = this.mApp.logic.GetCurrentLevel();
            redrawMulti = true;
         }
         if(redrawScore)
         {
            scoreString = StringUtils.InsertNumberCommas(this.mScoreRoll);
            this.mScoreText.htmlText = scoreString;
         }
         if(redrawMulti)
         {
            this.mMultiText.htmlText = this.mMultiValue.toString();
            this.mMultiText.visible = this.mMultiValue > 0;
         }
      }
      
      public function Draw() : void
      {
      }
   }
}
