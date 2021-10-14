package com.popcap.flash.bejeweledblitz.logic.gems.multi
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class MultiplierUseData implements IPoolObject
   {
       
      
      public var time:int;
      
      public var color:int;
      
      public var number:int;
      
      public function MultiplierUseData()
      {
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.time = 0;
         this.color = 0;
         this.number = 0;
      }
   }
}
