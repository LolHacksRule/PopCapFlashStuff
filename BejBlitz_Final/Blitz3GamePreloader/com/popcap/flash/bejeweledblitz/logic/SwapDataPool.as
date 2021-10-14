package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class SwapDataPool extends ObjectPool
   {
       
      
      private var _logic:BlitzLogic;
      
      public function SwapDataPool(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         PreAllocate(40);
      }
      
      public function GetNextSwapData(param1:MoveData, param2:Number) : SwapData
      {
         var _loc3_:SwapData = GetNextObject() as SwapData;
         _loc3_.Init(param1,param2);
         return _loc3_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new SwapData(this._logic);
      }
   }
}
