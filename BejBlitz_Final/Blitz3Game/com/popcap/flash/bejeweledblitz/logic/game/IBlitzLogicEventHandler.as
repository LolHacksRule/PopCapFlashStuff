package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   
   public interface IBlitzLogicEventHandler
   {
       
      
      function HandleSwapBegin(param1:SwapData) : void;
      
      function HandleSwapComplete(param1:SwapData) : void;
      
      function HandleLastSuccessfulSwapComplete(param1:SwapData) : void;
      
      function HandleSwapCancel(param1:SwapData) : void;
      
      function HandleSpecialGemBlast(param1:Gem) : void;
   }
}
