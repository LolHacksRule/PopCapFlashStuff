package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class PhoenixPrismHurrahExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function PhoenixPrismHurrahExplodeEventPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
      }
      
      public function GetNextPhoenixPrismHurrahExplodeEvent() : PhoenixPrismHurrahExplodeEvent
      {
         var event:PhoenixPrismHurrahExplodeEvent = GetNextObject() as PhoenixPrismHurrahExplodeEvent;
         event.Set();
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new PhoenixPrismHurrahExplodeEvent(this.m_Logic);
      }
   }
}
