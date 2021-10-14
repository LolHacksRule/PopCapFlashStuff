package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class HypercubeLogic
   {
      
      public static const GEMS_NEEDED:int = 5;
       
      
      private var m_Logic:BlitzLogic;
      
      private var mNumCreated:int;
      
      private var mNumDestroyed:int;
      
      private var m_MoveIds:Vector.<Boolean>;
      
      private var m_CreateEventPool:HypercubeCreateEventPool;
      
      private var m_ExplodeEventPool:HypercubeExplodeEventPool;
      
      private var m_Handlers:Vector.<IHypercubeLogicHandler>;
      
      public function HypercubeLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.m_MoveIds = new Vector.<Boolean>();
         this.m_CreateEventPool = new HypercubeCreateEventPool();
         this.m_Logic.lifeguard.AddPool(this.m_CreateEventPool);
         this.m_ExplodeEventPool = new HypercubeExplodeEventPool(logic);
         this.m_Logic.lifeguard.AddPool(this.m_ExplodeEventPool);
         this.m_Handlers = new Vector.<IHypercubeLogicHandler>();
      }
      
      public function AddHandler(handler:IHypercubeLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function IsHyperMove(moveId:int) : Boolean
      {
         return moveId < this.m_MoveIds.length && this.m_MoveIds[moveId] == true;
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
         this.m_MoveIds.length = 0;
      }
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_HYPERCUBE)
         {
            return;
         }
         gem.SetDetonating(true);
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_HYPERCUBE)
         {
            return;
         }
         if(gem.IsDetonated())
         {
            gem.SetDead(true);
            return;
         }
         gem.SetDetonating(true);
      }
      
      public function HandleDetonatedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_HYPERCUBE)
         {
            return;
         }
         this.DetonateGem(gem);
      }
      
      public function HandleMatch(match:Match) : void
      {
         var gem:Gem = null;
         if(match.matchGems.length < GEMS_NEEDED)
         {
            return;
         }
         var gems:Vector.<Gem> = match.matchGems;
         var numGems:int = gems.length;
         var matchCol:int = Math.floor((match.right - match.left) * 0.5) + match.left;
         var matchRow:int = Math.floor((match.bottom - match.top) * 0.5) + match.top;
         var locus:Gem = null;
         for(var k:int = 0; k < numGems; k++)
         {
            gem = gems[k];
            if(gem.type < Gem.TYPE_HYPERCUBE)
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
         this.UpgradeGem(locus,match,false);
      }
      
      public function UpgradeGem(locus:Gem, match:Match, forced:Boolean) : void
      {
         if(locus == null)
         {
            return;
         }
         ++this.mNumCreated;
         if(locus.mMoveId > 0)
         {
            ++this.m_Logic.moves[locus.mMoveId].hypersMade;
         }
         locus.upgrade(Gem.TYPE_HYPERCUBE,forced);
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
         var event:HypercubeCreateEvent = this.m_CreateEventPool.GetNextHypercubeCreateEvent(locus,match);
         this.m_Logic.AddPassiveEvent(event);
         this.DispatchHypercubeCreated(event);
      }
      
      private function DispatchHypercubeCreated(event:HypercubeCreateEvent) : void
      {
         var handler:IHypercubeLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleHypercubeCreated(event);
         }
      }
      
      private function DispatchHypercubeExploded(event:HypercubeExplodeEvent) : void
      {
         var handler:IHypercubeLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleHypercubeExploded(event);
         }
      }
      
      private function DetonateGem(gem:Gem) : void
      {
         if(gem.mMoveId >= this.m_MoveIds.length)
         {
            this.m_MoveIds.length = gem.mMoveId + 1;
         }
         if(gem.mMoveId > 0)
         {
            this.m_MoveIds[gem.mMoveId] = true;
         }
         ++this.mNumDestroyed;
         if(gem.mMoveId > 0)
         {
            ++this.m_Logic.moves[gem.mMoveId].hypersUsed;
         }
         gem.baseValue = 0;
         var event:HypercubeExplodeEvent = this.m_ExplodeEventPool.GetNextHypercubeExplodeEvent(gem);
         this.m_Logic.AddBlockingEvent(event);
         this.DispatchHypercubeExploded(event);
      }
   }
}
