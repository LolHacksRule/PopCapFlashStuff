package com.popcap.flash.bejeweledblitz.leaderboard
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class FriendBeatenTauntDialog extends Sprite
   {
       
      
      private var _app:Blitz3Game;
      
      private var _playerBitmap:Bitmap;
      
      private var _opponentBitmap:Bitmap;
      
      private var _shareCallbackFunction:Function;
      
      private var _closeCallbackFunction:Function;
      
      public function FriendBeatenTauntDialog(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._shareCallbackFunction = new Function();
         this._closeCallbackFunction = new Function();
      }
      
      public function shareButtonHandler(param1:Function) : void
      {
         this._shareCallbackFunction = param1;
      }
      
      public function closeButtonHandler(param1:Function) : void
      {
         this._closeCallbackFunction = param1;
      }
      
      public function setContent(param1:PlayerData, param2:Array) : void
      {
         this._playerBitmap = new Bitmap();
         var _loc3_:int = param1.curTourneyData.score;
         var _loc4_:PlayerData = param2[0].playerData;
         var _loc5_:int = param2[0].score;
         this._opponentBitmap = new Bitmap();
         try
         {
            param1.copyBitmapDataTo(this._playerBitmap);
            _loc4_.copyBitmapDataTo(this._opponentBitmap);
         }
         catch(e:Error)
         {
         }
      }
   }
}
