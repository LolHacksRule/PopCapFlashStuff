package com.popcap.flash.bejeweledblitz.logic.gems.unscramble
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class UnScrambleEventPool extends ObjectPool
   {
       
      
      private var _logic:BlitzLogic;
      
      public function UnScrambleEventPool(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         PreAllocate(4);
      }
      
      public function GetNextUnScrambleEvent(param1:String) : UnScrambleEvent
      {
         var _loc2_:UnScrambleEvent = GetNextObject() as UnScrambleEvent;
         _loc2_.Set(param1);
         _loc2_.Init();
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new UnScrambleEvent(this._logic);
      }
   }
}
