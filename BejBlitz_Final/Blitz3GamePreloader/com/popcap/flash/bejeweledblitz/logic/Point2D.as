package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class Point2D implements IPoolObject
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public function Point2D()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.Set(0,0);
      }
      
      public function Set(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
   }
}
