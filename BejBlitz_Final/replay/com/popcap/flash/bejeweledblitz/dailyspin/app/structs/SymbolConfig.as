package com.popcap.flash.bejeweledblitz.dailyspin.app.structs
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.SlotItem;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.events.EventDispatcher;
   
   public class SymbolConfig extends EventDispatcher
   {
      
      private static const SYMBOL_MAX_WIDTH:Number = 104;
      
      private static const SYMBOL_MAX_HEIGHT:Number = 104;
       
      
      public var id:String;
      
      public var src:String;
      
      private var m_bitmap:BitmapData;
      
      public function SymbolConfig(id:String, bitmap:Bitmap)
      {
         super();
         this.id = id;
         if(bitmap)
         {
            bitmap.pixelSnapping = PixelSnapping.ALWAYS;
            bitmap.smoothing = true;
            this.m_bitmap = bitmap.bitmapData;
         }
      }
      
      public function get clip() : SlotItem
      {
         return new SlotItem(this,this.src,this.m_bitmap);
      }
      
      public function get bitmap() : BitmapData
      {
         return this.m_bitmap;
      }
      
      override public function toString() : String
      {
         return "SymbolConfig: " + this.id + " (" + this.src + ")";
      }
   }
}
