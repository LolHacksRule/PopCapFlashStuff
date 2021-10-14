package com.popcap.flash.games.bej3.gems.hypercube
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class HypercubeLogic extends EventDispatcher
   {
      
      public static const GEMS_NEEDED:int = 5;
       
      
      private var mApp:Blitz3App;
      
      private var mNumCreated:int = 0;
      
      private var mNumDestroyed:int = 0;
      
      private var mMoveIds:Dictionary;
      
      public function HypercubeLogic(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function IsHyperMove(moveId:int) : Boolean
      {
         return this.mMoveIds[moveId] == true;
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
         this.mMoveIds = new Dictionary();
      }
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_RAINBOW)
         {
            return;
         }
         gem.isDetonating = true;
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_RAINBOW)
         {
            return;
         }
         if(gem.isDetonated)
         {
            gem.isDead = true;
            return;
         }
         gem.isDetonating = true;
      }
      
      public function HandleDetonatedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_RAINBOW)
         {
            return;
         }
         this.DetonateGem(gem);
      }
      
      public function HandleMatch(match:Match) : void
      {
         var gem:Gem = null;
         if(match.mGems.length < GEMS_NEEDED)
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
            if(gem.type < Gem.TYPE_RAINBOW)
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
         ++this.mApp.logic.moves[locus.mMoveId].hypersMade;
         locus.upgrade(Gem.TYPE_RAINBOW,forced);
         locus.mShatterColor = locus.color;
         locus.isMatchable = false;
         locus.movePolicy.canSwap = false;
         locus.movePolicy.canSwapNorth = false;
         locus.movePolicy.canSwapEast = false;
         locus.movePolicy.canSwapSouth = false;
         locus.movePolicy.canSwapWest = false;
         locus.movePolicy.hasMoves = true;
         locus.movePolicy.hasMoveNorth = true;
         locus.movePolicy.hasMoveEast = true;
         locus.movePolicy.hasMoveSouth = true;
         locus.movePolicy.hasMoveWest = true;
         var event:HypercubeCreateEvent = new HypercubeCreateEvent(locus,match);
         this.mApp.logic.AddPassiveEvent(event);
         dispatchEvent(event);
      }
      
      private function DetonateGem(gem:Gem) : void
      {
         this.mMoveIds[gem.mMoveId] = true;
         ++this.mNumDestroyed;
         ++this.mApp.logic.moves[gem.mMoveId].hypersUsed;
         gem.baseValue = 0;
         var event:HypercubeExplodeEvent = new HypercubeExplodeEvent(this.mApp,gem);
         this.mApp.logic.AddBlockingEvent(event);
         dispatchEvent(event);
      }
   }
}
