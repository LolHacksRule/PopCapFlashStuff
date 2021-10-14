package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemGrid;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class PhoenixPrismHurrahExplodeEvent implements IBlitzEvent
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _grid:GemGrid;
      
      private var _isDone:Boolean;
      
      private var _timer:int;
      
      private var _jumps:Vector.<PhoenixPrismDelayData>;
      
      private var _move:MoveData;
      
      public function PhoenixPrismHurrahExplodeEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._grid = param1.grid;
         this._jumps = new Vector.<PhoenixPrismDelayData>();
      }
      
      public function Set() : void
      {
         var _loc3_:PhoenixPrismDelayData = null;
         var _loc1_:int = this._logic.config.phoenixPrismHurrahExplodeEventStartTime;
         this._move = this._logic.movePool.GetMove();
         this._logic.AddMove(this._move);
         var _loc2_:int = 3;
         while(_loc2_ >= 0)
         {
            _loc3_ = this._logic.phoenixPrismLogic.delayDataPool.GetNextPhoenixPrismDelayData();
            this.GetGems(_loc2_,_loc3_.gems);
            _loc3_.time = _loc1_;
            _loc1_ += this._logic.config.phoenixPrismHurrahExplodeEventJumpTime;
            this._jumps.push(_loc3_);
            _loc2_--;
         }
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this._timer = 0;
         this._isDone = false;
         this._move = null;
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
            for each(_loc4_ in _loc3_)
            {
               this.ShatterGem(_loc4_);
            }
            if(this._jumps.length == 0)
            {
               this._isDone = true;
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
         param1.baseValue = this._logic.config.phoenixPrismHurrahExplodeEventPointValue;
         this._logic.AddScore(this._logic.config.phoenixPrismHurrahExplodeEventPointValue);
         param1.Shatter(param1);
      }
      
      private function GetGems(param1:int, param2:Vector.<Gem>) : void
      {
         param2.length = 0;
         this.TestAndAddGem(param1,param1,param2);
         this.TestAndAddGem(param1,7 - param1,param2);
         this.TestAndAddGem(7 - param1,param1,param2);
         this.TestAndAddGem(7 - param1,7 - param1,param2);
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
         _loc4_.moveID = this._move.id;
         _loc4_.makeElectric();
         param3.push(_loc4_);
      }
   }
}
