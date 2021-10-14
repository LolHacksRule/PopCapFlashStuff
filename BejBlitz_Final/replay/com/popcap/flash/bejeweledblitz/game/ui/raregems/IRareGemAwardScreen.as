package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   public interface IRareGemAwardScreen
   {
       
      
      function Init() : void;
      
      function Show() : void;
      
      function Reset() : void;
      
      function Update() : void;
      
      function AddHandler(param1:IRareGemDialogHandler) : void;
   }
}
