package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.GameWidget;
   import com.popcap.flash.games.blitz3.speed;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class SpeedBonusWidget extends Sprite
   {
      
      public static const FADE_TIME:int = 100;
       
      
      private var _app:Blitz3App;
      
      private var _lastLevel:int = 0;
      
      private var _fadeTimer:int = 0;
      
      public var _blazingSpeedAsset:speed;
      
      private var _yellowFill:MovieClip;
      
      private var _redFill:MovieClip;
      
      private var _oldBlazePercentageYellow:int = 0;
      
      private var _oldBlazePercentageRed:int = 0;
      
      private var _gameWidget:GameWidget = null;
      
      public function SpeedBonusWidget(param1:Blitz3App, param2:speed)
      {
         super();
         this._app = param1;
         this._blazingSpeedAsset = param2;
         this._blazingSpeedAsset.gotoAndStop(1);
         this._yellowFill = this._blazingSpeedAsset.Yellow;
         this._redFill = this._blazingSpeedAsset.Red;
         this._yellowFill.gotoAndStop(1);
         this._redFill.gotoAndStop(1);
         this._blazingSpeedAsset.txtReset.text = "+0";
         this._oldBlazePercentageYellow = 0;
         this._oldBlazePercentageRed = 0;
      }
      
      public function Init() : void
      {
         this._blazingSpeedAsset.txtReset.text = "+0";
         this._gameWidget = (this._app.ui as MainWidgetGame).game;
      }
      
      public function Reset() : void
      {
         this._lastLevel = 0;
         this._blazingSpeedAsset.txtReset.text = "+0";
         this._oldBlazePercentageYellow = 0;
         this._oldBlazePercentageRed = 0;
         this._yellowFill.gotoAndStop(1);
         this._redFill.gotoAndStop(1);
      }
      
      public function Update() : void
      {
         if(this._app.logic.timerLogic.IsPaused())
         {
            return;
         }
         if(this._app.logic.blazingSpeedLogic.IsAnimationPending())
         {
            return;
         }
      }
      
      public function Draw() : void
      {
         var _loc1_:int = 0;
         if(this._app.logic.speedBonus.GetLevel() > 0)
         {
            _loc1_ = this._app.logic.speedBonus.GetBonus();
         }
         this._blazingSpeedAsset.txtReset.text = "+" + _loc1_;
         var _loc2_:int = Math.round(_loc1_ / 1000 * this._yellowFill.totalFrames);
         if(this._oldBlazePercentageYellow != _loc2_)
         {
            this._oldBlazePercentageYellow = _loc2_;
            this._yellowFill.gotoAndStop(_loc2_);
         }
         if(_loc1_ > 0)
         {
            _loc2_ = Math.round(this._gameWidget.mBlazingSpeedPct * this._yellowFill.totalFrames);
         }
         else
         {
            _loc2_ = 0;
         }
         if(this._oldBlazePercentageRed != _loc2_)
         {
            this._oldBlazePercentageRed = _loc2_;
            this._redFill.gotoAndStop(_loc2_);
         }
      }
   }
}
