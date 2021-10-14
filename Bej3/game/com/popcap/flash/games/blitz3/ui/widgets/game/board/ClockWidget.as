package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ClockWidget extends Sprite
   {
       
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      private var mTimer:Sprite;
      
      private var mTimeText:TextField;
      
      private var mHurrahTimer:int = 0;
      
      public function ClockWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
         alpha = 0;
      }
      
      public function Init() : void
      {
         var format:TextFormat = new TextFormat();
         format.font = Blitz3Fonts.BLITZ_STANDARD;
         format.size = 16;
         format.align = TextFormatAlign.CENTER;
         this.mTimeText = new TextField();
         this.mTimeText.embedFonts = true;
         this.mTimeText.textColor = 16777215;
         this.mTimeText.defaultTextFormat = format;
         this.mTimeText.filters = [new GlowFilter(0,1,2,2)];
         this.mTimeText.width = 160;
         this.mTimeText.height = 22;
         this.mTimeText.x = -this.mTimeText.width / 2;
         this.mTimeText.y = -this.mTimeText.height / 2;
         this.mTimeText.cacheAsBitmap = true;
         this.mTimer = new Sprite();
         this.mTimer.addChild(this.mTimeText);
         this.mTimer.cacheAsBitmap = true;
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         alpha = 0;
         x = 160;
         y = 160;
         scaleX = 4;
         scaleY = 4;
         this.mTimer.scaleX = 1;
         this.mTimer.scaleY = 1;
      }
      
      public function Update() : void
      {
         var percent:Number = NaN;
         var sin:Number = NaN;
         var newScale:Number = NaN;
         var time:int = 0;
         var seconds:int = 0;
         var minutes:int = 0;
         var minuteStr:String = null;
         var secondStr:String = null;
         var clock:String = null;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         if(this.mApp.logic.lastHurrahLogic.IsRunning())
         {
            ++this.mHurrahTimer;
         }
         if(this.mApp.logic.lastHurrahLogic.IsRunning())
         {
            this.mTimeText.htmlText = this.mApp.locManager.GetLocString("UI_GAMEBOARD_LAST_HURRAH");
            percent = this.mHurrahTimer * 0.04;
            sin = Math.sin(percent * Math.PI / 2);
            newScale = 1 + sin * 0.2;
            if(this.mTimer.scaleX != newScale)
            {
               this.mTimer.scaleX = newScale;
               this.mTimer.scaleY = newScale;
            }
         }
         else
         {
            this.mHurrahTimer = 0;
            time = this.mApp.logic.timerLogic.GetTimeRemaining();
            seconds = Math.ceil(time * 0.01);
            minutes = 0;
            while(seconds >= 60)
            {
               seconds -= 60;
               minutes++;
            }
            minuteStr = minutes.toString();
            secondStr = seconds.toString();
            if(seconds < 10)
            {
               secondStr = "0" + seconds.toString();
            }
            clock = minuteStr + ":" + secondStr;
            this.mTimeText.htmlText = clock;
         }
      }
      
      public function Draw() : void
      {
      }
   }
}
