package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.misc.CurvedVal;
   import com.popcap.flash.framework.misc.CurvedValPoint;
   import com.popcap.flash.framework.misc.CustomCurvedValImpl;
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class SwapData implements IPoolObject
   {
       
      
      public var moveData:MoveData;
      
      public var speedFactor:Number;
      
      public var isBadSwap:Boolean;
      
      public var isForwardSwap:Boolean;
      
      private var _logic:BlitzLogic;
      
      private var _isDone:Boolean;
      
      private var _time:Number;
      
      private var _timeTotal:int;
      
      private var _swapCenterX:Number;
      
      private var _swapCenterY:Number;
      
      private var _swapPercent:CurvedVal;
      
      private var _gemScale:CurvedVal;
      
      private var _forePercent:CustomCurvedValImpl;
      
      private var _backPercent:CustomCurvedValImpl;
      
      private var _foreScale:CustomCurvedValImpl;
      
      private var _backScale:CustomCurvedValImpl;
      
      private var _dead:Boolean;
      
      private var _flip:Boolean;
      
      private var _gem1Row:Number;
      
      private var _gem1Col:Number;
      
      private var _gem2Row:Number;
      
      private var _gem2Col:Number;
      
      private var _tmpMatchSets:Vector.<MatchSet>;
      
      public function SwapData(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this.speedFactor = 1;
         this.isBadSwap = false;
         this.isForwardSwap = true;
         this._isDone = false;
         this._time = 0;
         this._timeTotal = this._logic.config.swapDataSwapTime;
         this._swapCenterX = 0;
         this._swapCenterY = 0;
         this._dead = false;
         this._flip = false;
         this._gem1Row = 0;
         this._gem1Col = 0;
         this._gem2Row = 0;
         this._gem2Col = 0;
         var _loc2_:Vector.<CurvedValPoint> = new Vector.<CurvedValPoint>();
         this._forePercent = new CustomCurvedValImpl();
         this._forePercent.setInRange(0,1);
         this._forePercent.setOutRange(0,1);
         _loc2_.push(new CurvedValPoint(0,1,0));
         _loc2_.push(new CurvedValPoint(1,0,0));
         this._forePercent.setCurve(true,_loc2_);
         this._backPercent = new CustomCurvedValImpl();
         this._backPercent.setInRange(0,1);
         this._backPercent.setOutRange(0,1);
         _loc2_.length = 0;
         _loc2_.push(new CurvedValPoint(0,1,0));
         _loc2_.push(new CurvedValPoint(1,0,0));
         this._backPercent.setCurve(true,_loc2_);
         this._foreScale = new CustomCurvedValImpl();
         this._foreScale.setInRange(0,1);
         this._foreScale.setOutRange(0,0.25);
         _loc2_.length = 0;
         _loc2_.push(new CurvedValPoint(0,0,0));
         _loc2_.push(new CurvedValPoint(0.5,0.25,0));
         _loc2_.push(new CurvedValPoint(1,0,0));
         this._foreScale.setCurve(true,_loc2_);
         this._backScale = new CustomCurvedValImpl();
         this._backScale.setInRange(0,1);
         this._backScale.setOutRange(0,0.25);
         _loc2_.length = 0;
         _loc2_.push(new CurvedValPoint(0,0,0));
         _loc2_.push(new CurvedValPoint(0.5,0.25,0));
         _loc2_.push(new CurvedValPoint(1,0,0));
         this._backScale.setCurve(true,_loc2_);
         this._swapPercent = this._forePercent;
         this._gemScale = this._foreScale;
         this._tmpMatchSets = new Vector.<MatchSet>();
      }
      
      public function Reset() : void
      {
         this.moveData = null;
         this.speedFactor = 1;
         this.isBadSwap = false;
         this.isForwardSwap = true;
         this._isDone = false;
         this._time = 0;
         this._timeTotal = this._logic.config.swapDataSwapTime;
         this._swapCenterX = 0;
         this._swapCenterY = 0;
         this._dead = false;
         this._flip = false;
         this._gem1Row = 0;
         this._gem1Col = 0;
         this._gem2Row = 0;
         this._gem2Col = 0;
         this._swapPercent = this._forePercent;
         this._gemScale = this._foreScale;
         this._tmpMatchSets.length = 0;
      }
      
      public function Init(param1:MoveData, param2:Number) : void
      {
         this.moveData = param1;
         this.speedFactor = param2;
         var _loc3_:Gem = this.moveData.sourceGem;
         var _loc4_:Gem = this.moveData.swapGem;
         this._swapCenterX = _loc3_.col + this.moveData.swapDir.x * 0.5;
         this._swapCenterY = _loc3_.row + this.moveData.swapDir.y * 0.5;
         this._gem1Row = _loc3_.row;
         this._gem1Col = _loc3_.col;
         this._gem2Row = _loc4_.row;
         this._gem2Col = _loc4_.col;
      }
      
      public function Update() : void
      {
         if(this._isDone == true)
         {
            return;
         }
         this.isBadSwap = false;
         this._time += this.speedFactor;
         if(this._time > this._timeTotal)
         {
            this._time = this._timeTotal;
         }
         var _loc1_:Number = this._time / this._timeTotal;
         var _loc2_:Gem = this.moveData.sourceGem;
         var _loc3_:Gem = this.moveData.swapGem;
         if(!this._dead && (_loc2_.IsDead() || _loc3_ != null && _loc3_.IsDead()))
         {
            this._isDone = true;
            if(this.isForwardSwap)
            {
               if(_loc1_ < 0.5)
               {
                  if(_loc2_.IsDead())
                  {
                     _loc3_.x = this._gem2Col;
                     _loc3_.y = this._gem2Row;
                     _loc3_.isSwapping = false;
                  }
                  else
                  {
                     _loc2_.x = this._gem1Col;
                     _loc2_.y = this._gem1Row;
                     _loc2_.isSwapping = false;
                  }
               }
               else if(_loc1_ > 0.5)
               {
                  this._logic.board.SwapGems(_loc2_,_loc3_);
                  if(_loc2_.IsDead())
                  {
                     _loc3_.x = this._gem1Col;
                     _loc3_.y = this._gem1Row;
                     _loc3_.isSwapping = false;
                  }
                  else
                  {
                     _loc2_.x = this._gem2Col;
                     _loc2_.y = this._gem2Row;
                     _loc2_.isSwapping = false;
                  }
               }
               else
               {
                  _loc2_.SetDead(true);
                  _loc3_.SetDead(true);
               }
            }
            else if(_loc1_ < 0.5)
            {
               this._logic.board.SwapGems(_loc2_,_loc3_);
               if(_loc2_.IsDead())
               {
                  _loc3_.x = this._gem1Col;
                  _loc3_.y = this._gem1Row;
                  _loc3_.isUnswapping = false;
                  _loc3_.isSwapping = false;
               }
               else
               {
                  _loc2_.x = this._gem2Col;
                  _loc2_.y = this._gem2Row;
                  _loc2_.isUnswapping = false;
                  _loc2_.isSwapping = false;
               }
            }
            else if(_loc1_ > 0.5)
            {
               if(_loc2_.IsDead())
               {
                  _loc3_.x = this._gem2Col;
                  _loc3_.y = this._gem2Row;
                  _loc3_.isUnswapping = false;
                  _loc3_.isSwapping = false;
               }
               else
               {
                  _loc2_.x = this._gem1Col;
                  _loc2_.y = this._gem1Row;
                  _loc2_.isUnswapping = false;
                  _loc2_.isSwapping = false;
               }
            }
            else
            {
               _loc2_.SetDead(true);
               _loc3_.SetDead(true);
            }
            return;
         }
         if(!this.isForwardSwap)
         {
            _loc1_ = 1 - _loc1_;
         }
         var _loc4_:Number;
         var _loc5_:Number = (_loc4_ = this._swapPercent.getOutValue(_loc1_)) * 2 - 1;
         var _loc6_:Point2D = this.moveData.swapDir;
         _loc2_.x = this._swapCenterX - _loc5_ * _loc6_.x * 0.5;
         _loc2_.y = this._swapCenterY - _loc5_ * _loc6_.y * 0.5;
         _loc2_.scale = 1 + this._gemScale.getOutValue(_loc4_);
         if(_loc3_ != null)
         {
            _loc3_.x = this._swapCenterX + _loc5_ * _loc6_.x * 0.5;
            _loc3_.y = this._swapCenterY + _loc5_ * _loc6_.y * 0.5;
            _loc3_.scale = 1 - this._gemScale.getOutValue(_loc4_);
         }
         if(this._time == this._timeTotal)
         {
            if(this.isForwardSwap)
            {
               _loc2_.isSwapping = false;
               _loc3_.isSwapping = false;
               this._logic.board.SwapGems(_loc2_,_loc3_);
               this._logic.board.FindMatches(this._tmpMatchSets);
               this._logic.matchSetPool.FreeMatchSets(this._tmpMatchSets,true);
               if(this._dead)
               {
                  this._isDone = true;
               }
               else if(_loc2_.hasMatch || _loc3_.hasMatch)
               {
                  this._isDone = true;
                  this.moveData.isSuccessful = true;
               }
               else
               {
                  this._logic.board.SwapGems(_loc2_,_loc3_);
                  this._swapPercent = this._backPercent;
                  this._gemScale = this._backScale;
                  this._time = 0;
                  this._timeTotal = this._logic.config.swapDataBadSwapTime;
                  this.isForwardSwap = false;
                  if(_loc2_ != null)
                  {
                     _loc2_.isUnswapping = true;
                  }
                  if(_loc3_ != null)
                  {
                     _loc3_.isUnswapping = true;
                  }
                  this.isBadSwap = true;
               }
            }
            else
            {
               this._isDone = true;
               if(_loc2_ != null)
               {
                  _loc2_.isUnswapping = false;
               }
               if(_loc3_ != null)
               {
                  _loc3_.isUnswapping = false;
               }
            }
         }
         _loc2_.isSwapping = !this._isDone;
         _loc3_.isSwapping = !this._isDone;
      }
      
      public function IsDone() : Boolean
      {
         return this._isDone;
      }
   }
}
