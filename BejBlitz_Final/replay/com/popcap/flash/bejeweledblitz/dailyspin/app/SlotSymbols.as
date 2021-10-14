package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolConfig;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolData;
   import com.popcap.flash.bejeweledblitz.dailyspin.s7.core.Utility;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SlotSymbols extends EventDispatcher
   {
      
      public static const SLOT_ANY:String = "SYMBOL_ANY";
      
      public static const SLOT_NONE:String = "SYMBOL_NONE";
      
      private static const DEFAULT_BLANK_SLOT_SRC:String = "slot_blank";
       
      
      private var m_loadedGems:int;
      
      private var m_registeredSymbols:Vector.<SymbolConfig>;
      
      private var m_shuffledSymbols:Array;
      
      private var m_symbolAny:SymbolConfig;
      
      private var m_symbolNone:SymbolConfig;
      
      public function SlotSymbols()
      {
         super();
         this.m_shuffledSymbols = new Array();
         this.m_registeredSymbols = new Vector.<SymbolConfig>();
      }
      
      public function get symbolAny() : SymbolConfig
      {
         return this.m_symbolAny;
      }
      
      public function get symbolNone() : SymbolConfig
      {
         return this.m_symbolNone;
      }
      
      public function get symbols() : Vector.<SymbolConfig>
      {
         return this.m_registeredSymbols;
      }
      
      public function get shuffledSymbolClips() : Array
      {
         Utility.shuffle(this.m_shuffledSymbols);
         var clips:Array = new Array();
         for(var i:int = 0; i < this.m_shuffledSymbols.length; i++)
         {
            clips.push(this.m_shuffledSymbols[i].clip);
         }
         return clips;
      }
      
      public function init(symbolLoader:ISymbolLoader) : void
      {
         var sym:SymbolConfig = null;
         var symbol:SymbolData = null;
         var symConfig:SymbolConfig = null;
         this.m_symbolAny = new SymbolConfig(SLOT_ANY,symbolLoader.getSymbolAny().bitmapData);
         this.m_symbolNone = new SymbolConfig(SLOT_NONE,symbolLoader.getSymbolNone().bitmapData);
         this.m_registeredSymbols.push(this.m_symbolAny);
         this.m_registeredSymbols.push(this.m_symbolNone);
         for each(symbol in symbolLoader.getSymbols())
         {
            sym = new SymbolConfig(symbol.id,symbol.bitmapData);
            this.m_shuffledSymbols.push(sym);
            this.m_registeredSymbols.push(sym);
         }
         this.m_loadedGems = 0;
         for each(symConfig in this.m_shuffledSymbols)
         {
            if(symConfig.bitmap != null)
            {
               ++this.m_loadedGems;
            }
         }
         if(this.m_loadedGems == this.m_shuffledSymbols.length)
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function getSymbolById(id:String) : SymbolConfig
      {
         for(var i:int = 0; i < this.m_registeredSymbols.length; i++)
         {
            if(this.m_registeredSymbols[i].id == id)
            {
               return this.m_registeredSymbols[i];
            }
         }
         return null;
      }
   }
}
