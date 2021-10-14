package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class StarGemLogic
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var mNumCreated:int;
      
      private var mNumDestroyed:int;
      
      private var m_CreateEventPool:StarGemCreateEventPool;
      
      private var m_ExplodeEventPool:StarGemExplodeEventPool;
      
      public var delayDataPool:StarGemDelayDataPool;
      
      private var m_Handlers:Vector.<IStarGemLogicHandler>;
      
      private var m_TmpGems:Vector.<Gem>;
      
      public function StarGemLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.m_CreateEventPool = new StarGemCreateEventPool();
         this.m_Logic.lifeguard.AddPool(this.m_CreateEventPool);
         this.m_ExplodeEventPool = new StarGemExplodeEventPool(logic);
         this.m_Logic.lifeguard.AddPool(this.m_ExplodeEventPool);
         this.delayDataPool = new StarGemDelayDataPool();
         this.m_Logic.lifeguard.AddPool(this.delayDataPool);
         this.m_Handlers = new Vector.<IStarGemLogicHandler>();
         this.m_TmpGems = new Vector.<Gem>();
      }
      
      public function AddHandler(handler:IStarGemLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetNumCreated() : int
      {
         return this.mNumCreated;
      }
      
      public function GetNumDestroyed() : int
      {
         return this.mNumDestroyed;
      }
      
      public function Reset() : void
      {
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.m_TmpGems.length = 0;
      }
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_STAR)
         {
            return;
         }
         gem.SetDetonating(true);
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_STAR)
         {
            return;
         }
         if(gem.IsDetonated())
         {
            gem.SetDead(true);
         }
         else
         {
            gem.SetDetonating(true);
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
         var isVertical:Boolean = match.left == match.right;
         if(isVertical)
         {
            return;
         }
         var overlaps:Vector.<Match> = match.overlaps;
         var numOverlaps:int = overlaps.length;
         for(var i:int = 0; i < numOverlaps; i++)
         {
            overlap = overlaps[i];
            row = 0;
            col = 0;
            if(match.matchColor == overlap.matchColor)
            {
               col = overlap.left;
               row = match.top;
               gem = this.m_Logic.board.GetGemAt(row,col);
               if(gem.CanUpgrade(Gem.TYPE_STAR))
               {
                  this.UpgradeGem(gem,match,overlap,false);
               }
               else
               {
                  this.UpgradeAnotherGem(gem,match,overlap);
               }
            }
         }
      }
      
      public function UpgradeGem(locus:Gem, matchA:Match, matchB:Match, forced:Boolean) : void
      {
         if(locus == null)
         {
            return;
         }
         ++this.mNumCreated;
         if(locus.mMoveId > 0)
         {
            ++this.m_Logic.moves[locus.mMoveId].starsMade;
         }
         locus.upgrade(Gem.TYPE_STAR,forced);
         var event:StarGemCreateEvent = this.m_CreateEventPool.GetNextStarGemCreateEvent(locus,matchA,matchB);
         this.m_Logic.AddPassiveEvent(event);
         this.DispatchStarGemCreated(event);
      }
      
      private function DispatchStarGemCreated(event:StarGemCreateEvent) : void
      {
         var handler:IStarGemLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleStarGemCreated(event);
         }
      }
      
      private function DispatchStarGemExploded(event:StarGemExplodeEvent) : void
      {
         var handler:IStarGemLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleStarGemExploded(event);
         }
      }
      
      private function DetonateGem(locus:Gem) : void
      {
         ++this.mNumDestroyed;
         if(locus.mMoveId > 0)
         {
            ++this.m_Logic.moves[locus.mMoveId].starsUsed;
         }
         locus.baseValue = 0;
         var event:StarGemExplodeEvent = this.m_ExplodeEventPool.GetNextStarGemExplodeEvent(locus);
         this.m_Logic.AddBlockingEvent(event);
         this.DispatchStarGemExploded(event);
      }
      
      private function UpgradeAnotherGem(prevLocus:Gem, match1:Match, match2:Match) : void
      {
         var gem1:Gem = null;
         var gem2:Gem = null;
         var locus:Gem = null;
         var gem:Gem = null;
         this.m_TmpGems.length = 0;
         for each(gem1 in match1.matchGems)
         {
            this.m_TmpGems.push(gem1);
         }
         for each(gem2 in match2.matchGems)
         {
            this.m_TmpGems.push(gem2);
         }
         locus = null;
         for each(gem in this.m_TmpGems)
         {
            if(gem.type < Gem.TYPE_STAR)
            {
               if(locus == null)
               {
                  locus = gem;
               }
               if(gem.col < locus.col && gem.col >= prevLocus.col)
               {
                  locus = gem;
               }
               if(gem.col > locus.col && gem.col <= prevLocus.col)
               {
                  locus = gem;
               }
               if(gem.row < locus.row && gem.row >= prevLocus.row)
               {
                  locus = gem;
               }
               if(gem.row > locus.row && gem.row <= prevLocus.row)
               {
                  locus = gem;
               }
               if(gem.activeCount > locus.activeCount)
               {
                  locus = gem;
               }
            }
         }
         this.UpgradeGem(locus,match1,match2,false);
      }
   }
}
