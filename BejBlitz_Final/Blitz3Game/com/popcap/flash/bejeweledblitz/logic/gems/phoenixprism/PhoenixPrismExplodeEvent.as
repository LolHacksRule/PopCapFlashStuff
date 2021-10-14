package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemGrid;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class PhoenixPrismExplodeEvent implements IBlitzEvent
   {
       
      
      private var _locus:Gem;
      
      private var _logic:BlitzLogic;
      
      private var _grid:GemGrid;
      
      private var _isDone:Boolean;
      
      private var _timer:int;
      
      private var _jumps:Vector.<PhoenixPrismDelayData>;
      
      public function PhoenixPrismExplodeEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._grid = param1.grid;
         this._jumps = new Vector.<PhoenixPrismDelayData>();
         this.Reset();
      }
      
      public function GetLocus() : Gem
      {
         return this._locus;
      }
      
      public function Set(param1:Gem) : void
      {
         var _loc2_:int = 1;
         var _loc3_:int = this._logic.config.phoenixPrismExplodeEventStartTime;
         var _loc4_:* = false;
         this._locus = param1;
         var _loc5_:PhoenixPrismDelayData;
         (_loc5_ = this._logic.phoenixPrismLogic.delayDataPool.GetNextPhoenixPrismDelayData()).gems.length = 0;
         _loc5_.gems.push(this._locus);
         _loc5_.time = _loc3_;
         this._jumps.push(_loc5_);
         _loc3_ += this._logic.config.phoenixPrismExplodeEventJumpTime;
         while(!_loc4_)
         {
            (_loc5_ = this._logic.phoenixPrismLogic.delayDataPool.GetNextPhoenixPrismDelayData()).time = _loc3_;
            _loc4_ = !this.GetGems(_loc2_,_loc5_.gems);
            _loc5_.isDone = _loc4_;
            this._jumps.push(_loc5_);
            _loc2_++;
            _loc3_ += this._logic.config.phoenixPrismExplodeEventJumpTime;
         }
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this._locus = null;
         this._timer = 0;
         this._isDone = false;
         this._logic.phoenixPrismLogic.delayDataPool.FreePhoenixPrismDelayDatas(this._jumps);
      }
      
      public function Update(param1:Number) : void
      {
         var _loc3_:Vector.<Gem> = null;
         var _loc4_:Gem = null;
         if(this._isDone == true)
         {
            return;
         }
         ++this._timer;
         var _loc2_:PhoenixPrismDelayData = this._jumps[0];
         if(_loc2_.time == this._timer)
         {
            _loc2_ = this._jumps.shift();
            _loc3_ = _loc2_.gems;
            if(_loc2_.isDone)
            {
               this.ShatterGem(this._locus);
               this._isDone = true;
            }
            else
            {
               for each(_loc4_ in _loc3_)
               {
                  this.ShatterGem(_loc4_);
               }
            }
            this._logic.phoenixPrismLogic.delayDataPool.FreePhoenixPrismDelayData(_loc2_);
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
      
      private function ShatterGem(param1:Gem) : void
      {
         param1.baseValue = this._logic.config.phoenixPrismExplodeEventPointValue;
         this._logic.AddScore(this._logic.config.phoenixPrismExplodeEventPointValue);
         if(param1 == this._locus)
         {
            param1.ForceShatter(false);
         }
         else
         {
            param1.Shatter(this._locus);
            param1.matchID = this._locus.matchID;
            param1.shatterGemID = this._locus.id;
         }
      }
      
      private function GetGems(param1:int, param2:Vector.<Gem>) : Boolean
      {
         param2.length = 0;
         var _loc3_:int = this._locus.y;
         var _loc4_:int;
         var _loc5_:int = (_loc4_ = this._locus.x) - param1;
         var _loc6_:int = _loc4_ + param1;
         var _loc7_:int = _loc3_ - param1;
         var _loc8_:int = _loc3_ + param1;
         if(this.IsOffBoard(_loc7_,_loc5_) && this.IsOffBoard(_loc7_,_loc6_) && this.IsOffBoard(_loc8_,_loc6_) && this.IsOffBoard(_loc8_,_loc5_))
         {
            return false;
         }
         this.TestAndAddGem(_loc7_,_loc5_,param2);
         this.TestAndAddGem(_loc7_,_loc6_,param2);
         this.TestAndAddGem(_loc8_,_loc6_,param2);
         this.TestAndAddGem(_loc8_,_loc5_,param2);
         return true;
      }
      
      private function IsOffBoard(param1:int, param2:int) : Boolean
      {
         if(param1 > Board.BOTTOM || param1 < Board.TOP)
         {
            return true;
         }
         if(param2 < Board.LEFT || param2 > Board.RIGHT)
         {
            return true;
         }
         return false;
      }
      
      private function TestAndAddGem(param1:int, param2:int, param3:Vector.<Gem>) : void
      {
         var _loc4_:Gem;
         if((_loc4_ = this._grid.getGem(param1,param2)) == null)
         {
            return;
         }
         if(_loc4_.type == Gem.TYPE_DETONATE || _loc4_.type == Gem.TYPE_SCRAMBLE)
         {
            return;
         }
         if(_loc4_.isImmune || _loc4_.immuneTime > 0)
         {
            return;
         }
         if(_loc4_.IsDead() || _loc4_.IsShattered() || _loc4_.IsDetonated() || _loc4_.GetFuseTime() > 0)
         {
            return;
         }
         _loc4_.makeElectric();
         param3.push(_loc4_);
      }
   }
}
