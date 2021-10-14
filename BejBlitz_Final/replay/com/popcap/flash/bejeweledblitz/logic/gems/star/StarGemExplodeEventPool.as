package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class StarGemExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function StarGemExplodeEventPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
      }
      
      public function GetNextStarGemExplodeEvent(locus:Gem) : StarGemExplodeEvent
      {
         var event:StarGemExplodeEvent = GetNextObject() as StarGemExplodeEvent;
         event.Set(locus);
         return event;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new StarGemExplodeEvent(this.m_Logic);
      }
   }
}
