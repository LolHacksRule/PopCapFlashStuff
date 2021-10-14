package com.popcap.flash.bejeweledblitz.dailyspin.app
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.structs.SymbolData;
   
   public interface ISymbolLoader
   {
       
      
      function init() : void;
      
      function getSymbols() : Vector.<SymbolData>;
      
      function getSymbolAny() : SymbolData;
      
      function getSymbolNone() : SymbolData;
   }
}
