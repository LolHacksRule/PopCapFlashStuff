package com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.IPrizeDefinition;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.ISlotLoader;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.ISymbolLoader;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolData;
   import flash.display.Bitmap;
   
   public class SlotLoader implements ISlotLoader, IDSEventHandler
   {
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_Cfg:Object;
      
      private var m_SymbolLoader:ISymbolLoader;
      
      private var m_PrizeDefs:Vector.<IPrizeDefinition>;
      
      public function SlotLoader(mgr:DailySpinManager, config:Object)
      {
         super();
         this.m_DSMgr = mgr;
         this.m_Cfg = config;
         this.init();
      }
      
      public function getSymbolLoader() : ISymbolLoader
      {
         return this.m_SymbolLoader;
      }
      
      public function getCopyOfSymbolImage(symbolId:String) : Bitmap
      {
         var symbolData:SymbolData = null;
         for each(symbolData in this.m_SymbolLoader.getSymbols())
         {
            if(symbolId == symbolData.id)
            {
               return new Bitmap(symbolData.bitmapData.bitmapData);
            }
         }
         return null;
      }
      
      public function getPrizeDefinitions() : Vector.<IPrizeDefinition>
      {
         return this.m_PrizeDefs;
      }
      
      public function getNumSlots() : int
      {
         return this.m_Cfg.config.numStrips;
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.initPrizeDefs();
      }
      
      private function init() : void
      {
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_SLOT_SYMBOL_LOAD_COMPLETE,this);
         this.m_SymbolLoader = new SymbolLoader(this.m_DSMgr);
         this.m_SymbolLoader.init();
      }
      
      private function initPrizeDefs() : void
      {
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_SLOT_SYMBOL_LOAD_COMPLETE,this);
         this.m_PrizeDefs = new Vector.<IPrizeDefinition>();
         var prizeList:Array = this.m_Cfg.prizes as Array;
         for(var i:int = 0; i < prizeList.length; i++)
         {
            this.m_PrizeDefs.push(new PrizeDef(prizeList[i]));
         }
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SLOT_LOADER_COMPLETE);
      }
   }
}
