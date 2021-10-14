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
      
      public function GameFrame(param1:App)
      {
         super();
         this.topLeft = new Bitmap(param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.topRight = new Bitmap(param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.topRight.rotation = 90;
         this.bottomLeft = new Bitmap(param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.bottomLeft.rotation = -90;
         this.bottomRight = new Bitmap(param1.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_GAME_CORNER));
         this.bottomRight.rotation = 180;
         addChild(this.topLeft);
         addChild(this.topRight);
         addChild(this.bottomLeft);
         addChild(this.bottomRight);
      }
      
      public function Init(param1:Number, param2:Number) : void
      {
         this.topRight.x = param1;
         this.bottomLeft.y = param2;
         this.bottomRight.x = param1;
         this.bottomRight.y = param2;
      }
   }
}
