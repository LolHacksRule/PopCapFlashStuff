package com.popcap.flash.bejeweledblitz.logic.finisher.config
{
   public interface IFinisherPopupConfig
   {
       
      
      function GetLifeTime() : uint;
      
      function GetPopupTexts() : Vector.<IFinisherPopupText>;
   }
}
