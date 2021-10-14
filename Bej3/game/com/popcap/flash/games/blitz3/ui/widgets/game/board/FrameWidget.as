package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.games.bej3.blitz.ScoreEvent;
   import com.popcap.flash.games.blitz3.Blitz3App;
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
       
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
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
      
      private var mCurrentPercent:Number = 0;
      
      public function FrameWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.mFillMatrix = new Matrix();
      }
      
      public function Init() : void
      {
         this.mApp.logic.scoreKeeper.addEventListener(ScoreEvent.ID,this.HandleScoreEvent);
         var imgMan:ImageManager = this.mApp.imageManager;
         this.mTopFrame = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_TOP));
         this.mBottomFrameBack = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_BACK));
         this.mBottomFrameFront = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_FRONT));
         this.mBottomFrameFlash = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_FLASH));
         this.mBottomFrameBack.x = 6;
         this.mBottomFrameBack.y = 4;
         this.mBottomFrameFill = new Sprite();
         this.mFillTexture = imgMan.getBitmapData(Blitz3Images.IMAGE_UI_FRAME_BOTTOM_FILL);
         this.mBottomFrameFill.x = 27;
         this.mBottomFrameFill.y = 4;
         this.mBottomFrame = new Sprite();
         this.mBottomFrame.addChild(this.mBottomFrameBack);
         this.mBottomFrame.addChild(this.mBottomFrameFill);
         this.mBottomFrame.addChild(this.mBottomFrameFront);
         this.mTopFrame.x = -6;
         this.mTopFrame.y = -8;
         this.mBottomFrame.x = -10;
         this.mBottomFrame.y = 318;
         addChild(this.mTopFrame);
         addChild(this.mBottomFrame);
         this.Reset();
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.mCurrentPercent = 0;
         this.mBottomFrameFlash.visible = false;
         this.mTimeLeft = this.mApp.logic.timerLogic.GetGameDuration();
         this.DrawFill(0);
      }
      
      public function Update() : void
      {
         this.mTimeLeft = this.mApp.logic.timerLogic.GetTimeRemaining();
      }
      
      public function Draw() : void
      {
         var percent:Number = this.mApp.logic.GetBasePointsForLevel() / this.mApp.logic.GetLevelPointGoal();
         var delta:Number = (percent - this.mCurrentPercent) * 0.08;
         if(delta < 0.001)
         {
         }
         if(percent > this.mCurrentPercent)
         {
            this.mCurrentPercent += delta;
            if(this.mCurrentPercent > 1)
            {
               this.mCurrentPercent = 1;
            }
            this.DrawFill(this.mCurrentPercent);
         }
      }
      
      private function DrawFill(percent:Number) : void
      {
         this.mBottomFrameFill.graphics.clear();
         this.mBottomFrameFill.graphics.beginBitmapFill(this.mFillTexture,this.mFillMatrix,true,false);
         this.mBottomFrameFill.graphics.drawRect(0,0,this.mFillTexture.width * percent,this.mBottomFrameBack.height);
         this.mBottomFrameFill.graphics.endFill();
      }
      
      private function HandleScoreEvent(e:ScoreEvent) : void
      {
      }
   }
}
