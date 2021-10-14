package com.popcap.flash.games.bej3
{
   public class GemPool
   {
       
      
      private var mPool:Vector.<Gem>;
      
      private var mIndex:int = 0;
      
      public function GemPool()
      {
         super();
         this.mPool = new Vector.<Gem>();
      }
      
      public function Reset() : void
      {
         this.mIndex = 0;
      }
      
      public function GetGem() : Gem
      {
         if(this.mIndex >= this.mPool.length)
         {
            this.mPool[this.mIndex] = new Gem();
         }
         var gem:Gem = this.mPool[this.mIndex];
         gem.Reset();
         ++this.mIndex;
         return gem;
      }
   }
}
