package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   
   public class GenericButton extends ResizableButton
   {
       
      
      public function GenericButton(param1:Blitz3App, param2:int = 14, param3:String = "IMAGE_BLITZ3GAME_PINK_BUTTON_CAP", param4:String = "IMAGE_BLITZ3GAME_PINK_BUTTON_FILL")
      {
         super(param1,Blitz3GameFonts.FONT_BLITZ_STANDARD,param2);
         var _loc5_:Bitmap = new Bitmap(_app.ImageManager.getBitmapData(param3));
         var _loc6_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc7_:Matrix;
         (_loc7_ = new Matrix()).scale(-1,1);
         _loc7_.translate(_loc5_.width,0);
         _loc6_.draw(_loc5_,_loc7_);
         var _loc8_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc9_:int = 0;
         while(_loc9_ < 3)
         {
            _loc8_[_loc9_] = new Vector.<DisplayObject>(3);
            _loc9_++;
         }
         _loc8_[0][0] = new Bitmap();
         _loc8_[0][1] = new Bitmap();
         _loc8_[0][2] = new Bitmap();
         _loc8_[1][0] = _loc5_;
         _loc8_[1][1] = new Bitmap(_app.ImageManager.getBitmapData(param4));
         _loc8_[1][2] = new Bitmap(_loc6_);
         _loc8_[2][0] = new Bitmap();
         _loc8_[2][1] = new Bitmap();
         _loc8_[2][2] = new Bitmap();
         super.SetSlices(_loc8_);
         super.SetSounds(Blitz3GameSounds.SOUND_BUTTON_OVER,Blitz3GameSounds.SOUND_BUTTON_PRESS,Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
