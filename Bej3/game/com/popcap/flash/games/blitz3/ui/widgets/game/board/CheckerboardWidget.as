package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.games.bej3.blitz.BlazingSpeedBonus;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class CheckerboardWidget extends Sprite
   {
       
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      private var mBitmap:Bitmap;
      
      private var mOldTrans:ColorTransform;
      
      private var mTransSwitch:Boolean = false;
      
      public function CheckerboardWidget(app:Blitz3App)
      {
         super();
         this.mBitmap = new Bitmap();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         var imgMan:ImageManager = this.mApp.imageManager;
         this.mBitmap.bitmapData = imgMan.getBitmapData(Blitz3Images.IMAGE_CHECKERBOARD);
         this.mBitmap.smoothing = true;
         this.mBitmap.alpha = 0.667;
         this.mBitmap.blendMode = BlendMode.NORMAL;
         addChild(this.mBitmap);
         this.mOldTrans = transform.colorTransform;
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.mTransSwitch = false;
         transform.colorTransform = this.mOldTrans;
      }
      
      public function Update() : void
      {
         var cTrans:ColorTransform = null;
         var percent:Number = NaN;
         var cap:Number = NaN;
         var angle:Number = NaN;
         var shift:Number = NaN;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         var timeLeft:Number = this.mApp.logic.blazingSpeedBonus.GetTimeLeft();
         if(timeLeft > 0)
         {
            this.mTransSwitch = true;
            percent = timeLeft / BlazingSpeedBonus.BONUS_TIME;
            cap = 4 * percent;
            angle = timeLeft / 50 * Math.PI;
            shift = 1 + (1 - Math.cos(angle)) / 2 * (cap + 1);
            cTrans = transform.colorTransform;
            cTrans.redMultiplier = shift;
            if(cTrans.redOffset < 128)
            {
               cTrans.redOffset += 2;
            }
            cTrans.greenMultiplier = shift * 0.5;
            if(cTrans.greenOffset < 64)
            {
               cTrans.greenOffset += 1;
            }
            transform.colorTransform = cTrans;
         }
         else if(this.mTransSwitch == true)
         {
            this.mTransSwitch = false;
            transform.colorTransform = this.mOldTrans;
         }
      }
      
      public function Draw() : void
      {
      }
   }
}
