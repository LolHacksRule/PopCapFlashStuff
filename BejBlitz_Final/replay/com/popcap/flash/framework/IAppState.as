package com.popcap.flash.framework
{
   import flash.events.IEventDispatcher;
   
   public interface IAppState extends IEventDispatcher
   {
       
      
      function update() : void;
      
      function draw(param1:int) : void;
      
      function onEnter() : void;
      
      function onExit() : void;
      
      function onKeyUp(param1:int) : void;
      
      function onKeyDown(param1:int) : void;
   }
}
