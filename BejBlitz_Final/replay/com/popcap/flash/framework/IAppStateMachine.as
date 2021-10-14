package com.popcap.flash.framework
{
   public interface IAppStateMachine
   {
       
      
      function getCurrentState() : IAppState;
      
      function bindState(param1:String, param2:IAppState) : void;
      
      function switchState(param1:String) : void;
   }
}
