package com.popcap.flash.games.bej3
{
   public class §_-oi§
   {
      
      public static const §_-0R§:int = 3;
       
      
      private var mGems:Vector.<Gem>;
      
      private var §_-oq§:Gem;
      
      private var §_-p9§:int = 0;
      
      public function §_-oi§()
      {
         super();
         this.mGems = new Vector.<Gem>();
      }
      
      public function push(param1:Gem) : Match
      {
         var _loc2_:Match = null;
         if(param1 == null || !param1.canMatch())
         {
            _loc2_ = this.end();
            this.start(null);
            return _loc2_;
         }
         if(this.§_-oq§ == null)
         {
            this.start(param1);
            return null;
         }
         if(param1.color != this.§_-oq§.color)
         {
            _loc2_ = this.end();
            this.start(param1);
            return _loc2_;
         }
         this.mGems[this.§_-p9§] = param1;
         this.§_-oq§ = param1;
         ++this.§_-p9§;
         return null;
      }
      
      public function start(param1:Gem) : void
      {
         if(param1 == null || param1.type == Gem.§_-l0§)
         {
            this.§_-oq§ = null;
            this.§_-p9§ = 0;
            return;
         }
         this.mGems[0] = param1;
         this.§_-oq§ = param1;
         this.§_-p9§ = 1;
      }
      
      public function end() : Match
      {
         var _loc1_:Vector.<Gem> = null;
         var _loc2_:Match = null;
         if(this.§_-p9§ >= §_-0R§)
         {
            _loc1_ = this.mGems.slice(0,this.§_-p9§);
            _loc2_ = new Match();
            _loc2_.§_-4f§(_loc1_);
            return _loc2_;
         }
         return null;
      }
      
      public function Reset() : void
      {
         this.mGems.length = 0;
         this.§_-oq§ = null;
         this.§_-p9§ = 0;
      }
   }
}
