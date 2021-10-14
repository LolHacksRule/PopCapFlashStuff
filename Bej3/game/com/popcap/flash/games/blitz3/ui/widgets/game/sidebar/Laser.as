package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.framework.misc.LinearCurvedVal;
   import com.popcap.flash.games.blitz3.ui.widgets.game.raregems.catseye.CatLaser;
   
   public class Laser extends CatLaser
   {
       
      
      protected var m_CurveX:LinearCurvedVal;
      
      protected var m_CurveY:LinearCurvedVal;
      
      protected var m_Timer:int;
      
      protected var m_AnimDuration:int;
      
      public function Laser()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
         this.m_Timer = -1;
      }
      
      public function Update() : void
      {
         if(this.m_Timer < 0)
         {
            return;
         }
         var curvePos:Number = 1 - this.m_Timer / this.m_AnimDuration;
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
