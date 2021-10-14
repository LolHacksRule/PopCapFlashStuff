package com.popcap.flash.bejeweledblitz.logic.gems.scramble
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class ScrambleEventPool extends ObjectPool
   {
       
      
      private var _logic:BlitzLogic;
      
      public function ScrambleEventPool(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         PreAllocate(20);
      }
      
      public function GetNextScrambleEvent() : ScrambleEvent
      {
         var _loc1_:ScrambleEvent = GetNextObject() as ScrambleEvent;
         _loc1_.Init();
         return _loc1_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new ScrambleEvent(this._logic);
      }
   }
}
