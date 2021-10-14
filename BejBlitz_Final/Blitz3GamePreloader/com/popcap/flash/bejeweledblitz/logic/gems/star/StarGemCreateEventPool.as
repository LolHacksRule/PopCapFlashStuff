package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class StarGemCreateEventPool extends ObjectPool
   {
       
      
      private var _logic:BlitzLogic;
      
      public function StarGemCreateEventPool(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
      }
      
      public function GetNextStarGemCreateEvent(param1:Gem, param2:Match, param3:Match, param4:Boolean) : StarGemCreateEvent
      {
         var _loc5_:StarGemCreateEvent;
         (_loc5_ = GetNextObject() as StarGemCreateEvent).Set(param1,param2,param3,param4);
         return _loc5_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new StarGemCreateEvent(this._logic);
      }
   }
}
