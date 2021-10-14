package com.popcap.flash.bejeweledblitz.game.ui.factories
{
   import flash.display.Shape;
   import flash.geom.ColorTransform;
   
   public class FlameBordersFire extends Shape
   {
       
      
      private var m_xPos:Number = 0;
      
      private var m_yPos:Number = 0;
      
      private var m_xDir:Number = 0;
      
      private var m_yDir:Number = 0;
      
      private var m_ScaleFactor:Number;
      
      private var m_FrameCount:int;
      
      public function FlameBordersFire(param1:Number, param2:Number, param3:Boolean)
      {
         super();
         this.m_xPos = param1 + 0.5;
         this.m_yPos = param2;
         graphics.beginFill(16777215,1);
         graphics.drawEllipse(-1,-4,2,8);
         var _loc4_:int = Math.abs(this.m_xPos - 170);
         this.m_ScaleFactor = Math.random() * 0.01;
         var _loc5_:ColorTransform = transform.colorTransform;
         if(param3)
         {
            this.m_xDir = (Math.random() - 0.5) * 0.05;
            this.m_yDir = 0.5 + Math.random() * 0.55 - _loc4_ * 0.004;
            _loc5_.greenMultiplier = 0.6 + Math.random() * 0.4;
            _loc5_.blueMultiplier = 0.15 + Math.random() * 0.25;
         }
         else
         {
            this.m_xDir = (Math.random() - 0.5) * 0.05;
            this.m_yDir = 0.5 + Math.random() * 0.5;
            _loc5_.greenMultiplier = 0.4 + Math.random() * 0.6;
            _loc5_.blueMultiplier = 0.15 + Math.random() * 0.25;
         }
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
         scaleX = 1;
         this.m_FrameCount = FlameGemFactory.FRAME_COUNT;
      }
      
      public function Update() : void
      {
         x += this.m_xDir + Math.sin(y / this.m_yDir) * 0.1;
         y -= this.m_yDir;
         scaleX -= this.m_ScaleFactor;
         if(this.m_FrameCount-- == 0)
         {
            this.Init();
         }
      }
   }
}
