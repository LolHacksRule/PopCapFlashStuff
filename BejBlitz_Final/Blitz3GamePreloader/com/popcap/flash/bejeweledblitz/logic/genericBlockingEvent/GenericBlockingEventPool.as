package com.popcap.flash.bejeweledblitz.logic.genericBlockingEvent
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class GenericBlockingEventPool extends ObjectPool
   {
       
      
      private var _logic:BlitzLogic;
      
      public function GenericBlockingEventPool(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         PreAllocate(20);
      }
      
      public function GetNextGenericBlockingEvent() : GenericBlockingEvent
      {
         var _loc1_:GenericBlockingEvent = GetNextObject() as GenericBlockingEvent;
         _loc1_.Init();
         return _loc1_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new GenericBlockingEvent();
      }
   }
}
