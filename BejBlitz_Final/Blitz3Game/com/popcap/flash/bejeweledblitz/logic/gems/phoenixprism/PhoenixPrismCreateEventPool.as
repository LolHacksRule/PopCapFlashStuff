package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class PhoenixPrismCreateEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function PhoenixPrismCreateEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextPhoenixPrismCreateEvent(param1:Gem, param2:Match) : PhoenixPrismCreateEvent
      {
         var _loc3_:PhoenixPrismCreateEvent = GetNextObject() as PhoenixPrismCreateEvent;
         _loc3_.Set(param1,param2);
         return _loc3_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new PhoenixPrismCreateEvent(this.m_Logic);
      }
   }
}
