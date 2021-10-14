package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class StarGemExplodeEventPool extends ObjectPool
   {
       
      
      private var _logic:BlitzLogic;
      
      public function StarGemExplodeEventPool(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
      }
      
      public function GetNextStarGemExplodeEvent(param1:Gem) : StarGemExplodeEvent
      {
         var _loc2_:StarGemExplodeEvent = GetNextObject() as StarGemExplodeEvent;
         _loc2_.Set(param1);
         return _loc2_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new StarGemExplodeEvent(this._logic);
      }
   }
}
