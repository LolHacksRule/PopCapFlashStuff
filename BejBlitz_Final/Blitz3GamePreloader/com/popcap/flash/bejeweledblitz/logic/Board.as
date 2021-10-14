package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemLogic;
   
   public class Board implements IBoard
   {
      
      public static const WIDTH:int = 8;
      
      public static const HEIGHT:int = 8;
      
      public static const LEFT:int = 0;
      
      public static const RIGHT:int = WIDTH - 1;
      
      public static const TOP:int = 0;
      
      public static const BOTTOM:int = HEIGHT - 1;
      
      public static const NUM_ROWS:int = WIDTH;
      
      public static const NUM_COLS:int = HEIGHT;
      
      public static const NUM_GEMS:int = NUM_ROWS * NUM_COLS;
       
      
      public var moveFinder:MoveFinder;
      
      public var gemCount:int;
      
      public var mGems:Vector.<Gem>;
      
      public var freshGems:Vector.<Gem>;
      
      public var matchGenerator:MatchGenerator;
      
      private var mMatches:Vector.<Match>;
      
      private var mMoves:Vector.<MoveData>;
      
      private var mActiveCounter:int;
      
      public var gemPool:GemPool;
      
      private var mDeadGems:int;
      
      private var m_Candidates:Vector.<Gem>;
      
      public var m_GemMap:Vector.<Gem>;
      
      private var m_EmptyOverrides:Vector.<int>;
      
      private var mGemColors:Vector.<int>;
      
      private var mLogic:BlitzLogic;
      
      public var m_DeadList:Vector.<int>;
      
      public function Board(param1:BlitzLogic)
      {
         super();
         this.gemCount = 0;
         this.freshGems = new Vector.<Gem>();
         this.matchGenerator = new MatchGenerator(param1);
         this.mMatches = new Vector.<Match>();
         this.mMoves = new Vector.<MoveData>();
         this.mActiveCounter = 0;
         this.mDeadGems = 0;
         this.m_Candidates = new Vector.<Gem>();
         this.gemPool = new GemPool();
         this.mGems = new Vector.<Gem>(NUM_GEMS);
         this.moveFinder = new MoveFinder(param1);
         this.m_GemMap = new Vector.<Gem>();
         this.m_EmptyOverrides = new Vector.<int>();
         this.m_DeadList = new Vector.<int>(Gem.GEM_COLORS.length);
         this.mLogic = param1;
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.mGemColors = this.mLogic.config.gemColors;
         this.gemPool.Reset();
         this.moveFinder.Reset();
         this.gemCount = 0;
         this.mActiveCounter = 0;
         this.mDeadGems = 0;
         this.freshGems.length = 0;
         this.mMatches.length = 0;
         this.mMoves.length = 0;
         var _loc1_:int = this.mGems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.mGems[_loc2_] = null;
            _loc2_++;
         }
         _loc1_ = this.m_DeadList.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            this.m_DeadList[_loc3_] = 0;
            _loc3_++;
         }
         this.matchGenerator.Reset();
         this.m_GemMap.length = 0;
         this.m_Candidates.length = 0;
      }
      
      public function CopyGemArray(param1:Vector.<Gem>) : void
      {
         param1.length = 0;
         param1.length = NUM_GEMS;
         var _loc2_:int = 0;
         while(_loc2_ < NUM_GEMS)
         {
            param1[_loc2_] = this.mGems[_loc2_];
            _loc2_++;
         }
      }
      
      public function SetGemArray(param1:Vector.<Gem>) : void
      {
         var _loc3_:Gem = null;
         var _loc2_:int = 0;
         while(_loc2_ < NUM_GEMS)
         {
            _loc3_ = param1[_loc2_];
            _loc3_.row = _loc2_ / NUM_COLS;
            _loc3_.col = _loc2_ % NUM_COLS;
            this.mGems[_loc2_] = _loc3_;
            _loc2_++;
         }
      }
      
      public function ScrambleGems(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc10_:Gem = null;
         this.m_Candidates.length = 0;
         var _loc2_:Gem = null;
         var _loc3_:int = 0;
         while(_loc3_ < NUM_ROWS)
         {
            _loc4_ = _loc3_ * NUM_COLS;
            this.m_Candidates.length = 0;
            _loc5_ = 0;
            while(_loc5_ < NUM_COLS)
            {
               _loc2_ = this.mGems[_loc4_ + _loc5_];
               if(_loc2_ != null)
               {
                  if(!(_loc2_.type == Gem.TYPE_DETONATE || _loc2_.type == Gem.TYPE_SCRAMBLE))
                  {
                     if(_loc2_.isStill())
                     {
                        this.m_Candidates.push(_loc2_);
                     }
                  }
               }
               _loc5_++;
            }
            if(this.m_Candidates.length >= 2)
            {
               if(this.m_Candidates.length == 2)
               {
                  this.SwapGems(this.m_Candidates[0],this.m_Candidates[1]);
               }
               _loc6_ = this.m_Candidates.length;
               _loc7_ = 1;
               while(_loc7_ < _loc6_)
               {
                  _loc8_ = this.mLogic.GetRNGOfType(param1).Int(0,_loc7_ - 1);
                  _loc9_ = this.m_Candidates[_loc7_];
                  _loc10_ = this.m_Candidates[_loc8_];
                  this.SwapGems(_loc9_,_loc10_);
                  _loc7_++;
               }
            }
            _loc3_++;
         }
      }
      
      public function GetRandomGem(param1:int) : Gem
      {
         var _loc2_:Gem = null;
         while(_loc2_ == null)
         {
            _loc2_ = this.mGems[this.mLogic.GetRNGOfType(param1).Int(0,NUM_GEMS)];
         }
         return _loc2_;
      }
      
      public function GetRandomGemOfTypeAndColor(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean = false) : Vector.<Gem>
      {
         var _loc11_:Gem = null;
         var _loc12_:int = 0;
         var _loc7_:Vector.<Gem> = new Vector.<Gem>();
         var _loc8_:Vector.<Gem> = new Vector.<Gem>();
         var _loc9_:int = Board.NUM_GEMS;
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_)
         {
            if((_loc11_ = this.mGems[_loc10_]) != null)
            {
               if(!_loc11_.IsDead())
               {
                  if((param1 == -1 || _loc11_.type == param1) && (param2 == Gem.COLOR_ANY || param2 == _loc11_.color) && _loc11_.color != param5 && !_loc11_.HasToken())
                  {
                     if(param6)
                     {
                        if(!this.mLogic.GetScoreKeeper().IsHighlightedGem(_loc11_))
                        {
                           _loc8_.push(_loc11_);
                        }
                     }
                     else
                     {
                        _loc8_.push(_loc11_);
                     }
                  }
               }
            }
            _loc10_++;
         }
         if(param4 == -1)
         {
            return _loc8_;
         }
         while(param4 > 0 && _loc8_.length > 0)
         {
            _loc12_ = this.mLogic.GetRNGOfType(param3).Int(0,_loc8_.length);
            _loc7_.push(_loc8_[_loc12_]);
            _loc8_.splice(_loc12_,1);
            param4--;
         }
         return _loc7_;
      }
      
      public function GetNonCornerRandomGem(param1:int) : Gem
      {
         var _loc2_:Gem = null;
         while(_loc2_ == null)
         {
            _loc2_ = this.mGems[this.mLogic.GetRNGOfType(param1).Int(0,NUM_GEMS)];
            if(_loc2_.IsBottomCornerGem())
            {
               _loc2_ = null;
            }
         }
         return _loc2_;
      }
      
      public function GetColoredGemCleared() : Vector.<int>
      {
         return this.m_DeadList;
      }
      
      public function GetNumGemsCleared() : int
      {
         return this.mDeadGems;
      }
      
      public function IsStill() : Boolean
      {
         var _loc2_:Gem = null;
         var _loc1_:int = 0;
         while(_loc1_ < NUM_GEMS)
         {
            _loc2_ = this.mGems[_loc1_];
            if(_loc2_ == null || !_loc2_.isStill())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function IsIdle() : Boolean
      {
         var _loc2_:Gem = null;
         var _loc1_:int = 0;
         while(_loc1_ < NUM_GEMS)
         {
            _loc2_ = this.mGems[_loc1_];
            if(_loc2_ == null || !_loc2_.isIdle())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function GetNextActiveCount() : int
      {
         return ++this.mActiveCounter;
      }
      
      public function GetGem(param1:int) : Gem
      {
         if(param1 < 0 || param1 >= this.m_GemMap.length)
         {
            return null;
         }
         return this.m_GemMap[param1];
      }
      
      public function GetGemIndexAt(param1:int, param2:int) : int
      {
         return param1 * WIDTH + param2;
      }
      
      public function GetGemAt(param1:int, param2:int) : Gem
      {
         if(param1 < 0 || param2 < 0 || param1 >= HEIGHT || param2 >= WIDTH)
         {
            return null;
         }
         return this.mGems[this.GetGemIndexAt(param1,param2)];
      }
      
      public function SwapGems(param1:Gem, param2:Gem) : void
      {
         var _loc3_:int = param1.row * WIDTH + param1.col;
         var _loc4_:int = param2.row * WIDTH + param2.col;
         this.mGems[_loc3_] = param2;
         this.mGems[_loc4_] = param1;
         var _loc5_:int = param1.row;
         var _loc6_:int = param1.col;
         param1.row = param2.row;
         param1.col = param2.col;
         param2.row = _loc5_;
         param2.col = _loc6_;
         param2.activeCount = this.GetNextActiveCount();
         param1.activeCount = this.GetNextActiveCount();
      }
      
      public function KillGems(param1:Vector.<Gem>) : void
      {
         var _loc4_:Gem = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = param1[_loc3_]).SetDead(true);
            _loc3_++;
         }
      }
      
      public function GetGemsByColor(param1:int, param2:Vector.<Gem>) : void
      {
         var _loc5_:Gem = null;
         param2.length = 0;
         var _loc3_:int = this.mGems.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.mGems[_loc4_]) != null)
            {
               if(param1 == Gem.COLOR_NONE)
               {
                  param2.push(_loc5_);
               }
               else if(_loc5_.color == param1 && _loc5_.type != Gem.TYPE_HYPERCUBE)
               {
                  param2.push(_loc5_);
               }
            }
            _loc4_++;
         }
      }
      
      public function GetArea(param1:Number, param2:Number, param3:Number, param4:Vector.<Gem>) : void
      {
         var _loc15_:Gem = null;
         var _loc5_:Number = param1 - param3;
         var _loc6_:Number = param1 + param3;
         var _loc7_:Number = param2 - param3;
         var _loc8_:Number = param2 + param3;
         var _loc10_:Number = WIDTH - 1;
         var _loc12_:Number = HEIGHT - 1;
         _loc5_ = _loc5_ > 0 ? Number(_loc5_) : Number(0);
         _loc6_ = _loc6_ < _loc10_ ? Number(_loc6_) : Number(_loc10_);
         _loc7_ = _loc7_ > -2 ? Number(_loc7_) : Number(-2);
         _loc8_ = _loc8_ < _loc12_ ? Number(_loc8_) : Number(_loc12_);
         var _loc13_:int = this.mGems.length;
         var _loc14_:int = 0;
         while(_loc14_ < _loc13_)
         {
            if(!((_loc15_ = this.mGems[_loc14_]) == null || _loc15_.x < _loc5_ || _loc15_.x > _loc6_ || _loc15_.y < _loc7_ || _loc15_.y > _loc8_))
            {
               param4.push(_loc15_);
            }
            _loc14_++;
         }
      }
      
      public function FindMatches(param1:Vector.<MatchSet>) : void
      {
         return this.matchGenerator.FindMatches(this.mGems,this.m_EmptyOverrides,param1);
      }
      
      public function SpawnGems() : Vector.<Gem>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.freshGems.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < WIDTH)
         {
            _loc2_ = -2;
            _loc3_ = BOTTOM;
            _loc5_ = 0;
            while(_loc5_ <= BOTTOM)
            {
               _loc6_ = _loc5_ * WIDTH + _loc1_;
               if((_loc4_ = this.mGems[_loc6_]) != null)
               {
                  _loc3_ = _loc4_.row - 1;
                  break;
               }
               _loc5_++;
            }
            _loc5_ = _loc3_;
            while(_loc5_ >= 0)
            {
               _loc6_ = _loc5_ * WIDTH + _loc1_;
               _loc4_ = this.mGems[_loc6_];
               (_loc4_ = this.gemPool.GetNextGem()).id = this.gemCount++;
               _loc4_.Reset();
               _loc4_.row = _loc5_;
               _loc4_.col = _loc1_;
               _loc4_.x = _loc1_;
               _loc4_.y = _loc2_;
               _loc4_.activeCount = this.GetNextActiveCount();
               _loc4_.fallVelocity = 0;
               if(_loc4_.id >= this.m_GemMap.length)
               {
                  this.m_GemMap.length = _loc4_.id + 1;
               }
               this.m_GemMap[_loc4_.id] = _loc4_;
               _loc2_ -= 2;
               this.mGems[_loc6_] = _loc4_;
               this.freshGems.push(_loc4_);
               _loc5_--;
            }
            _loc1_++;
         }
         return this.freshGems;
      }
      
      public function DropGems() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Gem = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < WIDTH)
         {
            _loc2_ = HEIGHT;
            _loc3_ = HEIGHT - 1;
            while(_loc3_ >= 0)
            {
               _loc4_ = _loc3_ * WIDTH + _loc1_;
               if((_loc5_ = this.mGems[_loc4_]) != null && _loc5_.IsDead())
               {
                  if((_loc7_ = _loc5_.color) > 0 && _loc7_ <= this.m_DeadList.length)
                  {
                     this.m_DeadList[_loc7_ - 1] += 1;
                  }
                  ++this.mDeadGems;
               }
               if(_loc5_ == null || _loc5_.IsDead())
               {
                  this.mGems[_loc4_] = null;
               }
               else
               {
                  _loc2_--;
                  if(_loc5_.row != _loc2_)
                  {
                     if(_loc5_.isSwapping)
                     {
                        _loc2_ = _loc5_.row;
                     }
                     else
                     {
                        this.mGems[_loc4_] = null;
                        _loc5_.row = _loc2_;
                        _loc5_.activeCount = this.GetNextActiveCount();
                        _loc6_ = _loc2_ * WIDTH + _loc1_;
                        this.mGems[_loc6_] = _loc5_;
                     }
                  }
               }
               _loc3_--;
            }
            _loc1_++;
         }
      }
      
      public function PromoteFlameGems(param1:FlameGemLogic, param2:int, param3:Number) : void
      {
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         if(this.mLogic.mIsReplay)
         {
            return;
         }
         var _loc4_:int = this.freshGems.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = this.freshGems[_loc5_]).type == Gem.TYPE_STANDARD)
            {
               _loc7_ = this.mLogic.GetSecondaryRNG().Int(0,100);
               if(_loc6_.color == param2 && _loc7_ <= param3 && !_loc6_.IsBottomCornerGem())
               {
                  this.mLogic.QueueChangeGemType(_loc6_,Gem.TYPE_FLAME,-1,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
               }
            }
            _loc5_++;
         }
      }
      
      public function RandomizeColors(param1:Vector.<Gem>) : void
      {
         var _loc4_:Gem = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = param1[_loc3_]).color = this.RandomColor(BlitzRNGManager.RNG_BLITZ_PRIMARY);
            _loc3_++;
         }
      }
      
      public function GetColorCount(param1:int, param2:Boolean) : int
      {
         var _loc6_:Gem = null;
         var _loc3_:int = 0;
         var _loc4_:int = this.mGems.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = this.mGems[_loc5_]) != null)
            {
               if(!(_loc6_.lifetime == 0 && !param2))
               {
                  if(_loc6_.color == param1)
                  {
                     _loc3_++;
                  }
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function GetGems() : Vector.<Gem>
      {
         return this.mGems;
      }
      
      private function RandomColor(param1:int) : int
      {
         var _loc2_:int = this.mLogic.GetRNGOfType(param1).Int(0,this.mGemColors.length);
         return this.mGemColors[_loc2_];
      }
   }
}
