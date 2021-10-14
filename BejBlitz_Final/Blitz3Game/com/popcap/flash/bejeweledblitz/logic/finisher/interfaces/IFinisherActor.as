package com.popcap.flash.bejeweledblitz.logic.finisher.interfaces
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public interface IFinisherActor
   {
       
      
      function UpdateProps(param1:Number) : void;
      
      function CreateProp(param1:Gem, param2:Number) : void;
      
      function RemoveProps() : void;
   }
}
