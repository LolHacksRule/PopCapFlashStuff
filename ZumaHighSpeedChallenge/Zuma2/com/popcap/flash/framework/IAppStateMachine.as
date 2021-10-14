package com.popcap.flash.framework
{
   public interface IAppStateMachine
   {
       
      
      function popState(param1:String) : void;
      
      function bindState(param1:String, param2:IAppState) : void;
      
      function pushState(param1:String) : void;
      
      function switchState(param1:String) : void;
      
      function getCurrentState() : IAppState;
   }
}
