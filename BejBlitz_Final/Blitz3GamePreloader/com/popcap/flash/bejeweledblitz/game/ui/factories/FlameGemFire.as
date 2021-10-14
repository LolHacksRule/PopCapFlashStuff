package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import flash.display.Shape;
   import flash.geom.ColorTransform;
   
   public class FlameGemFire extends Shape
   {
       
      
      private var m_IsTop:Boolean = false;
      
      private var m_xPos:Number = 0;
      
      private var m_yPos:Number = 0;
      
      private var m_xDir:Number = 0;
      
      private var m_yDir:Number = 0;
      
      private var m_ScaleFactor:Number;
      
      private var m_FrameCount:int;
      
      public function FlameGemFire(param1:Number, param2:Number, param3:Boolean)
      {
         super();
         this.m_xPos = param1 + 0.5;
         this.m_yPos = param2;
         this.m_IsTop = param3;
         var _loc4_:int = Math.abs(this.m_xPos - 20);
         if(this.m_IsTop)
         {
            graphics.beginFill(16777215,1);
            graphics.drawEllipse(-1,0,2,6);
            this.m_ScaleFactor = Math.random() * 0.02;
            this.m_xDir = (Math.random() - 0.5) * 0.05;
            this.m_yDir = Math.random() * (20 - _loc4_) * 0.03;
         }
         else
         {
            graphics.beginFill(16777215,1);
            graphics.drawEllipse(-1,-1.5,2,3);
            this.m_ScaleFactor = Math.random() * 0.05;
            this.m_xDir = (this.m_xPos - 20) * 0.005;
            this.m_yDir = Math.abs(this.m_xDir) + Math.random() * (20 - _loc4_) * 0.01;
         }
         var _loc5_:ColorTransform;
         (_loc5_ = transform.colorTransform).greenMultiplier = 0.75 + Math.random() * 0.25;
         _loc5_.blueMultiplier = 0.15 + Math.random() * 0.25;
         transform.colorTransform = _loc5_;
         this.Init();
         var _loc6_:int = Math.floor(Math.random() * 60);
         while(_loc6_-- > 0)
         {
            this.Update();
         }
      }
      
      public function Init() : void
      {
         x = this.m_xPos;
         y = this.m_yPos;
         if(this.m_IsTop)
         {
            y -= Math.abs(this.m_xPos - 20) * 0.25;
         }
         scaleX = 1;
         this.m_FrameCount = FlameGemFactory.FRAME_COUNT;
      }
      
      public function Update() : void
      {
         x += this.m_xDir + Math.sin(y / this.m_yDir) * 0.2;
         y -= this.m_yDir;
         if(this.m_IsTop)
         {
            scaleX -= this.m_ScaleFactor;
         }
         else
         {
            scaleX -= this.m_ScaleFactor;
         }
         if(this.m_FrameCount-- == 0)
         {
            this.Init();
         }
      }
   }
}
