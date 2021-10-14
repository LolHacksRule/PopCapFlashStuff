package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MatchSetPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function MatchSetPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
         PreAllocate(15);
      }
      
      public function GetNextMatchSet() : MatchSet
      {
         return GetNextObject() as MatchSet;
      }
      
      public function FreeMatchSet(param1:MatchSet, param2:Boolean) : void
      {
         if(param2)
         {
            this.m_Logic.matchPool.FreeMatches(param1.mMatches);
         }
         FreeObject(param1);
      }
      
      public function FreeMatchSets(param1:Vector.<MatchSet>, param2:Boolean) : void
      {
         var _loc3_:MatchSet = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_ != null)
            {
               this.FreeMatchSet(_loc3_,param2);
            }
         }
         param1.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MatchSet();
      }
   }
}
