package com.popcap.flash.bejeweledblitz.dailyspin.app.structs
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class SymbolData
   {
       
      
      private var m_Id:String;
      
      private var m_Bitmap:Bitmap;
      
      public function SymbolData(id:String, image:Sprite)
      {
         super();
         this.m_Id = id;
         if(!image)
         {
            return;
         }
         var bmd:BitmapData = new BitmapData(image.width,image.height,true,0);
         bmd.draw(image,null,null,null,null,true);
         this.m_Bitmap = new Bitmap(bmd);
      }
      
      public function get id() : String
      {
         return this.m_Id;
      }
      
      public function get bitmapData() : Bitmap
      {
         return this.m_Bitmap;
      }
   }
}
