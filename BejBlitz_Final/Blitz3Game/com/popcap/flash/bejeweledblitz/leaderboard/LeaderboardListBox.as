package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   
   public class LeaderboardListBox extends MovieClip
   {
      
      protected static const _MAX_RELOAD_SECONDS:Number = 5;
      
      protected static const _RELOAD_TIME:Number = _MAX_RELOAD_SECONDS * 1000;
      
      protected static var _scoreStartY:Number;
       
      
      protected var _app:Blitz3Game;
      
      protected var _playerData:PlayerData;
      
      protected var _isDestroyed:Boolean = false;
      
      protected var _playerBitmap:Bitmap;
      
      protected var _btnMain:GenericButtonClip;
      
      protected var _btnStats:GenericButtonClip;
      
      protected var _buttonPoke:GenericButtonClip;
      
      protected var _buttonFlag:GenericButtonClip;
      
      protected var _btnInvite:GenericButtonClip;
      
      protected var _lastReloadTime:Number = 0;
      
      protected var _allowPoke:Boolean = true;
      
      protected var _allowFlag:Boolean = true;
      
      protected var _allowUnflag:Boolean = true;
      
      public var isIngameList:Boolean = false;
      
      public function LeaderboardListBox(param1:Blitz3Game, param2:PlayerData)
      {
         super();
         this._app = param1;
         this._playerData = param2;
         this._playerBitmap = new Bitmap();
         this._playerBitmap.smoothing = true;
         this._playerBitmap.scaleX = 36 / 50;
         this._playerBitmap.scaleY = 36 / 50;
      }
      
      public function get playerData() : PlayerData
      {
         return this._playerData;
      }
      
      public function update() : void
      {
      }
      
      public function shouldForceReload() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:* = false;
         if(this._playerData.isCurrentPlayer())
         {
            _loc1_ = getTimer();
            _loc2_ = _loc1_ - this._lastReloadTime > _RELOAD_TIME;
            if(_loc2_)
            {
               this._lastReloadTime = _loc1_;
            }
            return _loc2_;
         }
         return false;
      }
      
      public function setAllowPoke(param1:Boolean) : void
      {
      }
      
      public function setAllowFlag(param1:Boolean, param2:Boolean) : void
      {
      }
   }
}
