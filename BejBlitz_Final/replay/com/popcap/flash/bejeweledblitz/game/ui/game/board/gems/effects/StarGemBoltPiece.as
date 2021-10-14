package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   
   public class StarGemBoltPiece extends Sprite
   {
       
      
      public var topBolt:Bitmap;
      
      public var bottomBolt:Bitmap;
      
      private var mLastFrame:int = 0;
      
      private var mImage:ImageInst;
      
      public function StarGemBoltPiece(img:ImageInst)
      {
         super();
         this.mImage = img;
         blendMode = BlendMode.ADD;
         this.bottomBolt = new Bitmap();
         this.bottomBolt.blendMode = BlendMode.ADD;
         this.bottomBolt.bitmapData = img.mSource.mFrames[0];
         this.bottomBolt.smoothing = true;
         this.topBolt = new Bitmap();
         this.topBolt.blendMode = BlendMode.ADD;
         this.topBolt.bitmapData = img.mSource.mFrames[0];
         this.topBolt.smoothing = true;
         addChild(this.bottomBolt);
         addChild(this.topBolt);
      }
      
      public function Change() : void
      {
         var pixels:BitmapData = null;
         var frame:int = this.mLastFrame;
         while(frame == this.mLastFrame)
         {
            frame = int(Math.random() * this.mImage.mSource.mNumFrames);
         }
         this.mLastFrame = frame;
         pixels = this.mImage.mSource.mFrames[frame];
         this.bottomBolt.bitmapData = pixels;
         this.bottomBolt.smoothing = true;
         this.topBolt.bitmapData = pixels;
         this.topBolt.smoothing = true;
      }
   }
}
