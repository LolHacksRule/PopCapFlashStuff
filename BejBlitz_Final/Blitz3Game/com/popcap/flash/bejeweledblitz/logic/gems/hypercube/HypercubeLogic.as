package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class HypercubeLogic
   {
       
      
      public var explodeJumpPool:HypercubeExplodeJumpDataPool;
      
      private var _logic:BlitzLogic;
      
      private var _numCreated:int;
      
      private var _numDestroyed:int;
      
      private var _moveIds:Vector.<Boolean>;
      
      private var _createEventPool:HypercubeCreateEventPool;
      
      private var _explodeEventPool:HypercubeExplodeEventPool;
      
      private var _handlers:Vector.<IHypercubeLogicHandler>;
      
      public function HypercubeLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._numCreated = 0;
         this._numDestroyed = 0;
         this._moveIds = new Vector.<Boolean>();
         this._createEventPool = new HypercubeCreateEventPool(param1);
         this._logic.lifeguard.AddPool(this._createEventPool);
         this._explodeEventPool = new HypercubeExplodeEventPool(param1);
         this._logic.lifeguard.AddPool(this._explodeEventPool);
         this.explodeJumpPool = new HypercubeExplodeJumpDataPool();
         this._logic.lifeguard.AddPool(this.explodeJumpPool);
         this._handlers = new Vector.<IHypercubeLogicHandler>();
      }
      
      public function AddHandler(param1:IHypercubeLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IHypercubeLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function IsHyperMove(param1:int) : Boolean
      {
         return param1 < this._moveIds.length && this._moveIds[param1] == true;
      }
      
      public function GetNumCreated() : int
      {
         return this._numCreated;
      }
      
      public function GetNumDestroyed() : int
      {
         return this._numDestroyed;
      }
      
      public function Reset() : void
      {
         this._numCreated = 0;
         this._numDestroyed = 0;
         this._moveIds.length = 0;
      }
      
      public function HandleMatchedGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_HYPERCUBE)
         {
            return;
         }
         param1.SetDetonating(true);
      }
      
      public function HandleShatteredGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_HYPERCUBE)
         {
            return;
         }
         if(param1.IsDetonated())
         {
            param1.SetDead(true);
            return;
         }
         param1.SetDetonating(true);
      }
      
      public function HandleDetonatedGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_HYPERCUBE)
         {
            return;
         }
         this.DetonateGem(param1);
      }
      
      public function HandleMatch(param1:Match) : void
      {
         var _loc8_:Gem = null;
         if(param1.matchGems.length < this._logic.config.hypercubeLogicGemsNeeded)
         {
            return;
         }
         var _loc2_:Vector.<Gem> = param1.matchGems;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = Math.floor((param1.right - param1.left) * 0.5) + param1.left;
         var _loc5_:int = Math.floor((param1.bottom - param1.top) * 0.5) + param1.top;
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            if(!((_loc8_ = _loc2_[_loc7_]).type >= Gem.TYPE_HYPERCUBE || this._logic.rareGemTokenLogic.GemHasRareGemGiftToken(_loc8_)))
            {
               if(_loc6_ == null)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.col < _loc6_.col && _loc8_.col >= _loc4_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.col > _loc6_.col && _loc8_.col <= _loc4_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.row < _loc6_.row && _loc8_.row >= _loc5_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.row > _loc6_.row && _loc8_.row <= _loc5_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.activeCount > _loc6_.activeCount)
               {
                  _loc6_ = _loc8_;
               }
            }
            _loc7_++;
         }
         this.UpgradeGem(_loc6_,param1,false);
      }
      
      public function UpgradeGem(param1:Gem, param2:Match, param3:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         ++this._numCreated;
         if(param1.moveID > 0)
         {
            ++this._logic.moves[param1.moveID].hypersMade;
         }
         param1.upgrade(Gem.TYPE_HYPERCUBE,param3);
         param1.shatterColor = param1.color;
         param1.isMatchable = false;
         param1.movePolicy.canSwap = false;
         param1.movePolicy.canSwapNorth = false;
         param1.movePolicy.canSwapEast = false;
         param1.movePolicy.canSwapSouth = false;
         param1.movePolicy.canSwapWest = false;
         param1.movePolicy.hasMoves = true;
         param1.movePolicy.hasMoveNorth = true;
         param1.movePolicy.hasMoveEast = true;
         param1.movePolicy.hasMoveSouth = true;
         param1.movePolicy.hasMoveWest = true;
         var _loc4_:HypercubeCreateEvent = this._createEventPool.GetNextHypercubeCreateEvent(param1,param2);
         this._logic.AddPassiveEvent(_loc4_);
         this.DispatchHypercubeCreated(_loc4_);
      }
      
      public function doubleHypercubeMatch() : void
      {
         ++this._numDestroyed;
      }
      
      private function DispatchHypercubeCreated(param1:HypercubeCreateEvent) : void
      {
         var _loc2_:IHypercubeLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleHypercubeCreated(param1);
         }
      }
      
      private function DispatchHypercubeExploded(param1:HypercubeExplodeEvent) : void
      {
         var _loc2_:IHypercubeLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleHypercubeExploded(param1);
         }
      }
      
      private function DetonateGem(param1:Gem) : void
      {
         if(param1.moveID >= this._moveIds.length)
         {
            this._moveIds.length = param1.moveID + 1;
         }
         if(param1.moveID > 0)
         {
            this._moveIds[param1.moveID] = true;
         }
         ++this._numDestroyed;
         if(param1.moveID > 0)
         {
            ++this._logic.moves[param1.moveID].hypersUsed;
         }
         param1.baseValue = 0;
         var _loc2_:HypercubeExplodeEvent = this._explodeEventPool.GetNextHypercubeExplodeEvent(param1);
         this._logic.AddBlockingEvent(_loc2_);
         this.DispatchHypercubeExploded(_loc2_);
      }
   }
}
