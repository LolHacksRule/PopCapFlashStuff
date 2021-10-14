package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ClockWidget extends TextField
   {
      
      private static const XPOS:Number = 160;
      
      private static const YPOS:Number = 160;
      
      private static const YOFFSET:Number = 172;
      
      private static const INIT_TIME:Number = 250;
       
      
      private var m_App:Blitz3App;
      
      private var mInitTimer:int = 0;
      
      private var mHurrahTimer:int = 0;
      
      public function ClockWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         autoSize = TextFieldAutoSize.CENTER;
         embedFonts = true;
         selectable = false;
         mouseEnabled = false;
         filters = [new GlowFilter(0,1,2,2,4)];
         x = XPOS + width * -0.5;
         y = YPOS + height * -0.5;
      }
      
      public function Reset() : void
      {
         alpha = 0;
         scaleX = 4;
         scaleY = 4;
         x = XPOS + width * -0.5;
         y = YPOS + height * -0.5;
         this.mInitTimer = INIT_TIME;
         this.mHurrahTimer = 0;
         this.updateClock();
      }
      
      public function Update() : void
      {
         var percent:Number = NaN;
         var sin:Number = NaN;
         var newScale:Number = NaN;
         var time:int = 0;
         if(alpha < 1)
         {
            alpha += 0.05;
         }
         if(this.m_App.logic.lastHurrahLogic.IsRunning())
         {
            ++this.mHurrahTimer;
            htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMEBOARD_LAST_HURRAH);
            percent = this.mHurrahTimer * 0.04;
            sin = Math.sin(percent * Math.PI * 0.5);
            newScale = 1 + sin * 0.2;
            if(scaleX != newScale)
            {
               scaleX = newScale;
               scaleY = newScale;
               x = XPOS + width * -0.5;
               y = YPOS + YOFFSET + height * -0.5;
            }
         }
         else if(this.mInitTimer > 0)
         {
            --this.mInitTimer;
            time = Math.max(Math.min(100,this.mInitTimer),0);
            percent = 1 - time * 0.01;
            scaleX = (1 - percent) * 3 + 1;
            scaleY = (1 - percent) * 3 + 1;
            x = XPOS + width * -0.5;
            y = YPOS + YOFFSET * percent + height * -0.5;
         }
         else if(!this.m_App.logic.timerLogic.IsPaused())
         {
            this.updateClock();
         }
      }
      
      private function updateClock() : void
      {
         var time:int = this.m_App.logic.timerLogic.GetTimeRemaining();
         var seconds:int = Math.ceil(time * 0.01);
         var minutes:int = 0;
         while(seconds >= 60)
         {
            seconds -= 60;
            minutes++;
         }
         var minuteStr:String = minutes.toString();
         var secondStr:String = seconds.toString();
         if(seconds < 10)
         {
            secondStr = "0" + seconds.toString();
         }
         var clock:String = minuteStr + ":" + secondStr;
         htmlText = clock;
      }
   }
}
