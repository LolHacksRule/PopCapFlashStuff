package com.popcap.flash.bejeweledblitz.game.ui.game
{
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class GameFrame extends Sprite
   {
       
      
      public var topLeft:Bitmap;
      
      public var topRight:Bitmap;
      
      public var bottomLeft:Bitmap;
      
      public var bottomRight:Bitmap;
      
      public function GameFrame(app:App)
      {
         super();
         this.topLeft = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.topRight = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.topRight.rotation = 90;
         this.bottomLeft = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.bottomLeft.rotation = -90;
         this.bottomRight = new Bitmap(app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.bottomRight.rotation = 180;
         addChild(this.topLeft);
         addChild(this.topRight);
         addChild(this.bottomLeft);
         addChild(this.bottomRight);
      }
      
      public function Init(w:Number, h:Number) : void
      {
         this.topLeft.x = 0;
         this.topLeft.y = 0;
         this.topRight.x = w;
         this.topRight.y = 0;
         this.bottomLeft.x = 0;
         this.bottomLeft.y = h;
         this.bottomRight.x = w;
         this.bottomRight.y = h;
      }
   }
}
