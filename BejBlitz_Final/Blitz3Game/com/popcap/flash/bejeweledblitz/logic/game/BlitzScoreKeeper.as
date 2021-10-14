package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import flash.utils.Dictionary;
   
   public class BlitzScoreKeeper
   {
      
      public static const TAG_BASE:String = "Base";
      
      public static const TAG_LASTHURRAH:String = "LastHurrah";
      
      public static const TAG_MULTIPLIED:String = "Multiplied";
      
      public static const TAG_NOTMULTIPLIED:String = "NotMultiplied";
      
      public static const TAG_SPEED:String = "Speed";
      
      public static const TAG_CASCADE:String = "Cascade";
      
      public static const TAG_BONUS:String = "Bonus";
       
      
      private var _logic:BlitzLogic;
      
      public var moveBonus:int;
      
      public var matchScores:Vector.<MatchScore>;
      
      public var cascadeScores:Vector.<CascadeScore>;
      
      public var gemScores:Vector.<GemScore>;
      
      public var scoreValuePool:ScoreValuePool;
      
      private var m_MatchScorePool:MatchScorePool;
      
      private var m_GemScorePool:GemScorePool;
      
      private var m_CascadeScorePool:CascadeScorePool;
      
      private var m_ScoreDataPool:ScoreDataPool;
      
      public var matchesMade:int;
      
      public var bestCascade:int;
      
      public var gemCount:int;
      
      public var scores:Vector.<ScoreValue>;
      
      private var _time:int;
      
      private var _gemHistory:Vector.<Gem>;
      
      private var _sourcelessScore:int = 0;
      
      private var _handlers:Vector.<IBlitzScoreKeeperHandler>;
      
      private var m_HighlightedCells:Dictionary;
      
      public var m_debugScoreToAdd:int = 0;
      
      public function BlitzScoreKeeper(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this.moveBonus = 0;
         this.matchScores = new Vector.<MatchScore>();
         this.cascadeScores = new Vector.<CascadeScore>();
         this.gemScores = new Vector.<GemScore>();
         this.scores = new Vector.<ScoreValue>();
         this.matchesMade = 0;
         this.bestCascade = 0;
         this.gemCount = 0;
         this._time = 0;
         this._gemHistory = new Vector.<Gem>(128);
         this.scoreValuePool = new ScoreValuePool();
         this._logic.lifeguard.AddPool(this.scoreValuePool);
         this.m_MatchScorePool = new MatchScorePool(param1);
         this._logic.lifeguard.AddPool(this.m_MatchScorePool);
         this.m_GemScorePool = new GemScorePool(param1);
         this._logic.lifeguard.AddPool(this.m_GemScorePool);
         this.m_CascadeScorePool = new CascadeScorePool();
         this._logic.lifeguard.AddPool(this.m_CascadeScorePool);
         this.m_ScoreDataPool = new ScoreDataPool();
         this._logic.lifeguard.AddPool(this.m_ScoreDataPool);
         this._handlers = new Vector.<IBlitzScoreKeeperHandler>();
         this.m_HighlightedCells = new Dictionary();
         this.Reset();
      }
      
      public function AddHandler(param1:IBlitzScoreKeeperHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IBlitzScoreKeeperHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function Reset() : void
      {
         this.moveBonus = 0;
         this.matchScores.length = 0;
         this.cascadeScores.length = 0;
         this.gemScores.length = 0;
         this.matchesMade = 0;
         this.bestCascade = 0;
         this.gemCount = 0;
         this.scores.length = 0;
         this._time = 0;
         this._sourcelessScore = 0;
         this._gemHistory.length = 0;
         this.m_HighlightedCells = new Dictionary();
      }
      
      public function AddPoints(param1:int, param2:Gem) : void
      {
         var _loc3_:ScoreData = null;
         var _loc4_:ScoreValue = null;
         var _loc6_:MatchScore = null;
         var _loc7_:GemScore = null;
         var _loc5_:int = 0;
         if(param2 == null)
         {
            (_loc4_ = this.scoreValuePool.GetNextScoreValue(param1,this._time)).AddTag(TAG_LASTHURRAH);
            this.scores.push(_loc4_);
            this._sourcelessScore += param1;
            _loc3_ = this.m_ScoreDataPool.GetNextScoreData();
            _loc3_.value = param1;
            _loc3_.id = _loc5_;
            _loc3_.gem = this._logic.board.gemPool.GetNextGem();
            _loc3_.x = 0;
            _loc3_.y = 0;
            _loc3_.color = Gem.COLOR_NONE;
         }
         else
         {
            if(param2.matchID >= 0 && this.matchScores.length > 0 && param2.matchID < this.matchScores.length && this.matchScores[param2.matchID] != null)
            {
               (_loc4_ = (_loc6_ = this.matchScores[param2.matchID]).AddPoints(param1,this._time,true)).AddTag(TAG_BASE);
               _loc4_.AddTag(TAG_MULTIPLIED);
               this.scores.push(_loc4_);
               _loc3_ = this.m_ScoreDataPool.GetNextScoreData();
               _loc3_.value = _loc6_.GetTotalValue();
               _loc3_.id = param2.matchID;
            }
            else
            {
               _loc7_ = null;
               if(param2.shatterGemID >= 0)
               {
                  (_loc7_ = this.gemScores[param2.shatterGemID]).SetMultiplier(this._logic.multiLogic.multiplier);
                  (_loc4_ = _loc7_.AddPoints(param1,this._time,true)).AddTag(TAG_BASE);
                  _loc4_.AddTag(TAG_MULTIPLIED);
                  this.scores.push(_loc4_);
                  _loc7_.fresh = true;
                  _loc5_ = param2.shatterGemID;
               }
               else
               {
                  (_loc7_ = this.gemScores[param2.id]).SetMultiplier(this._logic.multiLogic.multiplier);
                  (_loc4_ = _loc7_.AddPoints(param1,this._time,true)).AddTag(TAG_BASE);
                  _loc4_.AddTag(TAG_MULTIPLIED);
                  this.scores.push(_loc4_);
                  _loc7_.fresh = true;
                  _loc5_ = param2.id;
               }
               _loc3_ = this.m_ScoreDataPool.GetNextScoreData();
               _loc3_.value = _loc7_.GetTotalPoints();
               _loc3_.id = _loc5_;
               _loc3_.gem = param2;
            }
            _loc3_.gem = param2;
            _loc3_.x = param2.x;
            _loc3_.y = param2.y;
            _loc3_.color = param2.color;
         }
         _loc3_.cellInfo = this.IsHighlightedGem(_loc3_.gem);
         this.DispatchPointScored(_loc3_);
      }
      
      public function GetLastHurrahPoints() : int
      {
         var _loc2_:ScoreValue = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.scores)
         {
            if(_loc2_.HasTag(TAG_LASTHURRAH))
            {
               _loc1_ += _loc2_.GetValue();
            }
         }
         return _loc1_;
      }
      
      public function GetSpeedPoints() : int
      {
         var _loc2_:ScoreValue = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.scores)
         {
            if(_loc2_.HasTag(TAG_SPEED))
            {
               _loc1_ += _loc2_.GetValue();
            }
         }
         return _loc1_;
      }
      
      public function IncrementMultiplier(param1:int) : void
      {
         if(this._logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(param1 >= this.matchScores.length || param1 == -1)
         {
            return;
         }
         var _loc2_:MatchScore = this.matchScores[param1];
         if(_loc2_)
         {
            _loc2_.SetMultiplier(this._logic.multiLogic.multiplier);
         }
      }
      
      public function GetScore() : int
      {
         var _loc5_:MatchScore = null;
         var _loc6_:GemScore = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = this.matchScores.length;
         _loc2_ = _loc3_ - 1;
         while(_loc2_ >= 0)
         {
            _loc5_ = this.matchScores[_loc2_];
            _loc1_ += _loc5_.GetTotalValue();
            _loc2_--;
         }
         var _loc4_:int;
         _loc2_ = (_loc4_ = this.gemScores.length) - 1;
         while(_loc2_ >= 0)
         {
            _loc6_ = this.gemScores[_loc2_];
            _loc1_ += _loc6_.GetTotalPoints();
            _loc2_--;
         }
         _loc1_ += this.m_debugScoreToAdd;
         return _loc1_ + this._sourcelessScore;
      }
      
      public function Update(param1:Boolean) : void
      {
         var _loc2_:Vector.<Match> = this._logic.frameMatches;
         var _loc3_:Vector.<Gem> = this._logic.board.mGems;
         var _loc4_:int = this._logic.moves.length;
         var _loc5_:int = this._logic.GetNumMatches();
         var _loc6_:int = this._logic.board.gemCount;
         this._time = this._logic.timerLogic.GetTimeElapsed();
         this.matchesMade = _loc2_.length;
         this.bestCascade = 0;
         if(param1 && this.matchesMade == 0)
         {
            this.clearIds(_loc3_);
         }
         this.fillVectors(_loc6_,_loc5_,_loc4_);
         this._logic.coinTokenLogic.ScoreCoins();
         this.scoreMatches(_loc2_);
         this.scoreGems(_loc3_);
      }
      
      private function DispatchPointScored(param1:ScoreData) : void
      {
         var _loc2_:IBlitzScoreKeeperHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandlePointsScored(param1);
         }
      }
      
      private function clearIds(param1:Vector.<Gem>) : void
      {
         var _loc5_:Gem = null;
         var _loc6_:CascadeScore = null;
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            (_loc5_ = param1[_loc2_]).matchID = -1;
            _loc5_.moveID = -1;
            _loc5_.activeCount = 0;
            _loc2_++;
         }
         var _loc4_:int = this.cascadeScores.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            (_loc6_ = this.cascadeScores[_loc2_]).active = false;
            _loc2_++;
         }
      }
      
      private function fillVectors(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:GemScore = null;
         var _loc5_:MatchScore = null;
         while(param1 > this.gemScores.length)
         {
            (_loc4_ = this.m_GemScorePool.GetNextGemScore()).SetMultiplier(this._logic.multiLogic.multiplier);
            this.gemScores.push(_loc4_);
         }
         while(param2 > this.matchScores.length)
         {
            (_loc5_ = this.m_MatchScorePool.GetNextMatchScore()).SetMultiplier(this._logic.multiLogic.multiplier);
            this.matchScores.push(_loc5_);
         }
         while(param3 > this.cascadeScores.length)
         {
            this.cascadeScores.push(this.m_CascadeScorePool.GetNextCascadeScore());
         }
      }
      
      private function scoreMatches(param1:Vector.<Match>) : void
      {
         var _loc2_:ScoreValue = null;
         var _loc5_:Gem = null;
         var _loc7_:Match = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:MatchScore = null;
         var _loc12_:CascadeScore = null;
         var _loc13_:Number = NaN;
         var _loc14_:CellInfo = null;
         var _loc15_:MoveData = null;
         var _loc16_:int = 0;
         var _loc17_:ScoreData = null;
         var _loc18_:Gem = null;
         var _loc19_:int = 0;
         var _loc20_:GemScore = null;
         var _loc21_:Gem = null;
         var _loc3_:int = param1.length;
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc8_ = (_loc7_ = param1[_loc6_]).matchId;
            _loc9_ = _loc7_.cascadeId;
            _loc10_ = _loc7_.matchGems.length;
            _loc11_ = this.matchScores[_loc8_];
            if(_loc9_ >= 0 && _loc9_ < this.cascadeScores.length)
            {
               _loc12_ = this.cascadeScores[_loc9_];
            }
            else
            {
               _loc12_ = new CascadeScore();
            }
            _loc13_ = this._logic.config.gemColorMultipliers[_loc7_.matchColor];
            _loc14_ = null;
            if(!_loc4_)
            {
               for each(_loc5_ in _loc7_.matchGems)
               {
                  if((_loc14_ = this.IsHighlightedGem(_loc5_)) != null)
                  {
                     _loc4_ = true;
                     break;
                  }
               }
            }
            _loc2_ = _loc11_.AddPoints(this._logic.config.blitzScoreKeeperMatchPoints[_loc10_] * _loc13_,this._time,true);
            if(this._logic.lastHurrahLogic.IsRunning())
            {
               _loc2_.AddTag(TAG_LASTHURRAH);
            }
            _loc2_.AddTag(TAG_BASE);
            _loc2_.AddTag(TAG_MULTIPLIED);
            this.scores.push(_loc2_);
            if(_loc12_.cascadeCount == 0)
            {
               _loc2_ = _loc11_.AddPoints(this.moveBonus,this._time,true);
               if(this._logic.lastHurrahLogic.IsRunning())
               {
                  _loc2_.AddTag(TAG_LASTHURRAH);
               }
               _loc2_.AddTag(TAG_SPEED);
               _loc2_.AddTag(TAG_MULTIPLIED);
               this.scores.push(_loc2_);
            }
            _loc15_ = null;
            if(_loc9_ < this._logic.moves.length)
            {
               _loc15_ = this._logic.moves[_loc9_];
            }
            _loc16_ = _loc12_.cascadeCount * this._logic.config.blitzScoreKeeperCascadeBonus;
            ++_loc12_.cascadeCount;
            if(_loc15_)
            {
               _loc15_.cascades = _loc12_.cascadeCount;
            }
            for each(_loc5_ in _loc7_.matchGems)
            {
               if(_loc12_.AddGem(_loc5_) == true)
               {
                  if(_loc15_)
                  {
                     _loc15_.gemsCleared += 1;
                  }
               }
            }
            if(_loc15_)
            {
               _loc15_.largestMatch = Math.max(_loc15_.largestMatch,_loc7_.matchGems.length);
            }
            _loc2_ = _loc11_.AddPoints(_loc16_,this._time,true);
            if(this._logic.lastHurrahLogic.IsRunning())
            {
               _loc2_.AddTag(TAG_LASTHURRAH);
            }
            _loc2_.AddTag(TAG_CASCADE);
            _loc2_.AddTag(TAG_MULTIPLIED);
            this.scores.push(_loc2_);
            if(_loc12_.cascadeCount > this.bestCascade)
            {
               this.bestCascade = _loc12_.cascadeCount;
            }
            this.gemCount += _loc10_;
            (_loc17_ = this.m_ScoreDataPool.GetNextScoreData()).value = _loc11_.GetTotalValue();
            _loc17_.id = _loc8_;
            _loc17_.color = _loc7_.matchGems[0].color;
            _loc17_.x = (_loc7_.right - _loc7_.left) * 0.5 + _loc7_.left;
            _loc17_.y = (_loc7_.bottom - _loc7_.top) * 0.5 + _loc7_.top;
            _loc17_.cellInfo = _loc14_;
            this.DispatchPointScored(_loc17_);
            for each(_loc18_ in _loc7_.matchGems)
            {
               if(_loc18_.bonusValue > 0)
               {
                  _loc19_ = _loc18_.id;
                  (_loc20_ = this.gemScores[_loc19_]).SetMultiplier(this._logic.multiLogic.multiplier);
                  _loc2_ = _loc20_.AddPoints(_loc18_.bonusValue,this._time,false);
                  if(this._logic.lastHurrahLogic.IsRunning())
                  {
                     _loc2_.AddTag(TAG_LASTHURRAH);
                  }
                  _loc2_.AddTag(TAG_BONUS);
                  this.scores.push(_loc2_);
                  _loc20_.fresh = true;
                  _loc21_ = this._logic.board.GetGem(_loc19_);
                  (_loc17_ = this.m_ScoreDataPool.GetNextScoreData()).value = _loc20_.GetTotalPoints();
                  _loc17_.id = _loc19_;
                  _loc17_.gem = _loc18_;
                  _loc17_.x = _loc21_.x;
                  _loc17_.y = _loc21_.y;
                  _loc17_.color = _loc21_.color;
                  _loc17_.isFlashy = true;
                  this.DispatchPointScored(_loc17_);
                  _loc18_.bonusValue = 0;
               }
            }
            _loc6_++;
         }
      }
      
      private function scoreGems(param1:Vector.<Gem>) : void
      {
         var _loc2_:ScoreData = null;
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:GemScore = null;
         var _loc10_:MatchScore = null;
         var _loc11_:ScoreValue = null;
         var _loc12_:MoveData = null;
         var _loc13_:CascadeScore = null;
         var _loc14_:Gem = null;
         var _loc3_:int = param1.length;
         var _loc4_:* = false;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            if(!((_loc6_ = param1[_loc5_]) == null || _loc6_.baseValue <= 0 && _loc6_.bonusValue <= 0))
            {
               if(!(_loc6_.id > 0 && _loc6_.id < this._gemHistory.length && this._gemHistory[_loc6_.id] != null))
               {
                  if(_loc6_.IsMatched() || _loc6_.IsShattered() || _loc6_.IsDetonated())
                  {
                     if(_loc6_.GetFuseTime() <= 0)
                     {
                        if(_loc6_.id >= this._gemHistory.length)
                        {
                           this._gemHistory.length = _loc6_.id + 1;
                        }
                        this._gemHistory[_loc6_.id] = _loc6_;
                        _loc7_ = _loc6_.moveID;
                        _loc8_ = -1;
                        _loc9_ = null;
                        _loc10_ = null;
                        _loc11_ = null;
                        if(_loc7_ > 0 && _loc7_ < this._logic.moves.length)
                        {
                           _loc12_ = this._logic.moves[_loc7_];
                           if(_loc6_.IsMatching() || _loc6_.IsShattering() || _loc6_.IsDetonating() || _loc6_.IsFuseLit() && _loc6_.GetFuseTime() == 0)
                           {
                              if((_loc13_ = this.cascadeScores[_loc7_]).AddGem(_loc6_))
                              {
                                 ++_loc12_.gemsCleared;
                              }
                           }
                        }
                        if(_loc6_.baseValue > 0)
                        {
                           if(_loc6_.matchID >= 0)
                           {
                              _loc11_ = (_loc10_ = this.matchScores[_loc6_.matchID]).AddPoints(_loc6_.baseValue,this._time,true);
                           }
                           else
                           {
                              _loc8_ = _loc6_.id;
                              if(_loc6_.shatterGemID >= 0)
                              {
                                 _loc8_ = _loc6_.shatterGemID;
                              }
                              (_loc9_ = this.gemScores[_loc8_]).SetMultiplier(this._logic.multiLogic.multiplier);
                              _loc11_ = _loc9_.AddPoints(_loc6_.baseValue,this._time,true);
                           }
                           if(this._logic.lastHurrahLogic.IsRunning())
                           {
                              _loc11_.AddTag(TAG_LASTHURRAH);
                           }
                           _loc11_.AddTag(TAG_BASE);
                           _loc11_.AddTag(TAG_MULTIPLIED);
                           if(_loc6_.matchID >= 0)
                           {
                              this.scores.push(_loc11_);
                              _loc2_ = this.m_ScoreDataPool.GetNextScoreData();
                              _loc2_.value = _loc10_.GetTotalValue();
                              _loc2_.id = _loc6_.matchID;
                              _loc2_.x = _loc6_.x;
                              _loc2_.y = _loc6_.y;
                              if(!_loc4_)
                              {
                                 _loc2_.cellInfo = this.IsHighlightedGem(_loc6_);
                                 _loc4_ = _loc2_.cellInfo != null;
                              }
                              this.DispatchPointScored(_loc2_);
                           }
                           else
                           {
                              this.scores.push(_loc11_);
                              _loc9_.fresh = true;
                           }
                        }
                        if(_loc6_.bonusValue > 0)
                        {
                           _loc8_ = _loc6_.id;
                           (_loc9_ = this.gemScores[_loc8_]).SetMultiplier(this._logic.multiLogic.multiplier);
                           _loc11_ = _loc9_.AddPoints(_loc6_.bonusValue,this._time,false);
                           if(this._logic.lastHurrahLogic.IsRunning())
                           {
                              _loc11_.AddTag(TAG_LASTHURRAH);
                           }
                           _loc11_.AddTag(TAG_BONUS);
                           this.scores.push(_loc11_);
                           _loc9_.fresh = true;
                        }
                        if(_loc9_ != null)
                        {
                           _loc14_ = this._logic.board.GetGem(_loc8_);
                           _loc2_ = this.m_ScoreDataPool.GetNextScoreData();
                           _loc2_.value = _loc9_.GetTotalPoints();
                           _loc2_.id = _loc8_;
                           _loc2_.gem = _loc6_;
                           _loc2_.x = _loc14_.x;
                           _loc2_.y = _loc14_.y;
                           _loc2_.color = _loc14_.color;
                           _loc2_.isFlashy = _loc6_.type == Gem.TYPE_MULTI;
                           if(!_loc4_)
                           {
                              _loc2_.cellInfo = this.IsHighlightedGem(_loc6_);
                              _loc4_ = _loc2_.cellInfo != null;
                           }
                           this.DispatchPointScored(_loc2_);
                        }
                        _loc6_.baseValue = 0;
                        _loc6_.bonusValue = 0;
                     }
                  }
               }
            }
            _loc5_++;
         }
      }
      
      public function AddCellInfo(param1:String, param2:CellInfo) : void
      {
         this.m_HighlightedCells[param1] = param2;
      }
      
      public function ClearAllCellInfo() : void
      {
         this.m_HighlightedCells = new Dictionary();
      }
      
      public function IsHighlightedGem(param1:Gem) : CellInfo
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            return null;
         }
         for(_loc2_ in this.m_HighlightedCells)
         {
            if(_loc2_ == param1.getCellKey())
            {
               return this.m_HighlightedCells[_loc2_];
            }
         }
         return null;
      }
   }
}
