package com.popcap.flash.framework.resources.images
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class §_-SF§
   {
       
      
      public var §_-EM§:int = 1;
      
      public var §_-YX§:Class = null;
      
      public var §_-K9§:int = 1;
      
      public var §_-R5§:Class = null;
      
      private var §_-Ar§:§_-c-§ = null;
      
      public function §_-SF§(param1:Class, param2:Class, param3:int, param4:int)
      {
         super();
         this.§_-R5§ = param1;
         this.§_-YX§ = param2;
         this.§_-EM§ = param3;
         this.§_-K9§ = param4;
      }
      
      private function §_-OU§() : BitmapData
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         if(this.§_-R5§ != null)
         {
            _loc2_ = (new this.§_-R5§() as Bitmap).bitmapData;
         }
         if(this.§_-YX§ != null)
         {
            _loc3_ = (new this.§_-YX§() as Bitmap).bitmapData;
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
      
      public function §_-C§() : §_-c-§
      {
         if(this.§_-Ar§ != null)
         {
            return this.§_-Ar§;
         }
         this.§_-Ar§ = new §_-c-§();
         this.§_-Ar§.§_-EM§ = this.§_-EM§;
         this.§_-Ar§.§_-K9§ = this.§_-K9§;
         this.§_-Ar§.§_-Jk§ = this.§_-EM§ * this.§_-K9§;
         this.§_-Ar§.§_-2s§ = this.§_-Cv§(this.§_-OU§());
         this.§_-Ar§.§_-g4§.width = this.§_-Ar§.§_-2s§[0].width;
         this.§_-Ar§.§_-g4§.height = this.§_-Ar§.§_-2s§[0].height;
         return this.§_-Ar§;
      }
      
      private function §_-Cv§(param1:BitmapData) : Vector.<BitmapData>
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:BitmapData = null;
         var _loc12_:Rectangle = null;
         var _loc2_:Number = param1.width / this.§_-K9§;
         var _loc3_:Number = param1.height / this.§_-EM§;
         var _loc4_:Rectangle = new Rectangle(0,0,_loc2_,_loc3_);
         var _loc5_:Point = new Point(0,0);
         var _loc6_:Vector.<BitmapData> = new Vector.<BitmapData>();
         var _loc7_:int = this.§_-EM§ * this.§_-K9§;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = int(_loc8_ / this.§_-K9§);
            _loc10_ = _loc8_ % this.§_-K9§;
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
