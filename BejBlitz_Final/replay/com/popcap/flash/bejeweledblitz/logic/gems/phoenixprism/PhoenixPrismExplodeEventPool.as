package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class PhoenixPrismExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function PhoenixPrismExplodeEventPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
      }
      
      public function GetNextPhoenixPrismExplodeEvent(gem:Gem) : PhoenixPrismExplodeEvent
      {
         var event:PhoenixPrismExplodeEvent = GetNextObject() as PhoenixPrismExplodeEvent;
         event.Set(gem);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new PhoenixPrismExplodeEvent(this.m_Logic);
      }
   }
}
