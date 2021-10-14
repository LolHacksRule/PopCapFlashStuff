package com.popcap.flash.bejeweledblitz.logic.gems.unscramble
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MatchSet;
   import com.popcap.flash.bejeweledblitz.logic.Point2D;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   import flash.utils.Dictionary;
   
   public class UnScrambleEvent implements IBlitzEvent
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _timer:int;
      
      private var _timer_delay:int;
      
      private var _isInited:Boolean;
      
      private var _isDone:Boolean;
      
      private var _matches:Vector.<MatchSet>;
      
      private var _oldGems:Vector.<Gem>;
      
      private var _oldPos:Vector.<Point2D>;
      
      private var _newPos:Vector.<Point2D>;
      
      private var _oldPosition:Dictionary;
      
      private var _newPosition:Dictionary;
      
      private var _isAnimationStart:Boolean;
      
      private var _boostId:String;
      
      public function UnScrambleEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._timer = this._logic.config.unScrambleEventSwapTime;
         this._timer_delay = this._logic.config.unScrambleEventPostSwapTime;
         this._matches = new Vector.<MatchSet>();
         this._oldGems = new Vector.<Gem>();
         this._oldPos = new Vector.<Point2D>();
         this._newPos = new Vector.<Point2D>();
         this._oldPosition = new Dictionary();
         this._newPosition = new Dictionary();
         this._isAnimationStart = false;
      }
      
      public function Set(param1:String) : void
      {
         this._boostId = param1;
      }
      
      public function Init() : void
      {
         if(this._isInited)
         {
            return;
         }
         this.CalcUnScramble();
         this._isInited = true;
         this._isAnimationStart = true;
      }
      
      public function Reset() : void
      {
         this._oldPosition = new Dictionary();
         this._newPosition = new Dictionary();
         this._timer = this._logic.config.unScrambleEventSwapTime;
         this._timer_delay = this._logic.config.unScrambleEventPostSwapTime;
         this._isInited = false;
         this._isDone = false;
         this._isAnimationStart = false;
         this._boostId = null;
      }
      
      public function Update(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Vector.<Gem> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Gem = null;
         var _loc7_:Point2D = null;
         var _loc8_:Point2D = null;
         if(this._timer <= 0)
         {
            --this._timer_delay;
            if(this._isAnimationStart)
            {
               if(this._boostId != null)
               {
                  this._logic.boostLogicV2.mBoostMap[this._boostId].DispatchBoostFeedbackQueue(this._logic.GetSpecialGems());
               }
               this._isAnimationStart = false;
            }
            if(this._timer_delay == 0)
            {
               this._logic.isMatchingEnabled = true;
               this._isDone = true;
            }
         }
         else
         {
            --this._timer;
            _loc2_ = 1 - this._timer / this._logic.config.unScrambleEventSwapTime;
            _loc3_ = this._logic.board.mGems;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if((_loc6_ = _loc3_[_loc5_]) != null)
               {
                  _loc7_ = this._oldPosition[_loc6_.id];
                  _loc8_ = this._newPosition[_loc6_.id];
                  _loc6_.x = this.Interpolate(_loc2_,_loc7_.x,_loc8_.x);
                  _loc6_.y = this.Interpolate(_loc2_,_loc7_.y,_loc8_.y);
               }
               _loc5_++;
            }
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
      
      private function CalcUnScramble() : void
      {
         var i:int = 0;
         var numGems:int = 0;
         var sortFunc:Function = null;
         var specialSortFunc:Function = null;
         var basicGems:Vector.<Gem> = null;
         var gemCount:int = 0;
         var j:int = 0;
         var xLower:int = 0;
         var xUpper:int = 0;
         var yLower:int = 0;
         var yUpper:int = 0;
         var x:int = 0;
         var y:int = 0;
         var mFunc:Function = null;
         var mLambdaFunc:Function = null;
         var shouldBreak:Boolean = false;
         var itrCount:int = 0;
         var modDivisor:int = 0;
         var loopMap:Dictionary = null;
         var lastColor:int = 0;
         var div:int = 0;
         var loopCnt:int = 0;
         var index:int = 0;
         var loopCount:int = 0;
         var itr:int = 0;
         var sortedTemp:Vector.<Vector.<Gem>> = null;
         var p:int = 0;
         sortFunc = function(param1:Vector.<Gem>, param2:Vector.<Gem>):int
         {
            var _loc3_:int = param1.length;
            var _loc4_:int = param2.length;
            if(_loc3_ > _loc4_)
            {
               return -1;
            }
            if(_loc3_ < _loc4_)
            {
               return 1;
            }
            return 0;
         };
         specialSortFunc = function(param1:*, param2:*):int
         {
            var _loc3_:* = param1.type;
            var _loc4_:*;
            if((_loc4_ = param2.type) > _loc3_)
            {
               return -1;
            }
            if(_loc4_ < _loc3_)
            {
               return 1;
            }
            return 0;
         };
         this._logic.isMatchingEnabled = false;
         var gem:Gem = null;
         var gems:Vector.<Gem> = this._logic.board.mGems;
         var specialGems:Vector.<Gem> = new Vector.<Gem>();
         var basicColorGems:Vector.<Vector.<Gem>> = new Vector.<Vector.<Gem>>(Gem.NUM_COLORS);
         i = 0;
         while(i < Gem.NUM_COLORS)
         {
            basicColorGems[i] = new Vector.<Gem>();
            i++;
         }
         numGems = 0;
         i = 0;
         while(i < gems.length)
         {
            gem = gems[i];
            if(gem != null)
            {
               numGems++;
               this._oldPosition[gem.id] = this._logic.point2DPool.GetNextPoint2D(gem.col,gem.row);
               if(gem.type == Gem.TYPE_MULTI || gem.type == Gem.TYPE_STANDARD)
               {
                  basicColorGems[gem.color].push(gem);
               }
               else
               {
                  specialGems.push(gem);
               }
            }
            i++;
         }
         i = 0;
         while(i < basicColorGems.length)
         {
            if(basicColorGems[i].length == 0)
            {
               basicColorGems.splice(i,1);
               i--;
            }
            i++;
         }
         basicColorGems.sort(sortFunc);
         specialGems.sort(specialSortFunc);
         var patternType:int = Math.floor(Math.random() * 2 + 1);
         basicGems = new Vector.<Gem>();
         gemCount = 0;
         if(patternType == 0)
         {
            i = 0;
            while(i < basicColorGems.length)
            {
               j = 0;
               while(j < basicColorGems[i].length)
               {
                  basicGems.push(basicColorGems[i][j]);
                  j++;
               }
               i++;
            }
            if(specialGems.length != 0)
            {
               i = 0;
               while(i < specialGems.length)
               {
                  basicGems.push(specialGems[i]);
                  i++;
               }
            }
            i = 0;
            while(i < numGems)
            {
               basicGems[i].row = i / Board.NUM_COLS;
               basicGems[i].col = i % Board.NUM_COLS;
               this._logic.board.mGems[basicGems[i].row * Board.WIDTH + basicGems[i].col] = basicGems[i];
               this._newPosition[basicGems[i].id] = this._logic.point2DPool.GetNextPoint2D(basicGems[i].col,basicGems[i].row);
               i++;
            }
         }
         else if(patternType == 1)
         {
            xLower = 0;
            xUpper = Board.NUM_COLS;
            yLower = 0;
            yUpper = Board.NUM_ROWS;
            gemCount = 0;
            x = 0;
            y = 0;
            mFunc = function(param1:uint):uint
            {
               return param1 * 0.6;
            };
            if(specialGems.length != 0)
            {
               i = 0;
               while(i < 0 + mFunc(specialGems.length))
               {
                  basicGems.push(specialGems[i]);
                  i++;
               }
            }
            i = 0;
            while(i < basicColorGems.length)
            {
               j = 0;
               while(j < 0 + mFunc(basicColorGems[i].length))
               {
                  basicGems.push(basicColorGems[i][j]);
                  j++;
               }
               i++;
            }
            i = 0 + mFunc(specialGems.length);
            while(i < specialGems.length)
            {
               basicGems.push(specialGems[i]);
               i++;
            }
            i = 0;
            while(i < basicColorGems.length)
            {
               j = 0 + mFunc(basicColorGems[i].length);
               while(j < basicColorGems[i].length)
               {
                  basicGems.push(basicColorGems[i][j]);
                  j++;
               }
               i++;
            }
            mLambdaFunc = function():Boolean
            {
               basicGems[gemCount].row = y;
               basicGems[gemCount].col = x;
               _logic.board.mGems[basicGems[gemCount].row * Board.WIDTH + basicGems[gemCount].col] = basicGems[gemCount];
               _newPosition[basicGems[gemCount].id] = _logic.point2DPool.GetNextPoint2D(basicGems[gemCount].col,basicGems[gemCount].row);
               return ++gemCount >= numGems;
            };
            while(true)
            {
               shouldBreak = false;
               while(x < xUpper)
               {
                  if(mLambdaFunc())
                  {
                     shouldBreak = true;
                     break;
                  }
                  x++;
               }
               if(shouldBreak)
               {
                  break;
               }
               x--;
               yLower++;
               y++;
               while(y < yUpper)
               {
                  if(mLambdaFunc())
                  {
                     shouldBreak = true;
                     break;
                  }
                  y++;
               }
               if(shouldBreak)
               {
                  break;
               }
               y--;
               xUpper--;
               x--;
               while(x >= xLower)
               {
                  if(mLambdaFunc())
                  {
                     shouldBreak = true;
                     break;
                  }
                  x--;
               }
               if(shouldBreak)
               {
                  break;
               }
               x++;
               yUpper--;
               y--;
               while(y >= yLower)
               {
                  if(mLambdaFunc())
                  {
                     shouldBreak = true;
                     break;
                  }
                  y--;
               }
               if(shouldBreak)
               {
                  break;
               }
               y++;
               xLower++;
               x++;
            }
         }
         else if(patternType == 2)
         {
            itrCount = 0;
            gemCount = 0;
            modDivisor = basicColorGems.length;
            if(specialGems.length > 0)
            {
               modDivisor = Math.round(numGems / specialGems.length);
               basicColorGems.push(specialGems);
            }
            loopMap = new Dictionary();
            j = 0;
            while(j < basicColorGems.length - 1)
            {
               div = Math.round(numGems / basicColorGems[j].length);
               loopCnt = 4;
               if(div <= 3)
               {
                  loopCnt = 8;
               }
               loopMap[basicColorGems[j][0].color] = loopCnt;
               j++;
            }
            lastColor = Gem.COLOR_NONE;
            while(true)
            {
               index = 0;
               loopCount = 4;
               if(itrCount % modDivisor != 0 && basicColorGems.length > 1)
               {
                  j = 0;
                  while(j < basicColorGems.length - 1)
                  {
                     index = j;
                     if(basicColorGems[index][0].color != lastColor)
                     {
                        lastColor = basicColorGems[index][0].color;
                        loopCount = loopMap[basicColorGems[j][0].color];
                        break;
                     }
                     j++;
                  }
               }
               else
               {
                  index = basicColorGems.length - 1;
                  if(modDivisor < 3)
                  {
                     loopCount = 8;
                  }
               }
               loopCount = basicColorGems[index].length >= loopCount ? int(loopCount) : int(basicColorGems[index].length);
               itr = 0;
               while(itr < loopCount)
               {
                  basicColorGems[index][itr].row = gemCount / Board.NUM_COLS;
                  basicColorGems[index][itr].col = gemCount % Board.NUM_COLS;
                  this._logic.board.mGems[basicColorGems[index][itr].row * Board.WIDTH + basicColorGems[index][itr].col] = basicColorGems[index][itr];
                  this._newPosition[basicColorGems[index][itr].id] = this._logic.point2DPool.GetNextPoint2D(basicColorGems[index][itr].col,basicColorGems[index][itr].row);
                  gemCount++;
                  itr++;
               }
               i = 0;
               while(i < 0 + loopCount)
               {
                  basicColorGems[index].splice(i,1);
                  loopCount--;
               }
               i = 0;
               while(i < basicColorGems.length)
               {
                  if(basicColorGems[i].length == 0)
                  {
                     basicColorGems.splice(i,1);
                     i--;
                  }
                  i++;
               }
               if(basicColorGems.length == 0)
               {
                  break;
               }
               if(basicColorGems.length > 2)
               {
                  sortedTemp = basicColorGems.slice(0,basicColorGems.length - 1);
                  sortedTemp.sort(sortFunc);
                  p = basicColorGems.length - 1;
                  i = 0;
                  while(i < p)
                  {
                     basicColorGems.shift();
                     i++;
                  }
                  basicColorGems = sortedTemp.concat(basicColorGems);
               }
               itrCount++;
            }
         }
      }
   }
}
