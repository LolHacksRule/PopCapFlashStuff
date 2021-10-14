package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Shape;
   import flash.display.Sprite;
   
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
      
      public function LoadingWheel(wheelRadius:Number = 10, dotRadius:Number = 3, numDots:int = 8, rotateTime:int = 100)
      {
         var tmp:Shape = null;
         var angle:Number = NaN;
         super();
         this.m_WheelRadius = wheelRadius;
         this.m_DotRadius = dotRadius;
         this.m_NumDots = numDots;
         this.m_DotTime = rotateTime / this.m_NumDots;
         this.m_Dots = [];
         for(var i:int = 0; i < this.m_NumDots; i++)
         {
            tmp = new Shape();
            this.DrawDotOff(tmp);
            angle = 2 * Math.PI * (i / this.m_NumDots);
            tmp.x = this.m_WheelRadius + this.m_DotRadius + this.m_WheelRadius * Math.cos(angle);
            tmp.y = this.m_WheelRadius + this.m_DotRadius + this.m_WheelRadius * Math.sin(angle);
            this.m_Dots.push(tmp);
            addChild(tmp);
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
         for(var i:int = 1; i < this.m_NumDots; i++)
         {
            this.DrawDotOff(this.m_Dots[1]);
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
      
      protected function DrawDotOff(shape:Shape) : void
      {
         shape.graphics.clear();
         shape.graphics.beginFill(COLOR_OFF);
         shape.graphics.drawCircle(0,0,this.m_DotRadius);
         shape.graphics.endFill();
      }
      
      protected function DrawDotOn(shape:Shape) : void
      {
         shape.graphics.clear();
         shape.graphics.beginFill(COLOR_ON);
         shape.graphics.drawCircle(0,0,this.m_DotRadius);
         shape.graphics.endFill();
      }
   }
}
