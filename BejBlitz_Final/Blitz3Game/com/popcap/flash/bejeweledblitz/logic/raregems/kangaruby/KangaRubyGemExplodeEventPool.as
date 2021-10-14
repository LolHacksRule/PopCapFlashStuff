package com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.pool.IPoolObject;
   import com.popcap.flash.framework.pool.ObjectPool;
   
   public class KangaRubyGemExplodeEventPool extends ObjectPool
   {
       
      
      private var m_Logic:BlitzLogic;
      
      public function KangaRubyGemExplodeEventPool(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetNextKangaRubyGemExplodeEvent(param1:Vector.<Vector.<Boolean>>, param2:Vector.<Vector.<Vector.<Boolean>>>, param3:String, param4:int) : KangaRubyGemExplodeEvent
      {
         var _loc5_:KangaRubyGemExplodeEvent;
         (_loc5_ = GetNextObject() as KangaRubyGemExplodeEvent).Set(param1,param2,param3,param4);
         return _loc5_;
      }
      
      override protected function GetNewObjectInstance() : IPoolObject
      {
         return new KangaRubyGemExplodeEvent(this.m_Logic);
      }
   }
}
