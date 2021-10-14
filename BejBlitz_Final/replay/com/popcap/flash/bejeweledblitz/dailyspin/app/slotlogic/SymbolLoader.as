package com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.ISymbolLoader;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolData;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SymbolLoader implements ISymbolLoader, IDSEventHandler
   {
       
      
      private const MAX_SYMBOLS:int = 7;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_SlotSymbols:Vector.<SlotSymbol>;
      
      private var m_SymbolDataList:Vector.<SymbolData>;
      
      private var m_SymbolAny:SymbolData;
      
      private var m_SymbolNone:SymbolData;
      
      private var m_NumSymbolsLoaded:int;
      
      public function SymbolLoader(mgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = mgr;
      }
      
      public function init() : void
      {
         this.initSymbolImages();
      }
      
      public function getSymbolById(symbolId:String) : SymbolData
      {
         var symbolData:SymbolData = null;
         for each(symbolData in this.m_SymbolDataList)
         {
            if(symbolId == symbolData.id)
            {
               return symbolData;
            }
         }
         return null;
      }
      
      public function getSymbols() : Vector.<SymbolData>
      {
         return this.m_SymbolDataList;
      }
      
      public function getSymbolAny() : SymbolData
      {
         return this.m_SymbolAny;
      }
      
      public function getSymbolNone() : SymbolData
      {
         return this.m_SymbolNone;
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.handleSymbolImageLoad();
      }
      
      private function handleSymbolImageLoad() : void
      {
         ++this.m_NumSymbolsLoaded;
         if(this.m_NumSymbolsLoaded == this.MAX_SYMBOLS)
         {
            this.initSymbolData();
         }
      }
      
      private function createSymbolData(symId:String) : SymbolData
      {
         var symbol:Sprite = new Sprite();
         var bm:Bitmap = this.m_DSMgr.getBitmapAsset("IMAGE_DAILYSPIN_" + symId);
         symbol.addChild(bm);
         return new SymbolData(symId,symbol);
      }
      
      private function initSymbolImages() : void
      {
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_SLOT_SYMBOL_IMAGE_LOADED,this);
         this.m_SlotSymbols = new Vector.<SlotSymbol>();
         for(var i:int = 0; i < this.MAX_SYMBOLS; i++)
         {
            this.m_SlotSymbols.push(new SlotSymbol(this.m_DSMgr,"SYMBOL_" + String(i)));
         }
      }
      
      private function initSymbolData() : void
      {
         var slotSymbol:SlotSymbol = null;
         var symbol:Sprite = null;
         this.m_SymbolDataList = new Vector.<SymbolData>();
         for each(slotSymbol in this.m_SlotSymbols)
         {
            symbol = new Sprite();
            symbol.addChild(slotSymbol.symbolImage);
            this.m_SymbolDataList.push(new SymbolData(slotSymbol.symbolId,symbol));
         }
         this.m_SymbolAny = new SymbolData("SYMBOL_ANY",null);
         this.m_SymbolNone = this.createSymbolData("SYMBOL_NONE_REEL");
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SLOT_SYMBOL_LOAD_COMPLETE);
      }
   }
}
