package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MatchScorePool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function MatchScorePool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         PreAllocate(60);
      }
      
      public function GetNextMatchScore() : MatchScore
      {
         return GetNextObject() as MatchScore;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MatchScore(this.m_Logic);
      }
   }
}
