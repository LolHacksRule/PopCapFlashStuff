package com.popcap.flash.framework.resources.images
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ImageDescriptor
   {
       
      
      public var mRGBClass:Class = null;
      
      public var mAlphaClass:Class = null;
      
      public var mRows:int = 1;
      
      public var mCols:int = 1;
      
      private var mResource:ImageResource = null;
      
      public function ImageDescriptor(param1:Class, param2:Class, param3:int, param4:int)
      {
         super();
         this.mRGBClass = param1;
         this.mAlphaClass = param2;
         this.mRows = param3;
         this.mCols = param4;
      }
      
      public function getResource() : ImageResource
      {
         if(this.mResource != null)
         {
            return this.mResource;
         }
         this.mResource = new ImageResource();
         this.mResource.mRows = this.mRows;
         this.mResource.mCols = this.mCols;
         this.mResource.mNumFrames = this.mRows * this.mCols;
         this.mResource.mFrames = this.sliceFrames(this.mergeData());
         this.mResource.mSrcRect.width = this.mResource.mFrames[0].width;
         this.mResource.mSrcRect.height = this.mResource.mFrames[0].height;
         return this.mResource;
      }
      
      private function mergeData() : BitmapData
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         if(this.mRGBClass != null)
         {
            _loc2_ = (new this.mRGBClass() as Bitmap).bitmapData;
         }
         if(this.mAlphaClass != null)
         {
            _loc3_ = (new this.mAlphaClass() as Bitmap).bitmapData;
         }
         if(_loc2_ != null)
         {
            _loc1_ = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         }
         else if(_loc3_ != null)
         {
            _loc1_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         }
         if(_loc1_ == null)
         {
            throw new Error("Image is empty.");
         }
         var _loc4_:Rectangle;
         (_loc4_ = new Rectangle()).width = _loc1_.width;
         _loc4_.height = _loc1_.height;
         var _loc5_:Point = new Point();
         if(_loc2_ != null)
         {
            _loc1_.copyPixels(_loc2_,_loc4_,_loc5_);
         }
         if(_loc3_ != null)
         {
            if(_loc2_ == null)
            {
               _loc1_.copyPixels(_loc3_,_loc4_,_loc5_);
            }
            _loc1_.copyChannel(_loc3_,_loc4_,_loc5_,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
         }
         return _loc1_;
      }
      
      private function sliceFrames(param1:BitmapData) : Vector.<BitmapData>
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:BitmapData = null;
         var _loc12_:Rectangle = null;
         var _loc2_:Number = param1.width / this.mCols;
         var _loc3_:Number = param1.height / this.mRows;
         var _loc4_:Rectangle = new Rectangle(0,0,_loc2_,_loc3_);
         var _loc5_:Point = new Point(0,0);
         var _loc6_:Vector.<BitmapData> = new Vector.<BitmapData>();
         var _loc7_:int = this.mRows * this.mCols;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = int(_loc8_ / this.mCols);
            _loc10_ = _loc8_ % this.mCols;
            _loc11_ = new BitmapData(_loc2_,_loc3_);
            _loc12_ = new Rectangle(_loc10_ * _loc2_,_loc9_ * _loc3_,_loc2_,_loc3_);
            _loc11_.copyPixels(param1,_loc12_,_loc5_);
            _loc6_[_loc8_] = _loc11_;
            _loc8_++;
         }
         param1.dispose();
         return _loc6_;
      }
   }
}
