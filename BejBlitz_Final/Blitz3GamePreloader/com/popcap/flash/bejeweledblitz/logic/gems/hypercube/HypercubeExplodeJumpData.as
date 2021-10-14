package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class HypercubeExplodeJumpData implements IPoolObject
   {
       
      
      public var delayTime:int;
      
      public var destroyTime:int;
      
      public var sourceGem:Gem;
      
      public var destGem:Gem;
      
      public function HypercubeExplodeJumpData()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.delayTime = 1;
         this.destroyTime = 1;
         this.sourceGem = null;
         this.destGem = null;
      }
   }
}
