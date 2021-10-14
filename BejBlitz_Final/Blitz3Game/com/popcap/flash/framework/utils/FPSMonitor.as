package com.popcap.flash.framework.utils
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
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
      
      private static const WIDTH:int = 120;
      
      private static const HEIGHT:int = 90;
      
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
      
      private var mFPSAverage:int = 0;
      
      private var _gameFPSAvgNumerator:int = 0;
      
      private var _gameFPSAvgDenominator:int = 0;
      
      private var m_LastTargetFrameRate:int;
      
      private var m_UpdateTimer:Timer;
      
      private var _useDynamicFPS:Boolean = false;
      
      public var monitorGamePlayFPS:Boolean = true;
      
      var mDocumentFPS:int;
      
      var mSamples:Vector.<Number>;
      
      var mSampleSize:int;
      
      public function FPSMonitor()
      {
         this.mRollingFPS = [];
         this.mRollingCPU = [];
         this.m_LastTargetFrameRate = App.frameRateMax;
         this.mDocumentFPS = App.frameRateInit;
         this.mSamples = new Vector.<Number>();
         this.mSampleSize = App.frameRateInit;
         super();
         this.SetupUI();
      }
      
      public function ResetStats() : void
      {
         this.mFPSAvgNumerator = 0;
         this.mFPSAvgDenominator = 0;
         this.mFPSAverage = 0;
         this.mFPSHigh = int.MIN_VALUE;
         this.mFPSLow = int.MAX_VALUE;
         this._gameFPSAvgNumerator = 0;
         this._gameFPSAvgDenominator = 0;
      }
      
      public function Start() : void
      {
         this.mFPSLimit = App.frameRateMax;
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
         this.mDocumentFPS = App.frameRateInit;
         var _loc1_:int = 0;
         while(_loc1_ < this.mSampleSize)
         {
            this.mSamples.push(0);
            _loc1_++;
         }
         this.ResetStats();
      }
      
      public function GetAverageFPS() : int
      {
         return this.mFPSAverage;
      }
      
      public function GetAverageGameplayFPS() : int
      {
         this.monitorGamePlayFPS = false;
         return Number(this._gameFPSAvgNumerator / this._gameFPSAvgDenominator);
      }
      
      public function GetFPSHigh() : int
      {
         return this.mFPSHigh;
      }
      
      public function GetFPSLow() : int
      {
         return this.mFPSLow;
      }
      
      public function setDynamicFPS(param1:Boolean) : void
      {
         this._useDynamicFPS = param1;
         if(this._useDynamicFPS)
         {
            this.ResetStats();
         }
      }
      
      private function SetupUI() : void
      {
         this.mMonitorData = new BitmapData(WIDTH,HEIGHT,true,COLOR_BACKGROUND);
         this.mMonitor = new Bitmap(this.mMonitorData);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.color = 4294967295;
         _loc1_.font = "Verdana";
         _loc1_.size = 10;
         _loc1_.bold = true;
         this.mFPSText = new TextField();
         this.mFPSText.defaultTextFormat = _loc1_;
         this.mFPSText.autoSize = "left";
         this.mFPSText.selectable = false;
         addChild(this.mMonitor);
         addChild(this.mFPSText);
      }
      
      private function ScaleAndClamp(param1:Number, param2:Number) : int
      {
         var _loc3_:int = Math.min(param2,Math.max(0,param1));
         _loc3_ = _loc3_ / param2 * HEIGHT;
         return HEIGHT - _loc3_;
      }
      
      public function HandleUpdate(param1:TimerEvent) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:Number = (_loc2_ - this.mLastTime) / 1000;
         this.mLastTime = _loc2_;
         var _loc4_:Number = 1 / _loc3_;
         this.mSamples[this.mFrameCount % 30] = _loc4_;
         ++this.mFrameCount;
         var _loc5_:Number = 0;
         this.mFPSLow = this.mSamples[0];
         var _loc6_:int = 0;
         while(_loc6_ < this.mSampleSize)
         {
            _loc5_ += this.mSamples[_loc6_];
            this.mFPSLow = Math.min(this.mFPSLow,this.mSamples[_loc6_]);
            _loc6_++;
         }
         _loc5_ /= this.mSampleSize;
         this.mFPSAverage = Math.round(_loc5_);
         var _loc7_:int = _loc5_ / this.mDocumentFPS * 100;
         var _loc8_:int = 100 - _loc7_;
         var _loc9_:String = "";
         if(Blitz3App.app != null && Blitz3App.app.logic != null && Blitz3App.app.logic.config != null)
         {
            _loc9_ = Blitz3App.app.logic.config.blitzLogicBaseSpeed.toString();
         }
         this.mFPSText.text = Math.round(_loc5_) + " fps\n" + this.mDocumentFPS + " target fps\n" + _loc7_ + "% performance\n" + _loc8_ + "% lag\n" + "GameSpeed " + _loc9_;
      }
   }
}
