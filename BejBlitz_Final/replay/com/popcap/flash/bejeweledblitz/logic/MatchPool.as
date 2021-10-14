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
      
      public function GetNextMatch(gems:Vector.<Gem>, color:int) : Match
      {
         var match:Match = GetNextObject() as Match;
         match.Init(gems,color);
         return match;
      }
      
      public function FreeMatches(matches:Vector.<Match>) : void
      {
         var match:Match = null;
         for each(match in matches)
         {
            if(match != null)
            {
               FreeObject(match);
            }
         }
         matches.length = 0;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new Match();
      }
   }
}
