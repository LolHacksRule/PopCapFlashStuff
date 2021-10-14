package com.popcap.flash.framework
{
   import flash.events.IEventDispatcher;
   
   public interface IAppState extends IEventDispatcher
   {
       
      
      function onEnter() : void;
      
      function onMouseUp(param1:Number, param2:Number) : void;
      
      function onKeyDown(param1:int) : void;
      
      function draw(param1:int) : void;
      
      function onMouseDown(param1:Number, param2:Number) : void;
      
      function update() : void;
      
      function onPop() : void;
      
      function onMouseMove(param1:Number, param2:Number) : void;
      
      function onPush() : void;
      
      function onKeyUp(param1:int) : void;
      
      function onExit() : void;
   }
}
