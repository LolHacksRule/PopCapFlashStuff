package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class LoadingWheel extends Sprite
   {
      
      public static const DEFAULT_NUM_DOTS:int = 8;
      
      public static const DEFAULT_ROTATE_TIME:int = 100;
      
      public static const WHEEL_RADIUS:Number = 10;
      
      public static const DOT_RADIUS:Number = 3;
      
      public static const COLOR_ON:int = 47087;
      
      public static const COLOR_OFF:int = 16777215;
       
      
      protected var m_NumDots:int;
      
      protected var m_CurDot:int;
      
      protected var m_DotTime:int;
      
      protected var m_DotTimer:int;
      
      protected var m_WheelRadius:Number;
      
      protected var m_DotRadius:Number;
      
      protected var m_Dots:Array;
      
      private var _autoUpdateTimer:Timer;
      
      public function LoadingWheel(param1:Number = 10, param2:Number = 3, param3:int = 8, param4:int = 100)
      {
         var _loc6_:Shape = null;
         var _loc7_:Number = NaN;
         super();
         this.m_WheelRadius = param1;
         this.m_DotRadius = param2;
         this.m_NumDots = param3;
         this.m_DotTime = param4 / this.m_NumDots;
         this.m_Dots = [];
         var _loc5_:int = 0;
         while(_loc5_ < this.m_NumDots)
         {
            _loc6_ = new Shape();
            this.DrawDotOff(_loc6_);
            _loc7_ = 2 * Math.PI * (_loc5_ / this.m_NumDots);
            _loc6_.x = this.m_WheelRadius + this.m_DotRadius + this.m_WheelRadius * Math.cos(_loc7_);
            _loc6_.y = this.m_WheelRadius + this.m_DotRadius + this.m_WheelRadius * Math.sin(_loc7_);
            this.m_Dots.push(_loc6_);
            addChild(_loc6_);
            _loc5_++;
         }
      }
      
      public function Init() : void
      {
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_CurDot = 0;
         this.m_DotTimer = this.m_DotTime;
         this.DrawDotOn(this.m_Dots[0]);
         var _loc1_:int = 1;
         while(_loc1_ < this.m_NumDots)
         {
            this.DrawDotOff(this.m_Dots[1]);
            _loc1_++;
         }
      }
      
      public function Update() : void
      {
         --this.m_DotTimer;
         if(this.m_DotTimer <= 0)
         {
            this.DrawDotOff(this.m_Dots[this.m_CurDot]);
            this.m_DotTimer = this.m_DotTime;
            ++this.m_CurDot;
            this.m_CurDot %= this.m_NumDots;
            this.DrawDotOn(this.m_Dots[this.m_CurDot]);
         }
      }
      
      public function autoRunWithOutAnUpdateLoop() : void
      {
         this._autoUpdateTimer = new Timer(10,100);
         this._autoUpdateTimer.addEventListener(TimerEvent.TIMER,this.timerHandler,false,0,true);
         this._autoUpdateTimer.start();
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         this.Update();
      }
      
      protected function DrawDotOff(param1:Shape) : void
      {
         param1.graphics.clear();
         param1.graphics.beginFill(COLOR_OFF);
         param1.graphics.drawCircle(0,0,this.m_DotRadius);
         param1.graphics.endFill();
      }
      
      protected function DrawDotOn(param1:Shape) : void
      {
         param1.graphics.clear();
         param1.graphics.beginFill(COLOR_ON);
         param1.graphics.drawCircle(0,0,this.m_DotRadius);
         param1.graphics.endFill();
      }
   }
}
