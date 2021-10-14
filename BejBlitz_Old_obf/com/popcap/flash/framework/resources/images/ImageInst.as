package com.popcap.flash.framework.resources.images
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class ImageInst
   {
       
      
      public var §_-hj§:int = 0;
      
      public var §_-WR§:Boolean = false;
      
      public var §_-Ap§:Boolean = false;
      
      public var §_-1r§:Matrix;
      
      public var §_-EP§:Point;
      
      public var §use §:Boolean = false;
      
      public var §_-UE§:Boolean = false;
      
      public var §_-mC§:Point;
      
      public var §_-O8§:§_-c-§ = null;
      
      public var §_-d6§:ColorTransform;
      
      public function ImageInst()
      {
         this.§_-mC§ = new Point();
         this.§_-EP§ = new Point();
         this.§_-1r§ = new Matrix();
         this.§_-d6§ = new ColorTransform();
         super();
      }
      
      public function get width() : Number
      {
         return this.§_-O8§.§_-g4§.width;
      }
      
      public function get §_-57§() : BitmapData
      {
         return this.§_-O8§.§_-2s§[this.§_-hj§];
      }
      
      public function get height() : Number
      {
         return this.§_-O8§.§_-g4§.height;
      }
      
      public function set x(param1:Number) : void
      {
         this.§_-mC§.x = param1;
         this.§_-1r§.tx = param1;
      }
      
      public function set y(param1:Number) : void
      {
         this.§_-mC§.y = param1;
         this.§_-1r§.ty = param1;
      }
      
      public function get x() : Number
      {
         return this.§_-mC§.x;
      }
      
      public function get y() : Number
      {
         return this.§_-mC§.y;
      }
   }
}
