package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class GemScorePool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function GemScorePool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         PreAllocate(350);
      }
      
      public function GetNextGemScore() : GemScore
      {
         return GetNextObject() as GemScore;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new GemScore(this.m_Logic);
      }
   }
}
