package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class SwapDataPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function SwapDataPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         PreAllocate(40);
      }
      
      public function GetNextSwapData(move:MoveData, speed:Number) : SwapData
      {
         var point:SwapData = GetNextObject() as SwapData;
         point.Init(move,speed);
         return point;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new SwapData(this.m_Logic);
      }
   }
}
