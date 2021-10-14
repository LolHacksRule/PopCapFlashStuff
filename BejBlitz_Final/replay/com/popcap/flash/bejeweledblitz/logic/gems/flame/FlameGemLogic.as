package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class FlameGemLogic
   {
      
      public static const GEMS_NEEDED:int = 4;
      
      public static const FUSE_TIME:int = 15;
       
      
      private var m_ForcedExplosions:Vector.<Boolean>;
      
      private var m_Logic:BlitzLogic;
      
      private var mTempGems:Vector.<Gem>;
      
      private var mNumCreated:int;
      
      private var mNumDestroyed:int;
      
      private var m_CreateEventPool:FlameGemCreateEventPool;
      
      private var m_ExplodeEventPool:FlameGemExplodeEventPool;
      
      private var m_Handlers:Vector.<IFlameGemLogicHandler>;
      
      public function FlameGemLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.mTempGems = new Vector.<Gem>();
         this.m_ForcedExplosions = new Vector.<Boolean>();
         this.m_CreateEventPool = new FlameGemCreateEventPool();
         this.m_Logic.lifeguard.AddPool(this.m_CreateEventPool);
         this.m_ExplodeEventPool = new FlameGemExplodeEventPool(logic);
         this.m_Logic.lifeguard.AddPool(this.m_ExplodeEventPool);
         this.m_Handlers = new Vector.<IFlameGemLogicHandler>();
      }
      
      public function AddHandler(handler:IFlameGemLogicHandler) : void
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
         this.m_ForcedExplosions.length = 0;
         this.mTempGems.length = 0;
      }
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_FLAME)
         {
            return;
         }
         gem.SetDetonating(true);
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_FLAME)
         {
            return;
         }
         gem.SetFuseTime(FUSE_TIME);
      }
      
      public function HandleDetonatedGem(gem:Gem) : void
      {
         if(gem.id < this.m_ForcedExplosions.length && this.m_ForcedExplosions[gem.id] == true)
         {
            this.m_ForcedExplosions[gem.id] = false;
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
         if(match.matchGems.length != GEMS_NEEDED)
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
            if(!(!gem.IsMatching() && !gem.IsElectric() || gem.type >= Gem.TYPE_FLAME))
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
            ++this.m_Logic.moves[locus.mMoveId].flamesMade;
         }
         locus.upgrade(Gem.TYPE_FLAME,forced);
         var event:FlameGemCreateEvent = this.m_CreateEventPool.GetNextFlameGemCreateEvent(locus,match);
         this.m_Logic.AddPassiveEvent(event);
         this.DispatchFlameGemCreated(event);
      }
      
      public function ExplodeGem(locus:Gem) : void
      {
         var g:Gem = null;
         var event:FlameGemExplodeEvent = null;
         this.m_Logic.AddScore(100);
         this.mTempGems.length = 0;
         this.m_Logic.board.GetArea(locus.x,locus.y,1.5,this.mTempGems);
         this.m_Logic.bumpColumns(locus.x,locus.y,1);
         for each(g in this.mTempGems)
         {
            if(g != locus)
            {
               if(!(g.GetFuseTime() > 0 || g.IsShattered() || g.IsDetonated() || g.IsDead()))
               {
                  this.m_Logic.AddScore(100);
                  g.Shatter(locus);
                  g.mMatchId = locus.mMatchId;
                  if(g.mMoveId < 0)
                  {
                     g.mMoveId = locus.mMoveId;
                  }
                  g.mShatterGemId = locus.id;
                  g.baseValue = Math.max(100,g.baseValue);
               }
            }
         }
         this.m_Logic.AddScore(100);
         locus.SetDead(true);
         event = this.m_ExplodeEventPool.GetNextFlameGemExplodeEvent(locus);
         this.m_Logic.AddPassiveEvent(event);
         this.DispatchFlameGemExploded(event);
      }
      
      public function ForceExplosion(gemID:int) : void
      {
         if(gemID >= this.m_ForcedExplosions.length)
         {
            this.m_ForcedExplosions.length = gemID + 1;
         }
         this.m_ForcedExplosions[gemID] = true;
      }
      
      private function DispatchFlameGemCreated(event:FlameGemCreateEvent) : void
      {
         var handler:IFlameGemLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFlameGemCreated(event);
         }
      }
      
      private function DispatchFlameGemExploded(event:FlameGemExplodeEvent) : void
      {
         var handler:IFlameGemLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFlameGemExploded(event);
         }
      }
      
      private function DetonateGem(locus:Gem) : void
      {
         ++this.mNumDestroyed;
         if(locus.mMoveId > 0)
         {
            ++this.m_Logic.moves[locus.mMoveId].flamesUsed;
         }
         this.ExplodeGem(locus);
      }
   }
}
