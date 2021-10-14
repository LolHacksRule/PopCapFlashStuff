package com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class SlotSymbol
   {
      
      private static const MAX_PIXEL_SIZE:int = 104;
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_SymbolId:String;
      
      private var m_Image:Bitmap;
      
      public function SlotSymbol(dsMgr:DailySpinManager, symbolId:String)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_SymbolId = symbolId;
         this.init();
      }
      
      public function get symbolId() : String
      {
         return this.m_SymbolId;
      }
      
      public function get symbolImage() : Bitmap
      {
         return this.m_Image;
      }
      
      private function loadImage(imageURL:String) : void
      {
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.INIT,this.onImageLoad);
         loader.load(new URLRequest(imageURL),new LoaderContext(true));
      }
      
      private function onImageLoad(e:Event) : void
      {
         this.m_Image = (e.target as LoaderInfo).content as Bitmap;
         this.scaleImageToFit();
         this.loadComplete();
      }
      
      private function loadComplete() : void
      {
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SLOT_SYMBOL_IMAGE_LOADED);
      }
      
      private function scaleImageToFit() : void
      {
         if(this.m_Image.width <= MAX_PIXEL_SIZE && this.m_Image.height <= MAX_PIXEL_SIZE)
         {
            return;
         }
         var largestSide:Number = this.m_Image.width > this.m_Image.height ? Number(this.m_Image.width) : Number(this.m_Image.height);
         this.m_Image.scaleX = this.m_Image.scaleY = MAX_PIXEL_SIZE / largestSide;
      }
      
      private function init() : void
      {
         var imageURL:String = null;
         var symbolImageMap:Object = this.m_DSMgr.paramLoader.getSymbolImageMap();
         if(symbolImageMap)
         {
            imageURL = symbolImageMap[this.m_SymbolId];
            if(imageURL)
            {
               this.loadImage(imageURL);
               return;
            }
         }
         this.m_Image = this.m_DSMgr.getBitmapAsset("IMAGE_DAILYSPIN_" + this.m_SymbolId);
         this.loadComplete();
      }
   }
}
