package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IComplimentLogicHandler;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class ComplimentWidget extends Bitmap implements IBlazingSpeedLogicHandler, IComplimentLogicHandler
   {
      
      public static const ANIM_TIME:int = 150;
      
      public static const QUEUE_DELAY:int = 150;
      
      public static const LEVEL_BLAZING_SPEED:int = 6;
      
      public static const NUM_LEVELS:int = 7;
       
      
      private var m_App:Blitz3App;
      
      private var mTimer:int = 0;
      
      private var mImageData:Vector.<BitmapData>;
      
      private var mAlphaCurve:CustomCurvedVal;
      
      private var mScaleCurve:CustomCurvedVal;
      
      private var mQueue:Object;
      
      private var mQueueTimer:int = 0;
      
      private var mPlaying:Array;
      
      public function ComplimentWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         cacheAsBitmap = true;
      }
      
      public function Init() : void
      {
         this.mAlphaCurve = new CustomCurvedVal();
         this.mAlphaCurve.setInRange(0,1);
         this.mAlphaCurve.setOutRange(0,1);
         this.mAlphaCurve.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(0.5,1,0),new CurvedValPoint(1,0,0));
         this.mScaleCurve = new CustomCurvedVal();
         this.mScaleCurve.setInRange(0,1);
         this.mScaleCurve.setOutRange(0,1);
         this.mScaleCurve.setCurve(true,new CurvedValPoint(0,0,0),new CurvedValPoint(1,1,0));
         this.mTimer = 0;
         this.m_App.logic.compliments.AddHandler(this);
         this.m_App.logic.blazingSpeedLogic.AddHandler(this);
         this.mImageData = new Vector.<BitmapData>(NUM_LEVELS,true);
         this.mImageData[0] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_GOOD);
         this.mImageData[1] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_EXCELLENT);
         this.mImageData[2] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_AWESOME);
         this.mImageData[3] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_SPECTACULAR);
         this.mImageData[4] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_EXTRAORDINARY);
         this.mImageData[5] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_UNBELIEVABLE);
         this.mImageData[6] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TEXT_BLAZING_SPEED);
         this.mQueue = null;
         this.mPlaying = new Array();
         smoothing = true;
      }
      
      public function Reset() : void
      {
         this.mQueue = null;
         this.mPlaying.length = 0;
         this.mQueueTimer = QUEUE_DELAY;
         alpha = 0;
      }
      
      public function Update() : void
      {
         var probe:Object = null;
         var time:int = 0;
         var percent:Number = NaN;
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         for each(probe in this.mPlaying)
         {
            if(probe != null)
            {
               if(probe.timer > 0)
               {
                  bitmapData = this.mImageData[probe.level];
                  x = 160 + width * -0.5;
                  y = 160 + height * -0.5;
                  --probe.timer;
                  time = probe.timer;
                  percent = 1 - time / ANIM_TIME;
                  alpha = this.mAlphaCurve.getOutValue(1 - percent);
                  scaleX = scaleY = this.mScaleCurve.getOutValue(percent);
               }
            }
         }
         --this.mQueueTimer;
         if(this.mQueueTimer <= 0 && this.mQueue != null)
         {
            this.mQueueTimer = QUEUE_DELAY;
            this.mPlaying.push(this.mQueue);
            this.m_App.SoundManager.playSound(this.mQueue.sound);
            this.mQueue = null;
         }
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
         var soundId:String = Blitz3GameSounds.SOUND_VOICE_BLAZING_SPEED;
         this.mQueueTimer = 0;
         this.mQueue = {
            "timer":ANIM_TIME,
            "level":LEVEL_BLAZING_SPEED,
            "sound":soundId
         };
      }
      
      public function HandleBlazingSpeedReset() : void
      {
      }
      
      public function HandleBlazingSpeedPercentChanged(newPercent:Number) : void
      {
      }
      
      public function HandleCompliment(level:int) : void
      {
         if(this.m_App.logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         var soundId:String = "SOUND_BLITZ3GAME_VOICE_COMPLIMENT_" + level;
         this.mQueue = {
            "timer":ANIM_TIME,
            "level":level,
            "sound":soundId
         };
      }
   }
}
