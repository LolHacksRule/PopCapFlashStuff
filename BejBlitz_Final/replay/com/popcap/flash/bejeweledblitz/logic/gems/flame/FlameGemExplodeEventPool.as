package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class FlameGemExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function FlameGemExplodeEventPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
      }
      
      public function GetNextFlameGemExplodeEvent(gem:Gem) : FlameGemExplodeEvent
      {
         var event:FlameGemExplodeEvent = GetNextObject() as FlameGemExplodeEvent;
         event.Set(gem);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new FlameGemExplodeEvent(this.m_Logic);
      }
   }
}
