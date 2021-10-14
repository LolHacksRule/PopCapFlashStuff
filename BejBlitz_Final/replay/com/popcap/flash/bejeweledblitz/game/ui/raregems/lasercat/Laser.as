package com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.misc.LinearCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Laser extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Image:Bitmap;
      
      protected var m_CurveX:LinearCurvedVal;
      
      protected var m_CurveY:LinearCurvedVal;
      
      protected var m_Timer:int;
      
      protected var m_AnimDuration:int;
      
      public function Laser(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Image = new Bitmap();
      }
      
      public function Init() : void
      {
         this.m_Image.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER);
         this.m_Image.x = -width * 0.5;
         this.m_Image.y = -height * 0.5;
         addChild(this.m_Image);
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
         this.m_Timer = -1;
      }
      
      public function Update() : void
      {
         var curvePos:Number = NaN;
         if(this.m_Timer < 0)
         {
            return;
         }
         curvePos = 1 - this.m_Timer / this.m_AnimDuration;
         x = this.m_CurveX.getOutValue(curvePos);
         y = this.m_CurveY.getOutValue(curvePos);
         --this.m_Timer;
         if(this.m_Timer < 0)
         {
            visible = false;
         }
      }
      
      public function CreateAnim(srcX:Number, srcY:Number, dstX:Number, dstY:Number, animTime:int) : void
      {
         visible = true;
         this.m_AnimDuration = animTime;
         this.m_Timer = this.m_AnimDuration;
         var dX:Number = dstX - srcX;
         var dY:Number = dstY - srcY;
         var angle:Number = Math.atan2(dY,dX);
         var offsetX:Number = 0.5 * width * Math.cos(angle);
         var offsetY:Number = 0.5 * height * Math.sin(angle);
         rotation = angle * (180 / Math.PI);
         this.m_CurveX = new LinearCurvedVal();
         this.m_CurveY = new LinearCurvedVal();
         this.m_CurveX.setInRange(0,1);
         this.m_CurveX.setOutRange(srcX + offsetX,dstX - offsetX);
         this.m_CurveY.setInRange(0,1);
         this.m_CurveY.setOutRange(srcY + offsetY,dstY - offsetY);
      }
   }
}
