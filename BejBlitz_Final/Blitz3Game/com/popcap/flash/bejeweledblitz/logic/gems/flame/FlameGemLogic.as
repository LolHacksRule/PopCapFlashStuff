package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.RareGemToken;
   
   public class FlameGemLogic
   {
       
      
      private var _forcedExplosions:Vector.<Boolean>;
      
      private var _logic:BlitzLogic;
      
      private var _tempGems:Vector.<Gem>;
      
      private var _numCreated:int;
      
      private var _numDestroyed:int;
      
      private var _numRareGemDestroyed:int;
      
      private var _createEventPool:FlameGemCreateEventPool;
      
      private var _explodeEventPool:FlameGemExplodeEventPool;
      
      private var _handlers:Vector.<IFlameGemLogicHandler>;
      
      public function FlameGemLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._numCreated = 0;
         this._numDestroyed = 0;
         this._numRareGemDestroyed = 0;
         this._tempGems = new Vector.<Gem>();
         this._forcedExplosions = new Vector.<Boolean>();
         this._handlers = new Vector.<IFlameGemLogicHandler>();
      }
      
      public function SetupEvents() : void
      {
         this._createEventPool = new FlameGemCreateEventPool(this._logic);
         this._logic.lifeguard.AddPool(this._createEventPool);
         this._explodeEventPool = new FlameGemExplodeEventPool(this._logic);
         this._logic.lifeguard.AddPool(this._explodeEventPool);
      }
      
      public function AddHandler(param1:IFlameGemLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IFlameGemLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function GetNumCreated() : int
      {
         return this._numCreated;
      }
      
      public function GetNumRareGemDestroyed() : int
      {
         return this._numRareGemDestroyed;
      }
      
      public function GetNumDestroyed() : int
      {
         return this._numDestroyed;
      }
      
      public function Reset() : void
      {
         this._numCreated = 0;
         this._numDestroyed = 0;
         this._numRareGemDestroyed = 0;
         this._forcedExplosions.length = 0;
         this._tempGems.length = 0;
      }
      
      public function HandleMatchedGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_FLAME)
         {
            return;
         }
         param1.SetDetonating(true);
      }
      
      public function HandleShatteredGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_FLAME)
         {
            return;
         }
         param1.SetFuseTime(this._logic.config.flameGemLogicFuseTime);
      }
      
      public function HandleDetonatedGem(param1:Gem) : void
      {
         if(param1.id < this._forcedExplosions.length && this._forcedExplosions[param1.id] == true)
         {
            this._forcedExplosions[param1.id] = false;
            this.ExplodeGem(param1);
         }
         if(param1.type != Gem.TYPE_FLAME)
         {
            return;
         }
         this.DetonateGem(param1);
      }
      
      public function HandleMatch(param1:Match) : void
      {
         var _loc8_:Gem = null;
         if(param1.matchGems.length != this._logic.config.flameGemLogicGemsNeeded)
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
            if(!((_loc8_ = _loc2_[_loc7_]).type >= Gem.TYPE_FLAME || this._logic.rareGemTokenLogic.GemHasRareGemGiftToken(_loc8_)))
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
      
      public function isRareGem(param1:Gem) : Boolean
      {
         return RareGemToken.KEY in param1.rgTokens || this._logic.rareGemsLogic != null && this._logic.rareGemsLogic.currentRareGem != null && this._logic.rareGemsLogic.currentRareGem.getFlameColor() == param1.color;
      }
      
      public function UpgradeGem(param1:Gem, param2:Match, param3:Boolean) : void
      {
         var _loc4_:FlameGemCreateEvent = null;
         if(param1 != null)
         {
            ++this._numCreated;
            if(param1.moveID > 0)
            {
               ++this._logic.moves[param1.moveID].flamesMade;
            }
            param1.upgrade(Gem.TYPE_FLAME,param3);
            _loc4_ = this._createEventPool.GetNextFlameGemCreateEvent(param1,param2,param3);
            this._logic.AddPassiveEvent(_loc4_);
            this.DispatchFlameGemCreated(_loc4_);
         }
      }
      
      public function ExplodeGem(param1:Gem) : void
      {
         var _loc3_:Gem = null;
         this._logic.AddScore(this._logic.config.flameGemLogicMatchPointBonus);
         this._tempGems.length = 0;
         this._logic.board.GetArea(param1.x,param1.y,this._logic.config.flameGemLogicExplosionRange,this._tempGems);
         this.DispatchFlameGemExplosionRange(param1,this._tempGems);
         this._logic.bumpColumns(param1.x,param1.y,this._logic.config.flameGemLogicBumpVel);
         var _loc2_:int = this._logic.config.flameGemLogicGemPointValue;
         for each(_loc3_ in this._tempGems)
         {
            if(_loc3_ != param1)
            {
               if(!(_loc3_.GetFuseTime() > 0 || _loc3_.IsShattered() || _loc3_.IsDetonated() || _loc3_.IsDead() || _loc3_.isImmune))
               {
                  this._logic.AddScore(_loc2_);
                  _loc3_.Shatter(param1);
                  _loc3_.matchID = param1.matchID;
                  if(_loc3_.moveID < 0)
                  {
                     _loc3_.moveID = param1.moveID;
                  }
                  _loc3_.shatterGemID = param1.id;
                  _loc3_.baseValue = Math.max(_loc2_,_loc3_.baseValue);
               }
            }
         }
         this._logic.AddScore(_loc2_);
         if(!param1.isImmune)
         {
            param1.SetDead(true);
         }
         var _loc4_:FlameGemExplodeEvent = this._explodeEventPool.GetNextFlameGemExplodeEvent(param1);
         this._logic.AddPassiveEvent(_loc4_);
         this.DispatchFlameGemExploded(_loc4_);
      }
      
      public function ForceExplosion(param1:int) : void
      {
         if(param1 >= this._forcedExplosions.length)
         {
            this._forcedExplosions.length = param1 + 1;
         }
         this._forcedExplosions[param1] = true;
      }
      
      private function DispatchFlameGemCreated(param1:FlameGemCreateEvent) : void
      {
         var _loc2_:IFlameGemLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.handleFlameGemCreated(param1);
         }
      }
      
      private function DispatchFlameGemExploded(param1:FlameGemExplodeEvent) : void
      {
         var _loc2_:IFlameGemLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.handleFlameGemExploded(param1);
         }
      }
      
      private function DispatchFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void
      {
         var _loc3_:IFlameGemLogicHandler = null;
         for each(_loc3_ in this._handlers)
         {
            _loc3_.handleFlameGemExplosionRange(param1,param2);
         }
      }
      
      private function DetonateGem(param1:Gem) : void
      {
         if(this.isRareGem(param1))
         {
            ++this._numRareGemDestroyed;
         }
         else
         {
            ++this._numDestroyed;
         }
         if(param1.moveID > 0)
         {
            ++this._logic.moves[param1.moveID].flamesUsed;
         }
         this.ExplodeGem(param1);
      }
   }
}
