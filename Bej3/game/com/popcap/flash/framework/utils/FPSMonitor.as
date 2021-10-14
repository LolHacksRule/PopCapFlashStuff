package com.popcap.flash.framework.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
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
       
      
      private var mFPSText:TextField;
      
      private var mMonitor:Bitmap;
      
      private var mMonitorData:BitmapData;
      
      private var mFPS:Number;
      
      private var mFPSCount:Number;
      
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
         this.mFPSLimit = Math.min(120,stage.frameRate);
         this.mTimeLimit = 1000 / this.mFPSLimit;
         this.mRollingFPS.length = 0;
         this.mRollingCPU.length = 0;
         this.mRollingIndex = 0;
         this.mLastTime = getTimer();
         this.mTimer = 0;
         this.mAccumulator = 0;
         this.mEffectiveFPS = 0;
         this.mFPS = 0;
         this.mFPSCount = 0;
         this.ResetStats();
         addEventListener(Event.ENTER_FRAME,this.HandleFrame);
      }
      
      public function Stop() : void
      {
         if(hasEventListener(Event.ENTER_FRAME))
         {
            removeEventListener(Event.ENTER_FRAME,this.HandleFrame);
         }
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
      
      private function HandleFrame(e:Event) : void
      {
         var thisTime:int = getTimer();
         var elapsed:int = thisTime - this.mLastTime;
         this.mAccumulator += elapsed;
         this.mAccumulator -= int(this.mRollingFPS[this.mRollingIndex]);
         this.mRollingFPS[this.mRollingIndex] = elapsed;
         var effectiveFPS:Number = this.mRollingFPS.length * (1000 / this.mAccumulator);
         var effectiveCPU:Number = this.mAccumulator / this.mRollingFPS.length;
         this.mRollingIndex = (this.mRollingIndex + 1) % this.mFPSLimit;
         ++this.mFPSCount;
         this.mTimer += elapsed;
         while(this.mTimer >= 1000)
         {
            this.mFPSAvgNumerator += this.mFPSCount;
            this.mFPSAvgDenominator += 1;
            this.mFPSHigh = Math.max(this.mFPSCount,this.mFPSHigh);
            this.mFPSLow = Math.min(this.mFPSCount,this.mFPSLow);
            this.mFPS = this.mFPSCount;
            this.mFPSCount = 0;
            this.mTimer -= 1000;
            this.mEffectiveFPS = this.mFPS;
         }
         if(visible)
         {
            this.mMonitorData.scroll(1,0);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(this.mFPS,this.mFPSLimit),COLOR_FPS_MARK);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(elapsed,this.mTimeLimit << 3),COLOR_CPU_MARK);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(effectiveFPS,this.mFPSLimit),COLOR_FPS_ROLLING);
            this.mMonitorData.setPixel32(1,this.ScaleAndClamp(effectiveCPU,this.mTimeLimit << 3),COLOR_CPU_ROLLING);
            this.mFPSText.text = "FPS: " + this.mFPS;
         }
         this.mLastTime = getTimer();
      }
   }
}
