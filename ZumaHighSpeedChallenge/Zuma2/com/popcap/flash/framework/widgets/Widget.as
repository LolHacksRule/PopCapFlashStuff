package com.popcap.flash.framework.widgets
{
   import com.popcap.flash.framework.Canvas;
   
   public interface Widget
   {
       
      
      function onMouseDown(param1:Number, param2:Number) : void;
      
      function onMouseUp(param1:Number, param2:Number) : void;
      
      function onKeyDown(param1:int) : void;
      
      function draw(param1:Canvas) : void;
      
      function set isVisible(param1:Boolean) : void;
      
      function update() : void;
      
      function onMouseOut(param1:Number, param2:Number) : void;
      
      function set isEnabled(param1:Boolean) : void;
      
      function get isVisible() : Boolean;
      
      function set x(param1:Number) : void;
      
      function set y(param1:Number) : void;
      
      function get isEnabled() : Boolean;
      
      function get x() : Number;
      
      function get y() : Number;
      
      function onMouseOver(param1:Number, param2:Number) : void;
      
      function onKeyUp(param1:int) : void;
      
      function onMouseMove(param1:Number, param2:Number) : void;
      
      function contains(param1:Number, param2:Number) : Boolean;
   }
}
