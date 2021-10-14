package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class FrameWidget extends Sprite
   {
      
      private static const WARNING_DELAY_MAX:int = 100;
      
      private static const WARNING_DELAY_MIN:int = 60;
      
      private static const START_WARNING_TIME:int = 1500;
      
      private static const STOP_WARNING_TIME:int = 0;
       
      
      private var m_App:Blitz3App;
      
      private var mTimeLeft:int = 0;
      
      private var mWarningTimer:int = 100;
      
      private var mWarningDelay:int = 0;
      
      private var mTopFrame:Bitmap;
      
      private var mBottomFrame:Sprite;
      
      private var mBottomFrameBack:Bitmap;
      
      private var mBottomFrameFront:Bitmap;
      
      private var mBottomFrameFlash:Bitmap;
      
      private var mBottomFrameFill:Sprite;
      
      private var mFillTexture:BitmapData;
      
      private var mFillMatrix:Matrix;
      
      public function FrameWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         var imgMan:BaseImageManager = null;
         imgMan = this.m_App.ImageManager;
         this.mTopFrame = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_TOP));
         this.mBottomFrameBack = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_BACK));
         this.mBottomFrameFront = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_FRONT));
         this.mBottomFrameFlash = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_FLASH));
         this.mBottomFrameBack.x = 6;
         this.mBottomFrameBack.y = 4;
         this.mBottomFrameFill = new Sprite();
         this.mFillTexture = imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_FILL);
         this.mBottomFrameFill.x = 6;
         this.mBottomFrameFill.y = 4;
         this.mBottomFrame = new Sprite();
         this.mBottomFrame.addChild(this.mBottomFrameBack);
         this.mBottomFrame.addChild(this.mBottomFrameFill);
         this.mBottomFrame.addChild(this.mBottomFrameFront);
         this.mBottomFrame.addChild(this.mBottomFrameFlash);
         this.mTopFrame.x = -10;
         this.mTopFrame.y = -8;
         this.mBottomFrame.x = -10;
         this.mBottomFrame.y = 318;
         addChild(this.mTopFrame);
         addChild(this.mBottomFrame);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.mBottomFrameFlash.visible = false;
         this.mTimeLeft = this.m_App.logic.timerLogic.GetGameDuration();
         this.DrawFill(1);
      }
      
      public function Update() : void
      {
         var percent:Number = NaN;
         this.mTimeLeft = this.m_App.logic.timerLogic.GetTimeRemaining();
         if(this.mTimeLeft <= START_WARNING_TIME && this.mTimeLeft > STOP_WARNING_TIME)
         {
            --this.mWarningTimer;
         }
         else
         {
            this.mWarningDelay = WARNING_DELAY_MAX;
            this.mWarningTimer = this.mWarningDelay;
         }
         if(this.mWarningTimer <= 0)
         {
            percent = this.mTimeLeft / START_WARNING_TIME;
            this.mWarningDelay = (WARNING_DELAY_MAX - WARNING_DELAY_MIN) * percent + WARNING_DELAY_MIN;
            this.mWarningTimer = this.mWarningDelay;
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_WARNING);
         }
      }
      
      public function Draw() : void
      {
         var angle:Number = NaN;
         var alpha:Number = NaN;
         var percent:Number = this.mTimeLeft / this.m_App.logic.timerLogic.GetGameDuration();
         this.DrawFill(percent);
         percent = this.mWarningTimer / this.mWarningDelay;
         angle = percent * Math.PI;
         if(this.mTimeLeft <= 1400 && this.mTimeLeft > 0)
         {
            this.mBottomFrameFlash.visible = true;
            alpha = 1 - Math.abs(Math.cos(angle));
            this.mBottomFrameFlash.alpha = alpha;
         }
         else
         {
            this.mBottomFrameFlash.visible = false;
         }
      }
      
      private function DrawFill(percent:Number) : void
      {
         this.mBottomFrameFill.graphics.clear();
         this.mBottomFrameFill.graphics.beginBitmapFill(this.mFillTexture);
         this.mBottomFrameFill.graphics.drawRect(0,0,this.mBottomFrameBack.width * percent,this.mBottomFrameBack.height);
         this.mBottomFrameFill.graphics.endFill();
      }
   }
}
