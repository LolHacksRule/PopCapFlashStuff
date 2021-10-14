package com.popcap.flash.bejeweledblitz.dailyspin.state
{
   public interface IStateHandler
   {
       
      
      function getState() : IState;
      
      function canHandleState(param1:IState) : Boolean;
      
      function handleState(param1:IState) : Boolean;
   }
}
