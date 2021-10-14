package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class GenericButtonFramed extends ResizableButton
   {
       
      
      public function GenericButtonFramed(param1:Blitz3App, param2:int = 14, param3:String = null, param4:String = null)
      {
         super(param1,Blitz3GameFonts.FONT_BLITZ_STANDARD,param2,param3,param4);
         var _loc5_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc6_:int = 0;
         while(_loc6_ < 3)
         {
            _loc5_[_loc6_] = new Vector.<DisplayObject>(3);
            _loc6_++;
         }
         _loc5_[0][0] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_00));
         _loc5_[0][1] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_01));
         _loc5_[0][2] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_02));
         _loc5_[1][0] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_10));
         _loc5_[1][1] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_11));
         _loc5_[1][2] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_12));
         _loc5_[2][0] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_20));
         _loc5_[2][1] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_21));
         _loc5_[2][2] = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BUTTON_22));
         super.SetSlices(_loc5_);
         super.SetSounds(Blitz3GameSounds.SOUND_BUTTON_OVER,Blitz3GameSounds.SOUND_BUTTON_PRESS,Blitz3GameSounds.SOUND_BUTTON_RELEASE);
      }
      
      override public function SetText(param1:String, param2:Number = 0, param3:int = -1, param4:Array = null) : void
      {
         super.SetText(param1,param2,param3,param4);
         _txtLabel.y += 2;
      }
   }
}
