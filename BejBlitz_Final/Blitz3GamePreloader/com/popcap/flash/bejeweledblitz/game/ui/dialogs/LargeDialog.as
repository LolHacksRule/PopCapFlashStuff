package com.popcap.flash.bejeweledblitz.game.ui.dialogs
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class LargeDialog extends Sprite
   {
       
      
      protected var _app:Blitz3App;
      
      private var _image:Bitmap;
      
      public function LargeDialog(param1:Blitz3App, param2:Boolean = false)
      {
         super();
         this._app = param1;
         var _loc5_:BitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_SIDE);
         var _loc6_:BitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_TOP);
         var _loc7_:BitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_BOTTOM);
         var _loc8_:BitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_TOP_GEM);
         var _loc9_:BitmapData = new BitmapData(15 + 2 * _loc5_.width + _loc6_.width,22 + _loc5_.height,true,0);
         var _loc10_:Number = _loc5_.width;
         var _loc12_:Matrix;
         (_loc12_ = new Matrix()).translate(15 + _loc10_,22 + 4 + _loc6_.height);
         var _loc13_:Shape;
         (_loc13_ = new Shape()).graphics.beginFill(0,0.6);
         _loc13_.graphics.drawRect(0,0,_loc6_.width,_loc5_.height - (4 + _loc6_.height) - _loc7_.height);
         _loc13_.graphics.endFill();
         _loc9_.draw(_loc13_,_loc12_);
         _loc12_.identity();
         _loc12_.translate(15,22);
         _loc9_.draw(_loc5_,_loc12_);
         _loc12_.identity();
         _loc12_.scale(-1,1);
         _loc12_.translate(15 + 2 * _loc5_.width + _loc6_.width,22);
         _loc9_.draw(_loc5_,_loc12_);
         _loc12_.identity();
         _loc12_.translate(15 + _loc10_,22 + 4);
         _loc9_.draw(_loc6_,_loc12_);
         _loc12_.identity();
         _loc12_.translate(15 + _loc5_.width,22 + _loc5_.height - _loc7_.height);
         _loc9_.draw(_loc7_,_loc12_);
         _loc12_.identity();
         _loc12_.translate(15,22);
         if(param2)
         {
            _loc8_ = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_TOP_COINS);
         }
         else
         {
            _loc12_.translate(0,-8);
         }
         _loc12_.translate(_loc10_ + (_loc6_.width - _loc8_.width) * 0.5,0);
         _loc9_.draw(_loc8_,_loc12_);
         this._image = new Bitmap(_loc9_);
         this._image.pixelSnapping = PixelSnapping.ALWAYS;
         addChild(this._image);
      }
   }
}
