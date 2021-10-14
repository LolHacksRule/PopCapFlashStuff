package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class PhoenixPrismDelayData implements IPoolObject
   {
       
      
      public var gems:Vector.<Gem>;
      
      public var time:int;
      
      public var isDone:Boolean;
      
      public function PhoenixPrismDelayData()
      {
         super();
         this.gems = new Vector.<Gem>();
      }
      
      public function Reset() : void
      {
         this.gems.length = 0;
         this.time = 0;
         this.isDone = false;
      }
   }
}
