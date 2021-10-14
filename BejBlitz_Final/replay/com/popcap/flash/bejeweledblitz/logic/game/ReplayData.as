package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class ReplayData implements IPoolObject
   {
       
      
      public var command:Vector.<int>;
      
      public function ReplayData()
      {
         super();
         this.command = new Vector.<int>();
      }
      
      public function Reset() : void
      {
         this.command.length = 0;
      }
   }
}
