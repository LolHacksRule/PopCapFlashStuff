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
      
      private static const COLOR_TIME:uint = 4294967040;
      
      private static const COLOR_BACKGROUND:uint = 4278190080;
      
      private static const COLOR_FPS:uint = 4294902015;
      
      private static const MAX_FPS:int = 120;
       
      
      private var mTime:int;
      
      private var mFPSText:TextField;
      
      private var mMonitor:Bitmap;
      
      private var mLastTime:int;
      
      private var mMonitorData:BitmapData;
      
      private var mFPSTmp:Number;
      
      private var mFPS:Number;
      
      private var mMilliseconds:int;
      
      public function FPSMonitor()
      {
         super();
         this.setupUI();
         this.start();
      }
      
      private function start() : void
      {
         this.mMilliseconds = getTimer();
         this.mLastTime = getTimer();
         this.mFPS = 0;
         this.mFPSTmp = 0;
         addEventListener(Event.ENTER_FRAME,this.handleFrame);
      }
      
      private function handleFrame(param1:Event) : void
      {
         if(!visible)
         {
            return;
         }
         this.mTime = getTimer() - 1000;
         if(this.mTime > this.mMilliseconds)
         {
            this.mFPS = this.mFPSTmp + this.mFPSTmp * 0.001 * (this.mTime - this.mMilliseconds);
            this.mMilliseconds = getTimer();
            this.mFPSTmp = 0;
         }
         else
         {
            ++this.mFPSTmp;
         }
         var _loc2_:int = getTimer() - this.mLastTime;
         var _loc3_:int = Math.min(HEIGHT,int(this.mFPS / MAX_FPS * HEIGHT));
         var _loc4_:int = Math.min(HEIGHT,int(_loc2_ / 100 * HEIGHT));
         this.mMonitorData.scroll(1,0);
         this.mMonitorData.setPixel32(1,HEIGHT - _loc3_,COLOR_FPS);
         this.mMonitorData.setPixel32(1,HEIGHT - _loc4_,COLOR_TIME);
         this.mFPSText.text = "FPS: " + this.mFPS;
         this.mLastTime = getTimer();
      }
      
      private function setupUI() : void
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
   }
}
