package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import flash.utils.Dictionary;
   
   public interface IRareGemManagerHandler
   {
       
      
      function HandleRareGemCatalogChanged(param1:Dictionary) : void;
      
      function HandleActiveRareGemChanged(param1:String) : void;
   }
}
