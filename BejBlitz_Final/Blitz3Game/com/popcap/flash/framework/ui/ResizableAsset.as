package com.popcap.flash.framework.ui
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class ResizableAsset extends Sprite
   {
       
      
      protected var m_Slices:Vector.<Vector.<DisplayObject>>;
      
      protected var m_TopLeft:DisplayObject;
      
      protected var m_TopMiddle:DisplayObject;
      
      protected var m_TopRight:DisplayObject;
      
      protected var m_CenterLeft:DisplayObject;
      
      protected var m_CenterMiddle:DisplayObject;
      
      protected var m_CenterRight:DisplayObject;
      
      protected var m_BottomLeft:DisplayObject;
      
      protected var m_BottomMiddle:DisplayObject;
      
      protected var m_BottomRight:DisplayObject;
      
      private var m_Data:BitmapData;
      
      private var m_Image:Bitmap;
      
      public function ResizableAsset()
      {
         super();
         this.m_Image = new Bitmap();
         addChild(this.m_Image);
      }
      
      public function SetSlices(param1:Vector.<Vector.<DisplayObject>>) : void
      {
         var _loc2_:Vector.<DisplayObject> = null;
         var _loc3_:DisplayObject = null;
         if(!param1 || param1.length < 3 || param1[0].length < 3)
         {
            trace("ResizableButton slice error");
            return;
         }
         if(this.m_Slices)
         {
            for each(_loc2_ in this.m_Slices)
            {
               for each(_loc3_ in _loc2_)
               {
                  if(contains(_loc3_))
                  {
                     removeChild(_loc3_);
                  }
               }
            }
         }
         this.m_Slices = param1;
         this.m_TopLeft = param1[0][0];
         this.m_TopMiddle = param1[0][1];
         this.m_TopRight = param1[0][2];
         this.m_CenterLeft = param1[1][0];
         this.m_CenterMiddle = param1[1][1];
         this.m_CenterRight = param1[1][2];
         this.m_BottomLeft = param1[2][0];
         this.m_BottomMiddle = param1[2][1];
         this.m_BottomRight = param1[2][2];
      }
      
      public function SetDimensions(param1:Number, param2:Number) : void
      {
         var _loc7_:int = 0;
         var _loc8_:DisplayObject = null;
         var _loc9_:DisplayObject = null;
         var _loc10_:Matrix = null;
         this.m_TopLeft.x = 0;
         this.m_TopLeft.y = 0;
         var _loc3_:Number = Math.ceil(param1);
         var _loc4_:Number = Math.ceil(param2);
         this.m_Data = new BitmapData(_loc3_ + this.m_CenterLeft.width + this.m_CenterRight.width,_loc4_ + this.m_TopMiddle.height + this.m_BottomMiddle.height,true,16777215);
         var _loc5_:Vector.<Vector.<Matrix>> = new Vector.<Vector.<Matrix>>(3);
         var _loc6_:int = 0;
         while(_loc6_ < 3)
         {
            _loc5_[_loc6_] = new Vector.<Matrix>();
            _loc7_ = 0;
            while(_loc7_ < 3)
            {
               _loc8_ = this.m_Slices[_loc6_][_loc7_];
               if(_loc7_ > 0)
               {
                  _loc9_ = this.m_Slices[_loc6_][_loc7_ - 1];
                  _loc8_.x = Math.ceil(_loc9_.x + Math.ceil(_loc9_.width));
                  if(_loc7_ == 1)
                  {
                     _loc8_.scaleX = 1;
                     if(_loc8_.width > 0)
                     {
                        _loc8_.scaleX = _loc3_ / _loc8_.width;
                     }
                  }
               }
               else
               {
                  _loc8_.x = 0;
               }
               if(_loc6_ > 0)
               {
                  _loc9_ = this.m_Slices[_loc6_ - 1][_loc7_];
                  _loc8_.y = Math.ceil(_loc9_.y + Math.ceil(_loc9_.height));
                  if(_loc6_ == 1)
                  {
                     _loc8_.scaleY = 1;
                     if(_loc8_.height > 0)
                     {
                        _loc8_.scaleY = _loc4_ / _loc8_.height;
                     }
                  }
               }
               else
               {
                  _loc8_.y = 0;
               }
               _loc10_ = new Matrix();
               _loc5_[_loc6_][_loc7_] = _loc10_;
               _loc10_.tx = _loc8_.x;
               _loc10_.ty = _loc8_.y;
               _loc10_.a = _loc8_.scaleX;
               _loc10_.d = _loc8_.scaleY;
               this.m_Data.draw(_loc8_,_loc10_);
               _loc7_++;
            }
            _loc6_++;
         }
         this.m_Image.bitmapData = this.m_Data;
         this.m_Image.smoothing = true;
      }
      
      public function GetTopBorderHeight() : Number
      {
         return this.m_Slices[0][1].height;
      }
      
      public function GetBottomBorderHeight() : Number
      {
         return this.m_Slices[2][1].height;
      }
      
      public function GetLeftBorderWidth() : Number
      {
         return this.m_Slices[1][0].width;
      }
      
      public function GetRightBorderWidth() : Number
      {
         return this.m_Slices[1][2].width;
      }
      
      public function GetSliceWidth(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 > 2 || param2 < 0 || param2 > 2)
         {
            return -1;
         }
         return this.m_Slices[param1][param2].width;
      }
      
      public function GetSliceHeight(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 > 2 || param2 < 0 || param2 > 2)
         {
            return -1;
         }
         return this.m_Slices[param1][param2].height;
      }
   }
}
