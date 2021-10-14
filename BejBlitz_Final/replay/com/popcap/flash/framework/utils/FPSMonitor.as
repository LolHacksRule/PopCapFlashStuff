package com.popcap.flash.framework.utils
{
   import com.popcap.flash.framework.App;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class FPSMonitor extends Sprite
   {
      
      private static const WIDTH:int = 100;
      
      private static const HEIGHT:int = 100;
      
      private static const COLOR_BACKGROUND:uint = 4278190080;
      
      private static const COLOR_FPS_MARK:uint = 4294902015;
      
      private static const COLOR_FPS_ROLLING:uint = 4294901760;
      
      private static const COLOR_CPU_MARK:uint = 4278223103;
      
      private static const COLOR_CPU_ROLLING:uint = 4278255360;
      
      private static const COLOR_RATE_CHANGE:uint = 4294967040;
      
      private static const FRAME_RATE_UP_THRESHOLD:int = 3;
      
      private static const FRAME_RATE_DOWN_THRESHOLD:int = -10;
       
      
      private var mFPSText:TextField;
      
      private var mMonitor:Bitmap;
      
      private var mMonitorData:BitmapData;
      
      private var mFPS:Number;
      
      private var mFrameCount:Number;
      
      private var mLastTime:int;
      
      private var mTimer:int;
      
      private var mAccumulator:int;
      
      private var mEffectiveFPS:Number;
      
      private var mFPSLimit:int = 0;
      
      private var mTimeLimit:int = 0;
      
      private var mRollingFPS:Array;
      
      private var mRollingCPU:Array;
      
      private var mRollingIndex:int;
      
      private var mFPSAvgNumerator:int = 0;
      
      private var mFPSAvgDenominator:int = 0;
      
      private var mFPSHigh:int = 0;
      
      private var mFPSLow:int = 0;
      
      private var m_LastTargetFrameRate:int = 60;
      
      private var m_UpdateTimer:Timer;
      
      public function FPSMonitor()
      {
         this.mRollingFPS = [];
         this.mRollingCPU = [];
         super();
         this.SetupUI();
      }
      
      public function ResetStats() : void
      {
         this.mFPSAvgNumerator = 0;
         this.mFPSAvgDenominator = 0;
         this.mFPSHigh = int.MIN_VALUE;
         this.mFPSLow = int.MAX_VALUE;
      }
      
      public function Start() : void
      {
         this.mFPSLimit = App.FRAME_RATE_MAX;
         this.mTimeLimit = 1000 / this.mFPSLimit;
         this.mRollingFPS.length = 0;
         this.mRollingCPU.length = 0;
         this.mRollingIndex = 0;
         this.mLastTime = getTimer();
         this.mTimer = 0;
         this.mAccumulator = 0;
         this.mEffectiveFPS = 0;
         this.mFPS = 0;
         this.mFrameCount = 0;
         this.ResetStats();
         this.m_UpdateTimer = new Timer(10);
         this.m_UpdateTimer.addEventListener(TimerEvent.TIMER,this.HandleUpdate);
         this.m_UpdateTimer.start();
      }
      
      public function GetAverageFPS() : int
      {
         return this.mFPSAvgNumerator / this.mFPSAvgDenominator;
      }
      
      public function GetFPSHigh() : int
      {
         return this.mFPSHigh;
      }
      
      public function GetFPSLow() : int
      {
         return this.mFPSLow;
      }
      
      private function SetupUI() : void
      {
         this.mMonitorData = new BitmapData(WIDTH,HEIGHT,true,COLOR_BACKGROUND);
         this.mMonitor = new Bitmap(this.mMonitorData);
         var format:TextFormat = new TextFormat();
         format.color = 4294967295;
         format.font = "Verdana";
         format.size = 10;
         format.bold = true;
         this.mFPSText = new TextField();
         this.mFPSText.defaultTextFormat = format;
         this.mFPSText.autoSize = "left";
         this.mFPSText.selectable = false;
         addChild(this.mMonitor);
         addChild(this.mFPSText);
      }
      
      private function ScaleAndClamp(value:Number, cap:Number) : int
      {
         var result:int = Math.min(cap,Math.max(0,value));
         result = result / cap * HEIGHT;
         return HEIGHT - result;
      }
      
      private function HandleUpdate(event:TimerEvent) : void
      {
         var currentFrameRate:Number = NaN;
         var targetFrameRate:int = 0;
         var thisTime:int = getTimer();
         var elapsed:int = thisTime - this.mLastTime;
         this.mLastTime = thisTime;
         var shiftType:int = 0;
         this.mAccumulator += elapsed;
         this.mAccumulator -= int(this.mRollingFPS[this.mRollingIndex]);
         this.mRollingFPS[this.mRollingIndex] = elapsed;
         var effectiveFPS:Number = this.mRollingFPS.length * (1000 / this.mAccumulator);
         var effectiveCPU:Number = this.mAccumulator / this.mRollingFPS.length;
         this.mRollingIndex = (this.mRollingIndex + 1) % this.mFPSLimit;
         ++this.mFrameCount;
         this.mTimer += elapsed;
         if(this.mTimer >= 1000)
         {
            this.mFPSAvgNumerator += this.mFrameCount;
            this.mFPSAvgDenominator += 1;
            this.mFPSHigh = Math.max(this.mFrameCount,this.mFPSHigh);
            this.mFPSLow = Math.min(this.mFrameCount,this.mFPSLow);
            this.mFPS = this.mFrameCount;
            this.mEffectiveFPS = this.mFrameCount / (this.mTimer * 0.001);
            currentFrameRate = stage.frameRate;
            targetFrameRate = Math.floor(Math.min(Math.max(this.mEffectiveFPS,App.FRAME_RATE_MIN),App.FRAME_RATE_MAX));
            if(currentFrameRate <= targetFrameRate && this.m_LastTargetFrameRate == targetFrameRate && currentFrameRate < App.FRAME_RATE_INIT)
            {
               targetFrameRate = App.FRAME_RATE_INIT;
               stage.frameRate = targetFrameRate;
               shiftType = 1;
            }
            else if(targetFrameRate - currentFrameRate >= FRAME_RATE_UP_THRESHOLD && this.m_LastTargetFrameRate - currentFrameRate >= FRAME_RATE_UP_THRESHOLD)
            {
               stage.frameRate = targetFrameRate;
               shiftType = 1;
            }
            else if(targetFrameRate - currentFrameRate <= FRAME_RATE_DOWN_THRESHOLD && this.m_LastTargetFrameRate - currentFrameRate <= FRAME_RATE_DOWN_THRESHOLD)
            {
               stage.frameRate = targetFrameRate;
               shiftType = 2;
            }
            this.m_LastTargetFrameRate = targetFrameRate;
            this.mFrameCount = 0;
            this.mTimer = 0;
         }
         if(visible)
         {
            this.mMonitorData.scroll(1,0);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(this.mFPS,this.mFPSLimit),COLOR_FPS_MARK);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(elapsed,this.mTimeLimit << 3),COLOR_CPU_MARK);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(effectiveFPS,this.mFPSLimit),COLOR_FPS_ROLLING);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(effectiveCPU,this.mTimeLimit << 3),COLOR_CPU_ROLLING);
            if(shiftType == 1)
            {
               this.mMonitorData.setPixel32(2,50,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,49,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,48,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,47,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,46,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(1,47,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(3,47,COLOR_RATE_CHANGE);
            }
            else if(shiftType == 2)
            {
               this.mMonitorData.setPixel32(2,50,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,51,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,52,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,53,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(2,54,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(1,53,COLOR_RATE_CHANGE);
               this.mMonitorData.setPixel32(3,53,COLOR_RATE_CHANGE);
            }
            this.mFPSText.text = "FPS:" + this.mEffectiveFPS.toPrecision(2) + "  FR:" + stage.frameRate.toPrecision(2);
         }
      }
   }
}
