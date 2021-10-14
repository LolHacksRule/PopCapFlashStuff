package com.popcap.flash.bejeweledblitz.logic.finisher.states
{
   public interface IFinisherState
   {
       
      
      function Activate() : void;
      
      function IsStateCompleted() : Boolean;
      
      function CleanUp() : void;
      
      function Update(param1:Number) : void;
      
      function IsStateCancelled() : Boolean;
      
      function GetName() : String;
   }
}
