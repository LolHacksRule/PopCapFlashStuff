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
      
      public function SetSlices(slices:Vector.<Vector.<DisplayObject>>) : void
      {
         var row:Vector.<DisplayObject> = null;
         var slice:DisplayObject = null;
         if(!slices || slices.length < 3 || slices[0].length < 3)
         {
            trace("ResizableButton slice error");
            return;
         }
         if(this.m_Slices)
         {
            for each(row in this.m_Slices)
            {
               for each(slice in row)
               {
                  if(contains(slice))
                  {
                     removeChild(slice);
                  }
               }
            }
         }
         this.m_Slices = slices;
         this.m_TopLeft = slices[0][0];
         this.m_TopMiddle = slices[0][1];
         this.m_TopRight = slices[0][2];
         this.m_CenterLeft = slices[1][0];
         this.m_CenterMiddle = slices[1][1];
         this.m_CenterRight = slices[1][2];
         this.m_BottomLeft = slices[2][0];
         this.m_BottomMiddle = slices[2][1];
         this.m_BottomRight = slices[2][2];
      }
      
      public function SetDimensions(w:Number, h:Number) : void
      {
         var row:int = 0;
         var col:int = 0;
         var curSlice:DisplayObject = null;
         var prevSlice:DisplayObject = null;
         var curMatrix:Matrix = null;
         this.m_TopLeft.x = 0;
         this.m_TopLeft.y = 0;
         var middleWidth:Number = Math.ceil(w);
         var middleHeight:Number = Math.ceil(h);
         this.m_Data = new BitmapData(middleWidth + this.m_CenterLeft.width + this.m_CenterRight.width,middleHeight + this.m_TopMiddle.height + this.m_BottomMiddle.height,true,16777215);
         var matrices:Vector.<Vector.<Matrix>> = new Vector.<Vector.<Matrix>>(3);
         for(row = 0; row < 3; row++)
         {
            matrices[row] = new Vector.<Matrix>();
            for(col = 0; col < 3; col++)
            {
               curSlice = this.m_Slices[row][col];
               if(col > 0)
               {
                  prevSlice = this.m_Slices[row][col - 1];
                  curSlice.x = Math.ceil(prevSlice.x + Math.ceil(prevSlice.width));
                  if(col == 1)
                  {
                     curSlice.scaleX = 1;
                     if(curSlice.width > 0)
                     {
                        curSlice.scaleX = middleWidth / curSlice.width;
                     }
                  }
               }
               else
               {
                  curSlice.x = 0;
               }
               if(row > 0)
               {
                  prevSlice = this.m_Slices[row - 1][col];
                  curSlice.y = Math.ceil(prevSlice.y + Math.ceil(prevSlice.height));
                  if(row == 1)
                  {
                     curSlice.scaleY = 1;
                     if(curSlice.height > 0)
                     {
                        curSlice.scaleY = middleHeight / curSlice.height;
                     }
                  }
               }
               else
               {
                  curSlice.y = 0;
               }
               curMatrix = new Matrix();
               matrices[row][col] = curMatrix;
               curMatrix.tx = curSlice.x;
               curMatrix.ty = curSlice.y;
               curMatrix.a = curSlice.scaleX;
               curMatrix.d = curSlice.scaleY;
               this.m_Data.draw(curSlice,curMatrix);
            }
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
      
      public function GetSliceWidth(row:int, col:int) : Number
      {
         if(row < 0 || row > 2 || col < 0 || col > 2)
         {
            return -1;
         }
         return this.m_Slices[row][col].width;
      }
      
      public function GetSliceHeight(row:int, col:int) : Number
      {
         if(row < 0 || row > 2 || col < 0 || col > 2)
         {
            return -1;
         }
         return this.m_Slices[row][col].height;
      }
   }
}
