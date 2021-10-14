package com.popcap.flash.framework
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Canvas
   {
       
      
      private var mScratch:BitmapData;
      
      private var mSize:int;
      
      private var mMatrix:Matrix;
      
      private var mDepth:int;
      
      private var mState:Vector.<Matrix>;
      
      private var mCanvas:BitmapData;
      
      private var mDest:Point;
      
      private var mSrc:Rectangle;
      
      public function Canvas(param1:int, param2:int)
      {
         this.mDest = new Point();
         this.mSrc = new Rectangle();
         super();
         this.mCanvas = new BitmapData(param1,param2,true,16777215);
         this.mScratch = new BitmapData(param1,param2,true,16777215);
         this.mState = new Vector.<Matrix>();
         this.mMatrix = new Matrix();
         this.mDepth = 0;
      }
      
      public function draw(param1:ImageInst) : void
      {
         var _loc2_:BitmapData = param1.mSource.mFrames[param1.mFrame];
         var _loc3_:ColorTransform = null;
         if(param1.mIsColored)
         {
            _loc3_ = param1.mColor;
         }
         var _loc4_:String = BlendMode.NORMAL;
         if(param1.mIsAdditive)
         {
            _loc4_ = BlendMode.ADD;
         }
         var _loc5_:Matrix;
         (_loc5_ = param1.mMatrix).translate(this.mMatrix.tx,this.mMatrix.ty);
         this.mCanvas.draw(_loc2_,_loc5_,_loc3_,_loc4_,null,param1.mIsSmoothed);
         _loc5_.translate(-this.mMatrix.tx,-this.mMatrix.ty);
      }
      
      public function fillRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : void
      {
         this.mSrc.x = param1;
         this.mSrc.y = param2;
         this.mSrc.width = param3;
         this.mSrc.height = param4;
         this.mScratch.fillRect(this.mSrc,param5);
         this.mDest.x = param1 + this.mMatrix.tx;
         this.mDest.y = param2 + this.mMatrix.ty;
         this.mCanvas.copyPixels(this.mScratch,this.mSrc,this.mDest,null,null,true);
      }
      
      public function getData() : BitmapData
      {
         return this.mCanvas;
      }
      
      public function popMatrix() : void
      {
         if(this.mDepth == 0)
         {
            return;
         }
         --this.mDepth;
         this.mMatrix = this.mState[this.mDepth];
      }
      
      public function addRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:int) : void
      {
         this.mSrc.x = param1;
         this.mSrc.y = param2;
         this.mSrc.width = param3;
         this.mSrc.height = param4;
         this.mScratch.fillRect(this.mSrc,param5);
         this.mDest.x = param1 + this.mMatrix.tx;
         this.mDest.y = param2 + this.mMatrix.ty;
         this.mCanvas.draw(this.mScratch,this.mMatrix,null,BlendMode.ADD,null,false);
      }
      
      public function blit(param1:ImageInst) : void
      {
         if(param1.mIsTransformed || param1.mIsAdditive)
         {
            this.draw(param1);
            return;
         }
         var _loc2_:BitmapData = param1.mSource.mFrames[param1.mFrame];
         var _loc3_:Rectangle = param1.mSource.mSrcRect;
         if(param1.mIsColored)
         {
            this.mDest.x = 0;
            this.mDest.y = 0;
            this.mScratch.copyPixels(_loc2_,_loc3_,this.mDest);
            this.mScratch.colorTransform(_loc3_,param1.mColor);
            _loc2_ = this.mScratch;
         }
         this.mDest.x = param1.mPos.x + this.mMatrix.tx;
         this.mDest.y = param1.mPos.y + this.mMatrix.ty;
         this.mCanvas.copyPixels(_loc2_,_loc3_,this.mDest,null,null,true);
      }
      
      public function getMatrix() : Matrix
      {
         return this.mMatrix;
      }
      
      public function pushMatrix() : void
      {
         this.mState[this.mDepth] = this.mMatrix;
         var _loc1_:Matrix = this.mMatrix;
         ++this.mDepth;
         if(this.mDepth > this.mSize)
         {
            this.mMatrix = new Matrix();
            this.mSize = this.mDepth;
            this.mState[this.mDepth] = this.mMatrix;
         }
         this.mMatrix = this.mState[this.mDepth];
         this.mMatrix.identity();
         this.mMatrix.concat(_loc1_);
      }
      
      public function copy(param1:Canvas) : void
      {
         var _loc2_:BitmapData = param1.getData();
         this.mSrc.x = 0;
         this.mSrc.y = 0;
         this.mSrc.width = _loc2_.width;
         this.mSrc.height = _loc2_.height;
         this.mDest.x = this.mMatrix.tx;
         this.mDest.y = this.mMatrix.ty;
         this.mCanvas.copyPixels(_loc2_,this.mSrc,this.mDest,null,null,true);
      }
   }
}
