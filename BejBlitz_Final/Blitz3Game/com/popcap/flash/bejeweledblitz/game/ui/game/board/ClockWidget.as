package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ClockWidget extends TextField
   {
      
      private static const _XPOS:Number = 160;
      
      private static const _YPOS:Number = 160;
      
      private static const _YOFFSET:Number = 175;
      
      private static const _INIT_TIME:Number = 250;
       
      
      private var _app:Blitz3App;
      
      private var _initTimer:int = 0;
      
      private var _hurrahTimer:int = 0;
      
      private var _blazingTimer:int = 0;
      
      private var _forceDisplayClockText:String = "";
      
      public function ClockWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function Init() : void
      {
         defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         autoSize = TextFieldAutoSize.CENTER;
         embedFonts = true;
         selectable = false;
         mouseEnabled = false;
         filters = [new GlowFilter(0,1,2,2,4)];
         this.updateClockText();
      }
      
      public function Reset() : void
      {
         visible = false;
         this._initTimer = _INIT_TIME;
         this._hurrahTimer = 0;
         this._blazingTimer = 0;
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._initTimer > 0)
         {
            if(this._initTimer == _INIT_TIME)
            {
               (this._app.ui as MainWidgetGame).game.board.compliments.showTime(this.getFormattedClockTime(this._app.logic.timerLogic.m_UITimer));
            }
            --this._initTimer;
            x = _XPOS + width * -0.5;
            y = _YPOS + height * -0.5 + _YOFFSET;
            if(this._initTimer <= 0)
            {
               --this._initTimer;
               visible = true;
            }
         }
         else if(this._app.logic.lastHurrahLogic.IsRunning() && !this._app.logic.lastHurrahLogic.isPreCoinHurrah())
         {
            ++this._hurrahTimer;
            htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMEBOARD_LAST_HURRAH);
            _loc1_ = this._hurrahTimer * 0.04;
            _loc2_ = Math.sin(_loc1_ * Math.PI * 0.5);
            _loc3_ = 1 + _loc2_ * 0.2;
            if(scaleX != _loc3_)
            {
               scaleX = _loc3_;
               scaleY = _loc3_;
               x = _XPOS + width * -0.5;
               y = _YPOS + height * -0.5 + _YOFFSET;
            }
         }
         else if(this._app.logic.blazingSpeedLogic.GetTimeLeft() > 0)
         {
            htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMEBOARD_BLAZING_SPEED);
            ++this._blazingTimer;
            _loc1_ = this._blazingTimer * 0.04;
            _loc2_ = Math.sin(_loc1_ * Math.PI * 0.5);
            _loc3_ = 1 + _loc2_ * 0.2;
            if(scaleX != _loc3_)
            {
               scaleX = _loc3_;
               scaleY = _loc3_;
               x = _XPOS + width * -0.5;
               y = _YPOS + height * -0.5 + _YOFFSET;
            }
         }
         else if(!this._app.logic.timerLogic.IsPaused())
         {
            this.updateClockText();
         }
      }
      
      private function getFormattedClockTime(param1:int) : Array
      {
         var _loc2_:int = Math.ceil(param1 * 0.01);
         var _loc3_:int = 0;
         while(_loc2_ >= 60)
         {
            _loc2_ -= 60;
            _loc3_++;
         }
         var _loc4_:String = _loc3_.toString();
         var _loc5_:String = _loc2_.toString();
         if(_loc2_ < 10)
         {
            _loc5_ = "0" + _loc2_.toString();
         }
         return [_loc4_,_loc5_];
      }
      
      private function updateAndGetClockTime() : Array
      {
         var _loc1_:int = this._app.logic.timerLogic.GetTimeRemaining();
         return this.getFormattedClockTime(_loc1_);
      }
      
      private function updateClockText() : void
      {
         var _loc1_:Array = this.updateAndGetClockTime();
         if(this._forceDisplayClockText.length == 0)
         {
            text = _loc1_[0] + ":" + _loc1_[1];
         }
         else
         {
            text = this._forceDisplayClockText;
         }
      }
      
      public function SetForceDisplayClockText(param1:String) : void
      {
         this._forceDisplayClockText = param1;
      }
   }
}
