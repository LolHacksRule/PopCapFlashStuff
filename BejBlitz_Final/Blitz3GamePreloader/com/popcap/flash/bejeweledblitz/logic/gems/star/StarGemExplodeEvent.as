package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemGrid;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class StarGemExplodeEvent implements IBlitzEvent
   {
       
      
      private var _locus:Gem;
      
      private var _logic:BlitzLogic;
      
      private var _grid:GemGrid;
      
      private var _isDone:Boolean;
      
      private var _timer:int;
      
      private var _index:int;
      
      private var _jumps:Vector.<StarGemDelayData>;
      
      public function StarGemExplodeEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._grid = this._logic.grid;
         this._jumps = new Vector.<StarGemDelayData>();
      }
      
      public function GetLocus() : Gem
      {
         return this._locus;
      }
      
      public function Set(param1:Gem) : void
      {
         var _loc5_:StarGemDelayData = null;
         this._locus = param1;
         var _loc2_:int = 1;
         var _loc3_:int = this._logic.config.starGemExplodeEventStartTime;
         var _loc4_:* = false;
         while(!_loc4_)
         {
            (_loc5_ = this._logic.starGemLogic.delayDataPool.GetNextStarGemDelayData()).time = _loc3_;
            _loc4_ = !this.ElectrocuteRange(_loc2_,_loc5_.gems);
            _loc5_.isDone = _loc4_;
            this._jumps.push(_loc5_);
            _loc2_++;
            _loc3_ += this._logic.config.starGemExplodeEventJumpTime;
         }
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this._locus = null;
         this._isDone = false;
         this._timer = 0;
         this._index = 0;
         this._logic.starGemLogic.delayDataPool.FreeStarGemDelayDatas(this._jumps);
      }
      
      public function Update(param1:Number) : void
      {
         var _loc3_:StarGemDelayData = null;
         var _loc4_:Vector.<Gem> = null;
         var _loc5_:Gem = null;
         if(this._isDone == true)
         {
            return;
         }
         ++this._timer;
         var _loc2_:StarGemDelayData = this._jumps[0];
         if(_loc2_.time == this._timer)
         {
            _loc3_ = this._jumps.shift();
            _loc4_ = _loc2_.gems;
            if(_loc3_.isDone)
            {
               this.ShatterGem(this._locus);
               this._isDone = true;
            }
            else
            {
               for each(_loc5_ in _loc4_)
               {
                  this.ShatterGem(_loc5_);
               }
            }
            this._logic.starGemLogic.delayDataPool.FreeStarGemDelayData(_loc3_);
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
         param1.baseValue = this._logic.config.starGemExplodeEventPointValue;
         this._logic.AddScore(this._logic.config.starGemExplodeEventPointValue);
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
         if(this._logic.rareGemTokenLogic.GemHasRareGemGiftToken(param1) && !param1.isImmune)
         {
            param1.isImmune = true;
            this._logic.rareGemTokenLogic.DetonateFlameGem(param1);
         }
      }
      
      private function ElectrocuteRange(param1:int, param2:Vector.<Gem>) : Boolean
      {
         var _loc3_:int = this._locus.y;
         var _loc4_:int;
         var _loc5_:int = (_loc4_ = this._locus.x) - param1;
         var _loc6_:int = _loc4_ + param1;
         var _loc7_:int = _loc3_ - param1;
         var _loc8_:int = _loc3_ + param1;
         param2.length = 0;
         if(_loc5_ < Board.LEFT && _loc6_ > Board.RIGHT && _loc7_ < Board.TOP && _loc8_ > Board.BOTTOM)
         {
            return false;
         }
         this.TestAndAddGem(_loc3_,_loc5_,param2);
         this.TestAndAddGem(_loc3_,_loc6_,param2);
         this.TestAndAddGem(_loc7_,_loc4_,param2);
         this.TestAndAddGem(_loc8_,_loc4_,param2);
         return true;
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
