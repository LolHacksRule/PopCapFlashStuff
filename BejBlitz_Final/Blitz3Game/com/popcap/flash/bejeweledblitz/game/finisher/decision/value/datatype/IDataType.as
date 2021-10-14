package com.popcap.flash.bejeweledblitz.game.finisher.decision.value.datatype
{
   public interface IDataType
   {
       
      
      function IsEqual(param1:IDataType) : Boolean;
      
      function GreaterThan(param1:IDataType) : Boolean;
      
      function LessThan(param1:IDataType) : Boolean;
   }
}
