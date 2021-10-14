package com.popcap.flash.bejeweledblitz.logic.gems.hypercube
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class HypercubeExplodeEvent implements IBlitzEvent
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _locus:Gem;
      
      private var _coloredGems:Vector.<Gem>;
      
      private var _matchingGems:Vector.<Gem>;
      
      private var _jumpDatas:Vector.<HypercubeExplodeJumpData>;
      
      private var _totalTime:int;
      
      private var _nextJump:int;
      
      private var _isDone:Boolean;
      
      private var _handlers:Vector.<IHypercubeExplodeEventHandler>;
      
      public function HypercubeExplodeEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._coloredGems = new Vector.<Gem>();
         this._matchingGems = new Vector.<Gem>();
         this._jumpDatas = new Vector.<HypercubeExplodeJumpData>();
         this._handlers = new Vector.<IHypercubeExplodeEventHandler>();
      }
      
      public function AddHandler(param1:IHypercubeExplodeEventHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function GetLocus() : Gem
      {
         return this._locus;
      }
      
      public function GetMatchingGems() : Vector.<Gem>
      {
         return this._matchingGems;
      }
      
      public function Set(param1:Gem) : void
      {
         this._locus = param1;
      }
      
      public function Init() : void
      {
         var _loc3_:HypercubeExplodeJumpData = null;
         var _loc5_:Gem = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = this._locus.shatterColor;
         if(_loc1_ == Gem.COLOR_ANY || _loc1_ == Gem.COLOR_NONE)
         {
            _loc1_ = this._locus.color;
         }
         this._logic.board.GetGemsByColor(_loc1_,this._coloredGems);
         this._coloredGems.push(this._locus);
         this._totalTime = 0;
         var _loc2_:int = this._coloredGems.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_ - 1)
         {
            if((_loc5_ = this._coloredGems[_loc4_]).y >= -1.5)
            {
               if(!(_loc5_.isImmune || _loc5_.immuneTime > 0))
               {
                  if(!(_loc5_.IsDetonated() || _loc5_.IsShattered() || _loc5_.IsDead() || _loc5_.GetFuseTime() > 0))
                  {
                     _loc3_ = this._logic.hypercubeLogic.explodeJumpPool.GetNextHypercubeExplodeJumpData();
                     _loc6_ = 20 / (_loc2_ - _loc4_) + 1 + 5;
                     while(this._logic.GetPrimaryRNG().Int(0,_loc6_) != 0)
                     {
                        ++_loc3_.delayTime;
                     }
                     _loc3_.destroyTime = this._logic.config.hypercubeExplodeEventDestroyDelay;
                     _loc3_.destGem = _loc5_;
                     if(_loc4_ == _loc2_ - 1)
                     {
                        _loc3_.sourceGem = this._locus;
                     }
                     else
                     {
                        _loc7_ = this._logic.GetPrimaryRNG().Int(_loc4_ + 1,_loc2_);
                        if(_loc3_.delayTime < 3)
                        {
                           _loc7_ = _loc4_ + 1;
                        }
                        _loc3_.sourceGem = this._coloredGems[_loc7_];
                     }
                     this._jumpDatas.unshift(_loc3_);
                     this._totalTime += _loc3_.delayTime;
                     _loc5_.matchID = this.GetLocus().matchID;
                     _loc5_.moveID = this.GetLocus().moveID;
                     this._matchingGems.unshift(_loc5_);
                  }
               }
            }
            _loc4_++;
         }
         _loc3_ = this._logic.hypercubeLogic.explodeJumpPool.GetNextHypercubeExplodeJumpData();
         _loc3_.sourceGem = this._locus;
         _loc3_.destGem = this._locus;
         _loc3_.delayTime = this._logic.config.hypercubeExplodeEventDestroyDelay + this._logic.config.hypercubeExplodeEventFinalDelay;
         this._jumpDatas.push(_loc3_);
         this._matchingGems.push(this._locus);
         this._nextJump = 0;
         this.DispatchExplodeBegin();
      }
      
      public function Reset() : void
      {
         this._locus = null;
         this._totalTime = 0;
         this._isDone = false;
         this._nextJump = 0;
         this._coloredGems.length = 0;
         this._matchingGems.length = 0;
         this._jumpDatas.length = 0;
         this._handlers.length = 0;
      }
      
      public function Update(param1:Number) : void
      {
         var _loc2_:HypercubeExplodeJumpData = null;
         if(this._isDone)
         {
            return;
         }
         if(this._nextJump < this._jumpDatas.length)
         {
            _loc2_ = this._jumpDatas[this._nextJump];
            if(_loc2_.delayTime <= 0)
            {
               this.DoNextJump();
               if(this._nextJump >= this._jumpDatas.length)
               {
                  this.DoComplete();
               }
            }
            else
            {
               --_loc2_.delayTime;
            }
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._nextJump)
         {
            _loc2_ = this._jumpDatas[_loc3_];
            if(_loc2_.destroyTime > 0)
            {
               --_loc2_.destroyTime;
               if(_loc2_.destroyTime <= 0)
               {
                  this.DestroyGem(_loc2_.destGem);
               }
            }
            _loc3_++;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this._isDone;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return true;
      }
      
      private function DispatchExplodeBegin() : void
      {
         var _loc1_:IHypercubeExplodeEventHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleHypercubeExplodeBegin(this._totalTime,this._matchingGems);
         }
      }
      
      private function DispatchExplodeEnd() : void
      {
         var _loc1_:IHypercubeExplodeEventHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.HandleHypercubeExplodeEnd();
         }
      }
      
      private function DispatchElectrify(param1:Gem, param2:Gem) : void
      {
         var _loc3_:IHypercubeExplodeEventHandler = null;
         for each(_loc3_ in this._handlers)
         {
            _loc3_.HandleHypercubeElectrify(param1,param2);
         }
      }
      
      private function DoNextJump() : void
      {
         if(this._nextJump >= this._jumpDatas.length)
         {
            return;
         }
         var _loc1_:HypercubeExplodeJumpData = this._jumpDatas[this._nextJump];
         this.DispatchElectrify(_loc1_.sourceGem,_loc1_.destGem);
         ++this._nextJump;
      }
      
      private function DoComplete() : void
      {
         this._isDone = true;
         this.DispatchExplodeEnd();
      }
      
      private function DestroyGem(param1:Gem) : void
      {
         if(param1 != this._locus && (param1.IsDetonated() || param1.IsShattered() || param1.IsDead() || param1.GetFuseTime() > 0))
         {
            return;
         }
         param1.baseValue = this._logic.config.hypercubeExplodeEventGemPoints;
         this._logic.AddScore(this._logic.config.hypercubeExplodeEventGemPoints);
         if(param1 == this._locus)
         {
            param1.ForceShatter(false);
         }
         else if(param1.type == Gem.TYPE_HYPERCUBE)
         {
            param1.BenignDestroy();
            param1.isBenignDestroy = true;
            param1.ForceShatter(false);
         }
         else
         {
            param1.Shatter(this._locus);
         }
      }
   }
}
