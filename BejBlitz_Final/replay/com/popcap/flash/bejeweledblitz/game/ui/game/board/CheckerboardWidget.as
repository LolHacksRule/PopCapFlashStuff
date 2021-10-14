package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.BlazingSpeedLogic;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   
   public class CheckerboardWidget extends Bitmap
   {
       
      
      private var m_App:Blitz3App;
      
      private var mOldTrans:ColorTransform;
      
      private var mTransSwitch:Boolean = false;
      
      public function CheckerboardWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         cacheAsBitmap = true;
      }
      
      public function Init() : void
      {
         var imgMan:BaseImageManager = this.m_App.ImageManager;
         bitmapData = imgMan.getBitmapData(Blitz3GameImages.IMAGE_CHECKERBOARD);
         alpha = 0.667;
         this.mOldTrans = transform.colorTransform;
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
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         var timeLeft:Number = this.m_App.logic.blazingSpeedLogic.GetTimeLeft();
         if(timeLeft > 0)
         {
            this.mTransSwitch = true;
            percent = timeLeft / BlazingSpeedLogic.BONUS_TIME;
            cap = 4 * percent;
            angle = timeLeft / 50 * Math.PI;
            shift = 1 + (1 - Math.cos(angle)) * 0.5 * (cap + 1);
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
   }
}
