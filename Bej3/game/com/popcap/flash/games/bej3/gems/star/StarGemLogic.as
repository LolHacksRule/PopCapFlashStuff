package com.popcap.flash.games.bej3.gems.star
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.events.EventDispatcher;
   
   public class StarGemLogic extends EventDispatcher
   {
       
      
      private var mApp:Blitz3App;
      
      private var mNumCreated:int = 0;
      
      private var mNumDestroyed:int = 0;
      
      public function StarGemLogic(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function get numCreated() : int
      {
         return this.mNumCreated;
      }
      
      public function get numDestroyed() : int
      {
         return this.mNumDestroyed;
      }
      
      public function decrementNumCreated() : void
      {
         --this.mNumCreated;
      }
      
      public function Reset() : void
      {
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
      }
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_STAR)
         {
            return;
         }
         gem.isDetonating = true;
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_STAR)
         {
            return;
         }
         if(gem.isDetonated)
         {
            gem.isDead = true;
         }
         else
         {
            gem.isDetonating = true;
         }
      }
      
      public function HandleDetonatedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_STAR)
         {
            return;
         }
         this.DetonateGem(gem);
      }
      
      public function HandleMatch(match:Match) : void
      {
         var overlap:Match = null;
         var row:int = 0;
         var col:int = 0;
         var gem:Gem = null;
         var isVertical:Boolean = match.mLeft == match.mRight;
         if(isVertical)
         {
            return;
         }
         var overlaps:Vector.<Match> = match.mOverlaps;
         var numOverlaps:int = overlaps.length;
         for(var k:int = 0; k < numOverlaps; k++)
         {
            overlap = overlaps[k];
            row = 0;
            col = 0;
            col = overlap.mLeft;
            row = match.mTop;
            gem = this.mApp.logic.board.GetGemAt(row,col);
            this.UpgradeGem(gem,match,overlap);
         }
      }
      
      public function UpgradeGem(locus:Gem, matchA:Match, matchB:Match, forced:Boolean = false) : void
      {
         if(locus == null)
         {
            return;
         }
         ++this.mNumCreated;
         ++this.mApp.logic.moves[locus.mMoveId].starsMade;
         locus.upgrade(Gem.TYPE_STAR,forced);
         var event:StarGemCreateEvent = new StarGemCreateEvent(locus,matchA,matchB);
         this.mApp.logic.AddPassiveEvent(event);
         dispatchEvent(event);
      }
      
      private function DetonateGem(locus:Gem) : void
      {
         ++this.mNumDestroyed;
         ++this.mApp.logic.moves[locus.mMoveId].starsUsed;
         locus.baseValue = 0;
         var event:StarGemExplodeEvent = new StarGemExplodeEvent(locus,this.mApp.logic);
         this.mApp.logic.AddBlockingEvent(event);
         dispatchEvent(event);
      }
   }
}
