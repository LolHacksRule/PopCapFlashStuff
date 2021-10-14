package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class BroadcastWidget extends Bitmap
   {
      
      public static const ANIM_TIME:int = 175;
       
      
      private var m_App:Blitz3App;
      
      private var mGoImage:BitmapData;
      
      private var mTimeUpImage:BitmapData;
      
      private var mTimer:int = 0;
      
      private var mAnimCurve:CustomCurvedVal;
      
      public function BroadcastWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         cacheAsBitmap = true;
      }
      
      public function Init() : void
      {
         this.mAnimCurve = new CustomCurvedVal();
         this.mAnimCurve.setInRange(0,1);
         this.mAnimCurve.setOutRange(0,1);
         this.mAnimCurve.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(35 / ANIM_TIME,1,0),new CurvedValPoint(135 / ANIM_TIME,1,0),new CurvedValPoint(1,0,0));
         this.mTimer = 0;
         this.mGoImage = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_GO);
         this.mTimeUpImage = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_TIME_UP);
         smoothing = true;
      }
      
      public function Reset() : void
      {
         visible = false;
      }
      
      public function Update() : void
      {
         var time:Number = NaN;
         var value:Number = NaN;
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         if(this.mTimer > 0)
         {
            --this.mTimer;
            time = (ANIM_TIME - this.mTimer) / ANIM_TIME;
            value = this.mAnimCurve.getOutValue(time);
            scaleX = value;
            scaleY = value;
            alpha = value;
            x = 160 + width * -0.5;
            y = 160 + height * -0.5;
            if(this.mTimer == 0)
            {
               visible = false;
            }
         }
      }
      
      public function PlayGo() : void
      {
         bitmapData = this.mGoImage;
         visible = true;
         this.mTimer = ANIM_TIME;
      }
      
      public function PlayTimeUp() : void
      {
         bitmapData = this.mTimeUpImage;
         visible = true;
         this.mTimer = ANIM_TIME;
      }
   }
}
