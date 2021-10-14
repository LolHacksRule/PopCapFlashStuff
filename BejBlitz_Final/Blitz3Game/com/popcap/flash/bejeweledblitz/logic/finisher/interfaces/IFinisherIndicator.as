package com.popcap.flash.bejeweledblitz.logic.finisher.interfaces
{
   public interface IFinisherIndicator
   {
       
      
      function HandleFinisherIndicatorBegin() : void;
      
      function HandleFinisherIndicatorEnd() : void;
      
      function HandleFinisherIndicatorReset() : void;
      
      function HandleFinisherIndicatorPercentChanged(param1:Number) : void;
   }
}
