package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MatchPool extends ObjectPool
   {
       
      
      public function MatchPool()
      {
         super();
         PreAllocate(100);
      }
      
      public function GetNextMatch(param1:Vector.<Gem>, param2:int) : Match
      {
         var _loc3_:Match = GetNextObject() as Match;
         _loc3_.Init(param1,param2);
         return _loc3_;
      }
      
      public function FreeMatches(param1:Vector.<Match>) : void
      {
         var _loc2_:Match = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               FreeObject(_loc2_);
            }
         }
         param1.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new Match();
      }
   }
}
