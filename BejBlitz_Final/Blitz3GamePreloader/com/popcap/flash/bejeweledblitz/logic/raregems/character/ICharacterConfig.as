package com.popcap.flash.bejeweledblitz.logic.raregems.character
{
   public interface ICharacterConfig
   {
       
      
      function GetID() : String;
      
      function GetRepeatCount() : int;
      
      function GetPercentage(param1:int) : int;
      
      function ShouldShow(param1:int) : Boolean;
      
      function Reset() : void;
   }
}
