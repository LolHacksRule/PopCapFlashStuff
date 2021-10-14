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
      
      public function GetNextPoint2D(x:Number, y:Number) : Point2D
      {
         var point:Point2D = GetNextObject() as Point2D;
         point.Set(x,y);
         return point;
      }
      
      public function FreePoint2Ds(points:Vector.<Point2D>) : void
      {
         var point:Point2D = null;
         for each(point in points)
         {
            if(point != null)
            {
               FreeObject(point);
            }
         }
         points.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new Point2D();
      }
   }
}
