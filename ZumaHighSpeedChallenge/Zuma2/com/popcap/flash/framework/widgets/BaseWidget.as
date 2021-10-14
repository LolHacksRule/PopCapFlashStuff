package com.popcap.flash.framework.widgets
{
   import com.popcap.flash.framework.Canvas;
   import flash.geom.Point;
   
   public class BaseWidget implements Widget
   {
       
      
      private var mIsEnabled:Boolean = true;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      protected var mousePos:Point;
      
      private var mIsVisible:Boolean = true;
      
      public function BaseWidget()
      {
         this.mousePos = new Point();
         super();
      }
      
      public function onKeyUp(param1:int) : void
      {
      }
      
      public function draw(param1:Canvas) : void
      {
      }
      
      public function onMouseMove(param1:Number, param2:Number) : void
      {
         this.mousePos.x = param1;
         this.mousePos.y = param2;
      }
      
      public function get x() : Number
      {
         return this.mX;
      }
      
      public function get y() : Number
      {
         return this.mY;
      }
      
      public function update() : void
      {
      }
      
      public function onMouseDown(param1:Number, param2:Number) : void
      {
         this.mousePos.x = param1;
         this.mousePos.y = param2;
      }
      
      public function set isVisible(param1:Boolean) : void
      {
         this.mIsVisible = param1;
      }
      
      public function onKeyDown(param1:int) : void
      {
      }
      
      public function onMouseOut(param1:Number, param2:Number) : void
      {
         this.mousePos.x = param1;
         this.mousePos.y = param2;
      }
      
      public function onMouseUp(param1:Number, param2:Number) : void
      {
         this.mousePos.x = param1;
         this.mousePos.y = param2;
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         return false;
      }
      
      public function get isVisible() : Boolean
      {
         return this.mIsVisible;
      }
      
      public function set x(param1:Number) : void
      {
         this.mX = param1;
      }
      
      public function set y(param1:Number) : void
      {
         this.mY = param1;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         this.mIsEnabled = param1;
      }
      
      public function onMouseOver(param1:Number, param2:Number) : void
      {
         this.mousePos.x = param1;
         this.mousePos.y = param2;
      }
      
      public function get isEnabled() : Boolean
      {
         return this.mIsEnabled;
      }
   }
}
