package com.popcap.flash.bejeweledblitz.logic.gems.scramble
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MatchSet;
   import com.popcap.flash.bejeweledblitz.logic.Point2D;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class ScrambleEvent implements IBlitzEvent
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _timer:int;
      
      private var _isInited:Boolean;
      
      private var _isDone:Boolean;
      
      private var _matches:Vector.<MatchSet>;
      
      private var _oldGems:Vector.<Gem>;
      
      private var _oldPos:Vector.<Point2D>;
      
      private var _newPos:Vector.<Point2D>;
      
      public function ScrambleEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._timer = this._logic.config.scrambleEventSwapTime;
         this._matches = new Vector.<MatchSet>();
         this._oldGems = new Vector.<Gem>();
         this._oldPos = new Vector.<Point2D>();
         this._newPos = new Vector.<Point2D>();
      }
      
      public function Init() : void
      {
         if(this._isInited)
         {
            return;
         }
         this.CalcScramble();
         this._isInited = true;
      }
      
      public function Reset() : void
      {
         this._oldGems.length = 0;
         this._matches.length = 0;
         this._logic.point2DPool.FreePoint2Ds(this._oldPos);
         this._logic.point2DPool.FreePoint2Ds(this._newPos);
         this._timer = this._logic.config.scrambleEventSwapTime;
         this._isInited = false;
         this._isDone = false;
      }
      
      public function Update(param1:Number) : void
      {
         var _loc6_:Gem = null;
         var _loc7_:Point2D = null;
         var _loc8_:Point2D = null;
         if(this._isDone == true)
         {
            return;
         }
         --this._timer;
         var _loc2_:Number = 1 - this._timer / this._logic.config.scrambleEventSwapTime;
         var _loc3_:Vector.<Gem> = this._logic.board.mGems;
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = _loc3_[_loc5_]) != null)
            {
               _loc7_ = this._oldPos[_loc6_.id];
               _loc8_ = this._newPos[_loc6_.id];
               _loc6_.x = this.Interpolate(_loc2_,_loc7_.x,_loc8_.x);
               _loc6_.y = this.Interpolate(_loc2_,_loc7_.y,_loc8_.y);
            }
            _loc5_++;
         }
         if(this._timer == 0)
         {
            this._logic.isMatchingEnabled = true;
            this._isDone = true;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this._isDone;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return false;
      }
      
      private function Interpolate(param1:Number, param2:Number, param3:Number) : Number
      {
         return (param3 - param2) * param1 + param2;
      }
      
      private function CalcScramble() : void
      {
         var _loc6_:int = 0;
         this._logic.isMatchingEnabled = false;
         var _loc1_:int = 0;
         var _loc2_:Gem = null;
         var _loc3_:Vector.<Gem> = this._logic.board.mGems;
         var _loc4_:int = _loc3_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc1_];
            if(_loc2_ != null)
            {
               if(_loc2_.id >= this._oldPos.length)
               {
                  this._oldPos.length = _loc2_.id + 1;
               }
               this._oldPos[_loc2_.id] = this._logic.point2DPool.GetNextPoint2D(_loc2_.col,_loc2_.row);
            }
            _loc1_++;
         }
         this._logic.board.CopyGemArray(this._oldGems);
         var _loc5_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < 50 && !_loc5_)
         {
            this._logic.board.ScrambleGems(BlitzRNGManager.RNG_BLITZ_BOOSTS);
            this._logic.board.FindMatches(this._matches);
            _loc6_ = this._matches.length;
            this._logic.matchSetPool.FreeMatchSets(this._matches,true);
            _loc5_ = true;
            if(_loc6_ < 1)
            {
               _loc5_ = false;
               this._logic.board.SetGemArray(this._oldGems);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc2_ = _loc3_[_loc1_];
            if(_loc2_ != null)
            {
               if(_loc2_.id >= this._newPos.length)
               {
                  this._newPos.length = _loc2_.id + 1;
               }
               this._newPos[_loc2_.id] = this._logic.point2DPool.GetNextPoint2D(_loc2_.col,_loc2_.row);
            }
            _loc1_++;
         }
      }
   }
}
