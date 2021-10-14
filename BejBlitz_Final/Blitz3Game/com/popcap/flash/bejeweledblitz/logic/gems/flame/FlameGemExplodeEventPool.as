package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class FlameGemExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function FlameGemExplodeEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextFlameGemExplodeEvent(param1:Gem) : FlameGemExplodeEvent
      {
         var _loc2_:FlameGemExplodeEvent = GetNextObject() as FlameGemExplodeEvent;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new FlameGemExplodeEvent(this.m_Logic);
      }
   }
}
