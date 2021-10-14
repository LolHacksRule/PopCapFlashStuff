package com.popcap.flash.bejeweledblitz.dailyspin.misc
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class LayoutHelpers
   {
       
      
      public function LayoutHelpers()
      {
         super();
      }
      
      public static function CenterHorizontal(src:DisplayObject, target:DisplayObject, offset:Number = 0) : void
      {
         src.x = target.x + 0.5 * (target.width - src.width) + offset;
      }
      
      public static function CenterVertical(src:DisplayObject, target:DisplayObject, offset:Number = 0) : void
      {
         src.y = target.y + 0.5 * (target.height - src.height) + offset;
      }
      
      public static function Center(src:DisplayObject, target:DisplayObject, offsetX:Number = 0, offsetY:Number = 0) : void
      {
         CenterHorizontal(src,target,offsetX);
         CenterVertical(src,target,offsetY);
      }
      
      public static function CenterXY(src:DisplayObject, xPos:Number, yPos:Number) : void
      {
         src.x = xPos - src.width * 0.5;
         src.y = yPos - src.height * 0.5;
      }
      
      public static function FitToBounds(src:DisplayObject, bounds:DisplayObject) : void
      {
         var aspect:Number = NaN;
         var scaleWidth:Number = src.width < bounds.width ? Number(src.width / bounds.width) : Number(bounds.width / src.width);
         var scaleHeight:Number = src.height < bounds.height ? Number(src.height / bounds.height) : Number(bounds.height / src.height);
         if(src.width > src.height)
         {
            aspect = src.height / src.width;
            src.scaleX *= scaleWidth;
            src.scaleY *= scaleHeight * aspect;
         }
         else
         {
            aspect = src.width / src.height;
            src.scaleX *= aspect;
            src.scaleX *= scaleWidth;
            src.scaleY *= scaleHeight;
         }
      }
      
      public static function layoutHorizontal(items:Array, boundsWidth:Number) : void
      {
         var padding:Number = NaN;
         var startY:Number = NaN;
         var item:DisplayObject = null;
         padding = getPadding(items,boundsWidth);
         var startItem:DisplayObject = items[0] as DisplayObject;
         var startX:Number = startItem.x;
         startY = startItem.y;
         for each(item in items)
         {
            item.x = startX;
            item.y = startY;
            startX += item.width + padding;
         }
      }
      
      public static function layoutVertical(items:Array, boundsWidth:Number, initPoint:Point = null) : void
      {
         var padding:Number = NaN;
         var item:DisplayObject = null;
         padding = getPadding(items,boundsWidth);
         var startItem:DisplayObject = items[0] as DisplayObject;
         var startX:Number = Boolean(initPoint) ? Number(initPoint.x) : Number(startItem.x);
         var startY:Number = Boolean(initPoint) ? Number(initPoint.y) : Number(startItem.y);
         for each(item in items)
         {
            item.x = startX;
            item.y = startY;
            startY += item.width + padding;
         }
      }
      
      public static function layoutHorizontalByEdge(objs:Array, spacing:Number = 0) : void
      {
         var obj:DisplayObject = null;
         var strideX:Number = 0;
         var strideY:Number = (objs[0] as DisplayObject).y;
         for each(obj in objs)
         {
            obj.x = strideX;
            obj.y = strideY;
            strideX += obj.width + spacing;
         }
      }
      
      private static function getPadding(items:Array, boundsWidth:Number) : Number
      {
         var item:DisplayObject = null;
         var totalWidth:Number = 0;
         for each(item in items)
         {
            totalWidth += item.width;
         }
         return (boundsWidth - totalWidth) / (items.length - 1);
      }
   }
}
