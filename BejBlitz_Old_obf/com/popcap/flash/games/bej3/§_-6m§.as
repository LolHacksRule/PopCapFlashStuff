package com.popcap.flash.games.bej3
{
   public class §_-6m§
   {
       
      
      private var §_-Cq§:int = 0;
      
      private var §_-Uj§:Vector.<Gem>;
      
      public function §_-6m§()
      {
         super();
         this.§_-Uj§ = new Vector.<Gem>();
      }
      
      public function §_-gH§() : Gem
      {
         if(this.§_-Cq§ >= this.§_-Uj§.length)
         {
            this.§_-Uj§[this.§_-Cq§] = new Gem();
         }
         var _loc1_:Gem = this.§_-Uj§[this.§_-Cq§];
         _loc1_.Reset();
         ++this.§_-Cq§;
         return _loc1_;
      }
      
      public function Reset() : void
      {
         this.§_-Cq§ = 0;
      }
   }
}
