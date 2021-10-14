package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   
   public class JackpotCoin extends Bitmap
   {
       
      
      private var v:Number;
      
      private var h:Number;
      
      private var rX:Number;
      
      private var rY:Number;
      
      public function JackpotCoin(app:Blitz3App)
      {
         super();
         bitmapData = app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN);
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
         x = 0;
         y = 0;
         rotationX = 0;
         rotationY = 0;
         this.h = Math.random() * 6 - 3;
         this.v = Math.random() * -6 - 3;
         this.rX = Math.random() * 4 - 2;
         this.rY = Math.random() * 4 - 2;
      }
      
      public function Update() : void
      {
         if(y < -600 || y > 600)
         {
            return;
         }
         visible = true;
         x += this.h;
         y += this.v;
         this.v += 0.2;
         rotationX += this.rX;
         rotationY += this.rY;
      }
   }
}
