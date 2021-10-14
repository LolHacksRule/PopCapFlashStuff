package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageResource;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class RareGemTokenSprite extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      public var isSpinning:Boolean = false;
      
      public var value:int = 0;
      
      private var mTimer:int = 0;
      
      private var mRareGemTokenAnimation:ImageInst;
      
      private var mRareGemTokenImage:BitmapData;
      
      private var mAnimationBitmap:Bitmap;
      
      public function RareGemTokenSprite(param1:Blitz3App, param2:int)
      {
         super();
         this.m_App = param1;
         this.value = param2;
         this.mRareGemTokenImage = DynamicRGInterface.getImage(param1.logic.rareGemsLogic.currentRareGem.getStringID(),"Spritesheet").bitmapData;
         this.mAnimationBitmap = new Bitmap(this.mRareGemTokenImage);
         this.mRareGemTokenAnimation = new ImageInst();
         this.renderTokenSpriteOnGem(this.mRareGemTokenImage,this.mRareGemTokenAnimation);
         this.mRareGemTokenAnimation.mFrame = 0;
         this.mAnimationBitmap.bitmapData = this.mRareGemTokenAnimation.pixels;
         this.mAnimationBitmap.x = -(this.mAnimationBitmap.width * 0.5);
         this.mAnimationBitmap.y = -(this.mAnimationBitmap.height * 0.5);
         addChild(this.mAnimationBitmap);
      }
      
      public function Reset() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         this.isSpinning = false;
      }
      
      public function Update() : void
      {
         var _loc1_:int = this.mRareGemTokenAnimation.mSource.mNumFrames;
         var _loc3_:Number = this.mTimer * 0.01;
         var _loc4_:int = _loc3_ * 24 % _loc1_;
         this.mRareGemTokenAnimation.mFrame = _loc4_;
         this.mAnimationBitmap.bitmapData = this.mRareGemTokenAnimation.pixels;
         ++this.mTimer;
      }
      
      private function renderTokenSpriteOnGem(param1:BitmapData, param2:ImageInst) : void
      {
         var _loc8_:uint = 0;
         var _loc9_:BitmapData = null;
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Bitmap = new Bitmap(param1);
         _loc3_.addChild(_loc4_);
         var _loc5_:Matrix = new Matrix();
         var _loc6_:Vector.<BitmapData> = new Vector.<BitmapData>();
         var _loc7_:uint = 0;
         while(_loc7_ < 4)
         {
            _loc8_ = 0;
            while(_loc8_ < 5)
            {
               _loc5_.tx = -_loc8_ * 40;
               _loc5_.ty = -_loc7_ * 40;
               (_loc9_ = new BitmapData(40,40,true,0)).draw(_loc3_,_loc5_);
               _loc6_.push(_loc9_);
               _loc8_++;
            }
            _loc7_++;
         }
         this.FillImageInst(param2,_loc6_);
      }
      
      private function FillImageInst(param1:ImageInst, param2:Vector.<BitmapData>) : void
      {
         param1.mSource = new ImageResource();
         param1.mSource.mFrames = param2;
         param1.mSource.mNumFrames = param2.length;
      }
   }
}
