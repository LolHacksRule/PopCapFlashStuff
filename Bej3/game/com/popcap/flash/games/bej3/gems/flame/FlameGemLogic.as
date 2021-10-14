package com.popcap.flash.games.bej3.gems.flame
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class FlameGemLogic extends EventDispatcher
   {
      
      public static const GEMS_NEEDED:int = 4;
      
      public static const FUSE_TIME:int = 15;
       
      
      public var forcedExplosions:Dictionary;
      
      private var mApp:Blitz3App;
      
      private var mTempGems:Vector.<Gem>;
      
      private var mNumCreated:int = 0;
      
      private var mNumDestroyed:int = 0;
      
      public function FlameGemLogic(app:Blitz3App)
      {
         super();
         this.mApp = app;
         this.mTempGems = new Vector.<Gem>();
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
         this.forcedExplosions = new Dictionary();
      }
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_FLAME)
         {
            return;
         }
         gem.isDetonating = true;
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_FLAME)
         {
            return;
         }
         gem.fuseTime = FUSE_TIME;
      }
      
      public function HandleDetonatedGem(gem:Gem) : void
      {
         if(this.forcedExplosions[gem.id] == true)
         {
            this.forcedExplosions[gem.id] = false;
            this.ExplodeGem(gem);
         }
         if(gem.type != Gem.TYPE_FLAME)
         {
            return;
         }
         this.DetonateGem(gem);
      }
      
      public function HandleMatch(match:Match) : void
      {
         var gem:Gem = null;
         if(match.mGems.length != GEMS_NEEDED)
         {
            return;
         }
         var gems:Vector.<Gem> = match.mGems;
         var numGems:int = gems.length;
         var matchCol:int = int((match.mRight - match.mLeft) / 2) + match.mLeft;
         var matchRow:int = int((match.mBottom - match.mTop) / 2) + match.mTop;
         var locus:Gem = null;
         for(var k:int = 0; k < numGems; k++)
         {
            gem = gems[k];
            if(!(!gem.isMatching && !gem.isElectric || gem.type >= Gem.TYPE_FLAME))
            {
               if(locus == null)
               {
                  locus = gem;
               }
               if(gem.col < locus.col && gem.col >= matchCol)
               {
                  locus = gem;
               }
               if(gem.col > locus.col && gem.col <= matchCol)
               {
                  locus = gem;
               }
               if(gem.row < locus.row && gem.row >= matchRow)
               {
                  locus = gem;
               }
               if(gem.row > locus.row && gem.row <= matchRow)
               {
                  locus = gem;
               }
               if(gem.activeCount > locus.activeCount)
               {
                  locus = gem;
               }
            }
         }
         this.UpgradeGem(locus,match);
      }
      
      public function UpgradeGem(locus:Gem, match:Match, forced:Boolean = false) : void
      {
         if(locus == null)
         {
            return;
         }
         ++this.mNumCreated;
         ++this.mApp.logic.moves[locus.mMoveId].flamesMade;
         locus.upgrade(Gem.TYPE_FLAME,forced);
         var event:FlameGemCreateEvent = new FlameGemCreateEvent(locus,match);
         this.mApp.logic.AddPassiveEvent(event);
         dispatchEvent(event);
      }
      
      public function ExplodeGem(locus:Gem) : void
      {
         var g:Gem = null;
         var event:FlameGemExplodeEvent = null;
         this.mApp.logic.AddScore(100);
         this.mTempGems.length = 0;
         this.mApp.logic.board.GetArea(locus.x,locus.y,1.5,this.mTempGems);
         this.mApp.logic.bumpColumns(locus.x,locus.y,1);
         for each(g in this.mTempGems)
         {
            if(g != locus)
            {
               if(!(g.fuseTime > 0 || g.isShattered || g.isDetonated || g.isDead))
               {
                  this.mApp.logic.AddScore(25);
                  g.Shatter(locus);
                  g.mMatchId = locus.mMatchId;
                  g.mShatterGemId = locus.id;
                  g.baseValue = Math.max(25,g.baseValue);
               }
            }
         }
         this.mApp.logic.AddScore(50);
         locus.isDead = true;
         event = new FlameGemExplodeEvent(locus,this.mApp.logic);
         this.mApp.logic.AddPassiveEvent(event);
         dispatchEvent(event);
      }
      
      private function DetonateGem(locus:Gem) : void
      {
         ++this.mNumDestroyed;
         ++this.mApp.logic.moves[locus.mMoveId].flamesUsed;
         this.ExplodeGem(locus);
      }
   }
}
