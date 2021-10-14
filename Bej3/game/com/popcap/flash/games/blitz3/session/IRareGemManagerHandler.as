package com.popcap.flash.games.blitz3.session
{
   import flash.utils.Dictionary;
   
   public interface IRareGemManagerHandler
   {
       
      
      function HandleRareGemCatalogChanged(param1:Dictionary) : void;
      
      function HandleActiveRareGemChanged(param1:String) : void;
   }
}
