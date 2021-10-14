package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class PhoenixPrismHurrahExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function PhoenixPrismHurrahExplodeEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextPhoenixPrismHurrahExplodeEvent() : PhoenixPrismHurrahExplodeEvent
      {
         var _loc1_:PhoenixPrismHurrahExplodeEvent = GetNextObject() as PhoenixPrismHurrahExplodeEvent;
         _loc1_.Set();
         return _loc1_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new PhoenixPrismHurrahExplodeEvent(this.m_Logic);
      }
   }
}
