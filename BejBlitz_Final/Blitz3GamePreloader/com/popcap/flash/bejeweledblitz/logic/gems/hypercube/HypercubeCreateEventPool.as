package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class HypercubeCreateEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function HypercubeCreateEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextHypercubeCreateEvent(param1:Gem, param2:Match) : HypercubeCreateEvent
      {
         var _loc3_:HypercubeCreateEvent = GetNextObject() as HypercubeCreateEvent;
         _loc3_.Set(param1,param2);
         return _loc3_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new HypercubeCreateEvent(this.m_Logic);
      }
   }
}
