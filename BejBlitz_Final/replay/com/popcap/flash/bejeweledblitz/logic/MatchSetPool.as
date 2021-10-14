package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MatchSetPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function MatchSetPool(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         PreAllocate(15);
      }
      
      public function GetNextMatchSet() : MatchSet
      {
         return GetNextObject() as MatchSet;
      }
      
      public function FreeMatchSet(matchSet:MatchSet, shouldFreeMatches:Boolean) : void
      {
         if(shouldFreeMatches)
         {
            this.m_Logic.matchPool.FreeMatches(matchSet.mMatches);
         }
         FreeObject(matchSet);
      }
      
      public function FreeMatchSets(matchSets:Vector.<MatchSet>, shouldFreeMatches:Boolean) : void
      {
         var matchSet:MatchSet = null;
         for each(matchSet in matchSets)
         {
            if(matchSet != null)
            {
               this.FreeMatchSet(matchSet,shouldFreeMatches);
            }
         }
         matchSets.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MatchSet();
      }
   }
}
