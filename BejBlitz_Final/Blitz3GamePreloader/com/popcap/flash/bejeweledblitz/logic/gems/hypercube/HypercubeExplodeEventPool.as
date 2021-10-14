package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class HypercubeExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function HypercubeExplodeEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextHypercubeExplodeEvent(param1:Gem) : HypercubeExplodeEvent
      {
         var _loc2_:HypercubeExplodeEvent = GetNextObject() as HypercubeExplodeEvent;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new HypercubeExplodeEvent(this.m_Logic);
      }
   }
}
