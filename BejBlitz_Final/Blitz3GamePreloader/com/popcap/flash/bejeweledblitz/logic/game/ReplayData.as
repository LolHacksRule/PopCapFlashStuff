package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class ReplayData implements IPoolObject
   {
       
      
      public var commandArray:Vector.<String>;
      
      public function ReplayData()
      {
         super();
         this.commandArray = new Vector.<String>();
      }
      
      public function Reset() : void
      {
         this.commandArray.length = 0;
      }
   }
}
