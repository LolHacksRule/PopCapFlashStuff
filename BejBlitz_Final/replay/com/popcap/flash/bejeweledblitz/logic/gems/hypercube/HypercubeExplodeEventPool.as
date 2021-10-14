package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class HypercubeExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function HypercubeExplodeEventPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
      }
      
      public function GetNextHypercubeExplodeEvent(gem:Gem) : HypercubeExplodeEvent
      {
         var event:HypercubeExplodeEvent = GetNextObject() as HypercubeExplodeEvent;
         event.Set(gem);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new HypercubeExplodeEvent(this.m_Logic);
      }
   }
}
