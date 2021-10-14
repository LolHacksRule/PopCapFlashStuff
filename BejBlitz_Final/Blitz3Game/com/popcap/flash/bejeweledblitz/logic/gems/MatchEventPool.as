package com.popcap.flash.bejeweledblitz.logic.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class MatchEventPool extends ObjectPool
   {
       
      
      private var _logic:BlitzLogic;
      
      public function MatchEventPool(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         PreAllocate(150);
      }
      
      public function GetNextMatchEvent(param1:Gem) : MatchEvent
      {
         var _loc2_:MatchEvent = GetNextObject() as MatchEvent;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new MatchEvent(this._logic);
      }
   }
}
