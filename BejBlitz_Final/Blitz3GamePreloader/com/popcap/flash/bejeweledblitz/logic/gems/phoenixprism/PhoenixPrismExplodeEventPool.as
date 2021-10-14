package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class PhoenixPrismExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function PhoenixPrismExplodeEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextPhoenixPrismExplodeEvent(param1:Gem) : PhoenixPrismExplodeEvent
      {
         var _loc2_:PhoenixPrismExplodeEvent = GetNextObject() as PhoenixPrismExplodeEvent;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new PhoenixPrismExplodeEvent(this.m_Logic);
      }
   }
}
