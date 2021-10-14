package com.popcap.flash.framework.resources.fonts
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class FontCharData
   {
       
      
      public var offset:Point;
      
      public var kerningOffsets:Dictionary;
      
      public var width:int = 0;
      
      public var image:BitmapData;
      
      public var order:int = 0;
      
      public function FontCharData()
      {
         super();
         this.offset = new Point();
         this.kerningOffsets = new Dictionary();
      }
   }
}
