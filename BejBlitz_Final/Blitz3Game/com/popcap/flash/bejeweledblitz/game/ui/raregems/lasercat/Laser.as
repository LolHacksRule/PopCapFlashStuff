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
      
      public function Laser(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
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
         if(this.m_Timer < 0)
         {
            return;
         }
         var _loc1_:Number = 1 - this.m_Timer / this.m_AnimDuration;
         x = this.m_CurveX.getOutValue(_loc1_);
         y = this.m_CurveY.getOutValue(_loc1_);
         --this.m_Timer;
         if(this.m_Timer < 0)
         {
            visible = false;
         }
      }
      
      public function CreateAnim(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : void
      {
         visible = true;
         this.m_AnimDuration = param5;
         this.m_Timer = this.m_AnimDuration;
         var _loc6_:Number = param3 - param1;
         var _loc7_:Number = param4 - param2;
         var _loc8_:Number = Math.atan2(_loc7_,_loc6_);
         var _loc9_:Number = 0.5 * width * Math.cos(_loc8_);
         var _loc10_:Number = 0.5 * height * Math.sin(_loc8_);
         rotation = _loc8_ * (180 / Math.PI);
         this.m_CurveX = new LinearCurvedVal();
         this.m_CurveY = new LinearCurvedVal();
         this.m_CurveX.setInRange(0,1);
         this.m_CurveX.setOutRange(param1 + _loc9_,param3 - _loc9_);
         this.m_CurveY.setInRange(0,1);
         this.m_CurveY.setOutRange(param2 + _loc10_,param4 - _loc10_);
      }
   }
}
