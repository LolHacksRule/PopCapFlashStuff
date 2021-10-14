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
      
      public function StarGemBoltPiece(param1:ImageInst)
      {
         super();
         this.mImage = param1;
         blendMode = BlendMode.ADD;
         this.bottomBolt = new Bitmap();
         this.bottomBolt.blendMode = BlendMode.ADD;
         this.bottomBolt.bitmapData = param1.mSource.mFrames[0];
         this.bottomBolt.smoothing = true;
         this.topBolt = new Bitmap();
         this.topBolt.blendMode = BlendMode.ADD;
         this.topBolt.bitmapData = param1.mSource.mFrames[0];
         this.topBolt.smoothing = true;
         addChild(this.bottomBolt);
         addChild(this.topBolt);
      }
      
      public function Change() : void
      {
         var _loc1_:int = this.mLastFrame;
         while(_loc1_ == this.mLastFrame)
         {
            _loc1_ = int(Math.random() * this.mImage.mSource.mNumFrames);
         }
         this.mLastFrame = _loc1_;
         var _loc2_:BitmapData = this.mImage.mSource.mFrames[_loc1_];
         this.bottomBolt.bitmapData = _loc2_;
         this.bottomBolt.smoothing = true;
         this.topBolt.bitmapData = _loc2_;
         this.topBolt.smoothing = true;
      }
   }
}
