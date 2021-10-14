package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedVal;
   import com.popcap.flash.games.bej3.blitz.ComplimentEvent;
   import com.popcap.flash.games.bej3.blitz.IBlazingSpeedLogicHandler;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class ComplimentWidget extends Sprite implements IBlazingSpeedLogicHandler
   {
      
      public static const ANIM_TIME:int = 150;
      
      public static const QUEUE_DELAY:int = 150;
      
      public static const LEVEL_BLAZING_SPEED:int = 6;
      
      public static const NUM_LEVELS:int = 7;
       
      
      private var mApp:Blitz3App;
      
      private var mCompliment:Sprite;
      
      private var mComplimentImage:Bitmap;
      
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
         this.mApp = app;
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
         this.mComplimentImage = new Bitmap();
         this.mCompliment = new Sprite();
         this.mCompliment.addChild(this.mComplimentImage);
         this.mApp.logic.compliments.addEventListener(ComplimentEvent.ON_COMPLIMENT,this.HandleCompliment);
         this.mApp.logic.blazingSpeedBonus.AddHandler(this);
         this.mImageData = new Vector.<BitmapData>(NUM_LEVELS,true);
         this.mImageData[0] = this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_GOOD);
         this.mImageData[1] = this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_EXCELLENT);
         this.mImageData[2] = this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_AWESOME);
         this.mImageData[3] = this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_SPECTACULAR);
         this.mImageData[4] = this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_EXTRAORDINARY);
         this.mImageData[5] = this.mApp.imageManager.getBitmapData(Blitz3Images.IMAGE_TEXT_UNBELIEVABLE);
         this.mQueue = null;
         this.mPlaying = new Array();
         addChild(this.mCompliment);
      }
      
      public function Reset() : void
      {
         this.mQueue = null;
         this.mPlaying.length = 0;
         this.mQueueTimer = QUEUE_DELAY;
         this.mCompliment.alpha = 0;
      }
      
      public function Update() : void
      {
         var probe:Object = null;
         var time:int = 0;
         var percent:Number = NaN;
         var alpha:Number = NaN;
         var scale:Number = NaN;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         for each(probe in this.mPlaying)
         {
            if(probe != null)
            {
               if(probe.timer > 0)
               {
                  --probe.timer;
                  time = probe.timer;
                  percent = 1 - time / ANIM_TIME;
                  alpha = this.mAlphaCurve.getOutValue(1 - percent);
                  scale = this.mScaleCurve.getOutValue(percent);
                  this.mComplimentImage.bitmapData = this.mImageData[probe.level];
                  this.mComplimentImage.x = -(this.mComplimentImage.width / 2);
                  this.mComplimentImage.y = -(this.mComplimentImage.height / 2);
                  this.mCompliment.scaleX = scale;
                  this.mCompliment.scaleY = scale;
                  this.mCompliment.alpha = alpha;
               }
            }
         }
         --this.mQueueTimer;
         if(this.mQueueTimer <= 0 && this.mQueue != null)
         {
            this.mQueueTimer = QUEUE_DELAY;
            this.mPlaying.push(this.mQueue);
            this.mApp.soundManager.playSound(this.mQueue.sound);
            this.mQueue = null;
         }
      }
      
      public function Draw() : void
      {
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
         var soundId:String = Blitz3Sounds.SOUND_VOICE_BLAZING_SPEED;
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
      
      private function HandleCompliment(e:ComplimentEvent) : void
      {
         if(this.mApp.logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         var soundId:String = "SOUND_VOICE_COMPLIMENT_" + e.level;
         this.mQueue = {
            "timer":ANIM_TIME,
            "level":e.level,
            "sound":soundId
         };
      }
   }
}
