package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class Point2DPool extends ObjectPool
   {
       
      
      public function Point2DPool()
      {
         super();
         PreAllocate(256);
      }
      
      public function GetNextPoint2D(param1:Number, param2:Number) : Point2D
      {
         var _loc3_:Point2D = GetNextObject() as Point2D;
         _loc3_.Set(param1,param2);
         return _loc3_;
      }
      
      public function FreePoint2Ds(param1:Vector.<Point2D>) : void
      {
         var _loc2_:Point2D = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               FreeObject(_loc2_);
            }
         }
         param1.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new Point2D();
      }
   }
}
