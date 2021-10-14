package com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class LaserCatEye extends Sprite
   {
      
      protected static const DROT:Number = 2 * (360 * 0.01);
       
      
      protected var m_App:Blitz3App;
      
      protected var m_ImgBack:Bitmap;
      
      protected var m_BackContainer:Sprite;
      
      protected var m_ImgFront:Bitmap;
      
      public function LaserCatEye(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_ImgBack = new Bitmap();
         this.m_BackContainer = new Sprite();
         this.m_ImgFront = new Bitmap();
      }
      
      public function Init() : void
      {
         this.m_ImgBack.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_EYE_BACK);
         this.m_ImgFront.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_EYE_FRONT);
         this.m_ImgBack.x = -this.m_ImgBack.width * 0.5;
         this.m_ImgBack.y = -this.m_ImgBack.height * 0.5;
         this.m_ImgFront.x = -this.m_ImgFront.width * 0.5;
         this.m_ImgFront.y = -this.m_ImgFront.height * 0.5;
         this.m_BackContainer.addChild(this.m_ImgBack);
         addChild(this.m_BackContainer);
         addChild(this.m_ImgFront);
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         this.m_BackContainer.rotation += DROT;
      }
   }
}
