package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   
   public class AcceptButton extends ResizableButton
   {
       
      
      public function AcceptButton(param1:Blitz3App, param2:int = 14, param3:String = null, param4:String = null)
      {
         super(param1,Blitz3GameFonts.FONT_BLITZ_STANDARD,param2,param3,param4);
         var _loc5_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc6_:int = 0;
         while(_loc6_ < 3)
         {
            _loc5_[_loc6_] = new Vector.<DisplayObject>(3);
            _loc6_++;
         }
         var _loc7_:Bitmap = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GREEN_BUTTON_CAP));
         var _loc8_:BitmapData = new BitmapData(_loc7_.width,_loc7_.height,true,0);
         var _loc9_:Matrix;
         (_loc9_ = new Matrix()).scale(-1,1);
         _loc9_.translate(_loc7_.width,0);
         _loc8_.draw(_loc7_,_loc9_);
         _loc5_[0][0] = new Bitmap();
         _loc5_[0][1] = new Bitmap();
         _loc5_[0][2] = new Bitmap();
         _loc5_[1][0] = _loc7_;
         _loc5_[1][1] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GREEN_BUTTON_FILL));
         _loc5_[1][2] = new Bitmap(_loc8_);
         _loc5_[2][0] = new Bitmap();
         _loc5_[2][1] = new Bitmap();
         _loc5_[2][2] = new Bitmap();
         super.SetSlices(_loc5_);
         super.SetSounds(Blitz3GameSounds.SOUND_BUTTON_OVER,Blitz3GameSounds.SOUND_BUTTON_PRESS,Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
   }
}
