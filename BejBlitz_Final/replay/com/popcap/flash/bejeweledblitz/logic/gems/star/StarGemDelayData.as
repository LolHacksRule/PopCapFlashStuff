package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class StarGemDelayData implements IPoolObject
   {
       
      
      public var gems:Vector.<Gem>;
      
      public var time:int;
      
      public var isDone:Boolean;
      
      public function StarGemDelayData()
      {
         super();
         this.gems = new Vector.<Gem>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.gems.length = 0;
         this.time = 0;
         this.isDone = false;
      }
   }
}
