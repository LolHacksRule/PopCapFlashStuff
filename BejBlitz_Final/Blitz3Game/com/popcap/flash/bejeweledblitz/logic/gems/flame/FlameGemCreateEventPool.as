package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class FlameGemCreateEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function FlameGemCreateEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextFlameGemCreateEvent(param1:Gem, param2:Match, param3:Boolean) : FlameGemCreateEvent
      {
         var _loc4_:FlameGemCreateEvent;
         (_loc4_ = GetNextObject() as FlameGemCreateEvent).Set(param1,param2,param3);
         return _loc4_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new FlameGemCreateEvent(this.m_Logic);
      }
   }
}
