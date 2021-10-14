package com.popcap.flash.games.blitz3.ui.sprites
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   
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
      
      public function ResizableAsset()
      {
         super();
      }
      
      public function SetSlices(slices:Vector.<Vector.<DisplayObject>>) : void
      {
         var row:Vector.<DisplayObject> = null;
         var slice:DisplayObject = null;
         var bitSlice:Bitmap = null;
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
                  if(getChildIndex(slice) >= 0)
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
         for each(row in this.m_Slices)
         {
            for each(slice in row)
            {
               addChild(slice);
               bitSlice = slice as Bitmap;
               if(bitSlice)
               {
                  bitSlice.pixelSnapping = PixelSnapping.ALWAYS;
               }
            }
         }
      }
      
      public function SetDimensions(w:Number, h:Number) : void
      {
         var col:int = 0;
         var curSlice:DisplayObject = null;
         var prevSlice:DisplayObject = null;
         this.m_TopLeft.x = 0;
         this.m_TopLeft.y = 0;
         var middleWidth:Number = Math.ceil(w);
         var middleHeight:Number = Math.ceil(h);
         for(var row:int = 0; row < 3; row++)
         {
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
                     curSlice.scaleX = middleWidth / curSlice.width;
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
                     curSlice.scaleY = middleHeight / curSlice.height;
                  }
               }
               else
               {
                  curSlice.y = 0;
               }
            }
         }
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
   }
}
