package com.popcap.flash.games.bej3
{
   public class Matcher
   {
      
      public static const MIN_MATCH:int = 3;
       
      
      private var mGems:Vector.<Gem>;
      
      private var mLast:Gem;
      
      private var mSize:int = 0;
      
      public function Matcher()
      {
         super();
         this.mGems = new Vector.<Gem>();
      }
      
      public function Reset() : void
      {
         this.mGems.length = 0;
         this.mLast = null;
         this.mSize = 0;
      }
      
      public function start(newGem:Gem) : void
      {
         if(newGem == null || newGem.type == Gem.TYPE_RAINBOW)
         {
            this.mLast = null;
            this.mSize = 0;
            return;
         }
         this.mGems[0] = newGem;
         this.mLast = newGem;
         this.mSize = 1;
      }
      
      public function push(newGem:Gem) : Match
      {
         var aMatch:Match = null;
         if(newGem == null || !newGem.canMatch())
         {
            aMatch = this.end();
            this.start(null);
            return aMatch;
         }
         if(this.mLast == null)
         {
            this.start(newGem);
            return null;
         }
         if(newGem.color != this.mLast.color)
         {
            aMatch = this.end();
            this.start(newGem);
            return aMatch;
         }
         this.mGems[this.mSize] = newGem;
         this.mLast = newGem;
         ++this.mSize;
         return null;
      }
      
      public function end() : Match
      {
         var gems:Vector.<Gem> = null;
         var match:Match = null;
         if(this.mSize >= MIN_MATCH)
         {
            gems = this.mGems.slice(0,this.mSize);
            match = new Match();
            match.init(gems);
            return match;
         }
         return null;
      }
   }
}
