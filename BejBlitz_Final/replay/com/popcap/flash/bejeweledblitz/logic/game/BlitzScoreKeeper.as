package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   
   public class BlitzScoreKeeper
   {
      
      public static const CASCADE_BONUS:int = 250;
      
      public static const MATCH_3:int = 250;
      
      public static const MATCH_4:int = 500;
      
      public static const MATCH_5:int = 2500;
      
      public static const MATCH_6:int = 4500;
      
      public static const MATCH_7:int = 6500;
      
      public static const MATCH_8:int = 8500;
      
      public static const MATCH_VALUES:Vector.<int> = new Vector.<int>(9);
      
      public static const SHATTER_VALUES:Vector.<int> = new Vector.<int>(Gem.NUM_TYPES);
      
      public static const DETONATE_VALUES:Vector.<int> = new Vector.<int>(Gem.NUM_TYPES);
      
      public static const TAG_BASE:String = "Base";
      
      public static const TAG_LASTHURRAH:String = "LastHurrah";
      
      public static const TAG_MULTIPLIED:String = "Multiplied";
      
      public static const TAG_NOTMULTIPLIED:String = "NotMultiplied";
      
      public static const TAG_SPEED:String = "Speed";
      
      public static const TAG_CASCADE:String = "Cascade";
      
      public static const TAG_BONUS:String = "Bonus";
      
      {
         MATCH_VALUES[0] = 0;
         MATCH_VALUES[1] = 0;
         MATCH_VALUES[2] = 0;
         MATCH_VALUES[3] = MATCH_3;
         MATCH_VALUES[4] = MATCH_4;
         MATCH_VALUES[5] = MATCH_5;
         MATCH_VALUES[6] = MATCH_6;
         MATCH_VALUES[7] = MATCH_7;
         MATCH_VALUES[8] = MATCH_8;
         SHATTER_VALUES[Gem.TYPE_STANDARD] = 0;
         SHATTER_VALUES[Gem.TYPE_MULTI] = 0;
         SHATTER_VALUES[Gem.TYPE_FLAME] = 100;
         SHATTER_VALUES[Gem.TYPE_HYPERCUBE] = 250;
         SHATTER_VALUES[Gem.TYPE_STAR] = 250;
         DETONATE_VALUES[Gem.TYPE_STANDARD] = 0;
         DETONATE_VALUES[Gem.TYPE_MULTI] = 0;
         DETONATE_VALUES[Gem.TYPE_FLAME] = 100;
         DETONATE_VALUES[Gem.TYPE_HYPERCUBE] = 0;
         DETONATE_VALUES[Gem.TYPE_STAR] = 0;
      }
      
      private var m_SourcelessScore:int = 0;
      
      private var m_Logic:BlitzLogic;
      
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
      
      private var m_Score:int;
      
      private var m_Time:int;
      
      private var m_GemHistory:Vector.<Gem>;
      
      private var m_Handlers:Vector.<IBlitzScoreKeeperHandler>;
      
      public function BlitzScoreKeeper(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.moveBonus = 0;
         this.matchScores = new Vector.<MatchScore>();
         this.cascadeScores = new Vector.<CascadeScore>();
         this.gemScores = new Vector.<GemScore>();
         this.scores = new Vector.<ScoreValue>();
         this.matchesMade = 0;
         this.bestCascade = 0;
         this.gemCount = 0;
         this.m_Score = 0;
         this.m_Time = 0;
         this.m_GemHistory = new Vector.<Gem>(128);
         this.scoreValuePool = new ScoreValuePool();
         this.m_Logic.lifeguard.AddPool(this.scoreValuePool);
         this.m_MatchScorePool = new MatchScorePool(logic);
         this.m_Logic.lifeguard.AddPool(this.m_MatchScorePool);
         this.m_GemScorePool = new GemScorePool(logic);
         this.m_Logic.lifeguard.AddPool(this.m_GemScorePool);
         this.m_CascadeScorePool = new CascadeScorePool();
         this.m_Logic.lifeguard.AddPool(this.m_CascadeScorePool);
         this.m_ScoreDataPool = new ScoreDataPool();
         this.m_Logic.lifeguard.AddPool(this.m_ScoreDataPool);
         this.m_Handlers = new Vector.<IBlitzScoreKeeperHandler>();
         this.Reset();
      }
      
      public function AddHandler(handler:IBlitzScoreKeeperHandler) : void
      {
         this.m_Handlers.push(handler);
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
         this.m_Score = 0;
         this.m_Time = 0;
         this.m_SourcelessScore = 0;
         this.m_GemHistory.length = 0;
      }
      
      public function AddPoints(points:int, source:Gem) : void
      {
         var data:ScoreData = null;
         var scoreValue:ScoreValue = null;
         var matchScore:MatchScore = null;
         var gemScore:GemScore = null;
         var eventID:int = 0;
         if(source == null)
         {
            scoreValue = this.scoreValuePool.GetNextScoreValue(points,this.m_Time);
            scoreValue.AddTag(TAG_LASTHURRAH);
            this.scores.push(scoreValue);
            this.m_SourcelessScore += points;
            return;
         }
         if(source.mMatchId >= 0)
         {
            matchScore = this.matchScores[source.mMatchId];
            scoreValue = matchScore.AddPoints(points,this.m_Time,true);
            scoreValue.AddTag(TAG_BASE);
            scoreValue.AddTag(TAG_MULTIPLIED);
            this.scores.push(scoreValue);
            data = this.m_ScoreDataPool.GetNextScoreData();
            data.value = matchScore.GetTotalValue();
            data.id = source.mMatchId;
            data.x = source.x;
            data.y = source.y;
            data.color = source.color;
            this.DispatchPointScored(data);
         }
         else
         {
            gemScore = null;
            eventID = 0;
            if(source.mShatterGemId >= 0)
            {
               gemScore = this.gemScores[source.mShatterGemId];
               gemScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
               scoreValue = gemScore.AddPoints(points,this.m_Time,true);
               scoreValue.AddTag(TAG_BASE);
               scoreValue.AddTag(TAG_MULTIPLIED);
               this.scores.push(scoreValue);
               gemScore.fresh = true;
               eventID = source.mShatterGemId;
            }
            else
            {
               gemScore = this.gemScores[source.id];
               gemScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
               scoreValue = gemScore.AddPoints(points,this.m_Time,true);
               scoreValue.AddTag(TAG_BASE);
               scoreValue.AddTag(TAG_MULTIPLIED);
               this.scores.push(scoreValue);
               gemScore.fresh = true;
               eventID = source.id;
            }
            data = this.m_ScoreDataPool.GetNextScoreData();
            data.value = gemScore.GetTotalPoints();
            data.id = eventID;
            data.gem = source;
            data.x = source.x;
            data.y = source.y;
            data.color = source.color;
            this.DispatchPointScored(data);
         }
      }
      
      public function GetLastHurrahPoints() : int
      {
         var sv:ScoreValue = null;
         var total:int = 0;
         for each(sv in this.scores)
         {
            if(sv.HasTag(TAG_LASTHURRAH))
            {
               total += sv.GetValue();
            }
         }
         return total;
      }
      
      public function GetSpeedPoints() : int
      {
         var sv:ScoreValue = null;
         var total:int = 0;
         for each(sv in this.scores)
         {
            if(sv.HasTag(TAG_SPEED))
            {
               total += sv.GetValue();
            }
         }
         return total;
      }
      
      public function IncrementMultiplier(moveId:int) : void
      {
         if(this.m_Logic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(moveId >= this.matchScores.length)
         {
            return;
         }
         var matchScore:MatchScore = this.matchScores[moveId];
         if(matchScore)
         {
            matchScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
         }
      }
      
      public function GetScore() : int
      {
         var matchScore:MatchScore = null;
         var gemScore:GemScore = null;
         var score:int = 0;
         var i:int = 0;
         var numMatches:int = this.matchScores.length;
         for(i = numMatches - 1; i >= 0; i--)
         {
            matchScore = this.matchScores[i];
            score += matchScore.GetTotalValue();
         }
         var numGems:int = this.gemScores.length;
         for(i = numGems - 1; i >= 0; i--)
         {
            gemScore = this.gemScores[i];
            score += gemScore.GetTotalPoints();
         }
         return score + this.m_SourcelessScore;
      }
      
      public function Update(isStill:Boolean) : void
      {
         var matches:Vector.<Match> = this.m_Logic.frameMatches;
         var gems:Vector.<Gem> = this.m_Logic.board.mGems;
         var moveCount:int = this.m_Logic.moves.length;
         var matchCount:int = this.m_Logic.GetNumMatches();
         var gemCount:int = this.m_Logic.board.gemCount;
         this.m_Time = this.m_Logic.timerLogic.GetTimeElapsed();
         this.matchesMade = matches.length;
         this.bestCascade = 0;
         if(isStill && this.matchesMade == 0)
         {
            this.clearIds(gems);
         }
         this.fillVectors(gemCount,matchCount,moveCount);
         this.m_Logic.coinTokenLogic.ScoreCoins();
         this.scoreMatches(matches);
         this.scoreGems(gems);
      }
      
      private function DispatchPointScored(data:ScoreData) : void
      {
         var handler:IBlitzScoreKeeperHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePointsScored(data);
         }
      }
      
      private function clearIds(gems:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         var cascade:CascadeScore = null;
         var i:int = 0;
         var numGems:int = gems.length;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            gem.mMatchId = -1;
            gem.mMoveId = -1;
            gem.activeCount = 0;
         }
         var numCascades:int = this.cascadeScores.length;
         for(i = 0; i < numCascades; i++)
         {
            cascade = this.cascadeScores[i];
            cascade.active = false;
         }
      }
      
      private function fillVectors(gems:int, matches:int, moves:int) : void
      {
         var gemScore:GemScore = null;
         var matchScore:MatchScore = null;
         while(gems > this.gemScores.length)
         {
            gemScore = this.m_GemScorePool.GetNextGemScore();
            gemScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
            this.gemScores.push(gemScore);
         }
         while(matches > this.matchScores.length)
         {
            matchScore = this.m_MatchScorePool.GetNextMatchScore();
            matchScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
            this.matchScores.push(matchScore);
         }
         while(moves > this.cascadeScores.length)
         {
            this.cascadeScores.push(this.m_CascadeScorePool.GetNextCascadeScore());
         }
      }
      
      private function scoreMatches(matches:Vector.<Match>) : void
      {
         var scoreValue:ScoreValue = null;
         var match:Match = null;
         var mId:int = 0;
         var cId:int = 0;
         var matchSize:int = 0;
         var matchScore:MatchScore = null;
         var cascadeScore:CascadeScore = null;
         var move:MoveData = null;
         var cascadeBonus:int = 0;
         var curGem:Gem = null;
         var data:ScoreData = null;
         var gem:Gem = null;
         var gId:int = 0;
         var gemScore:GemScore = null;
         var locus:Gem = null;
         var numMatches:int = matches.length;
         for(var i:int = 0; i < numMatches; i++)
         {
            match = matches[i];
            mId = match.matchId;
            cId = match.cascadeId;
            matchSize = match.matchGems.length;
            matchScore = this.matchScores[mId];
            cascadeScore = this.cascadeScores[cId];
            scoreValue = matchScore.AddPoints(MATCH_VALUES[matchSize],this.m_Time,true);
            if(this.m_Logic.lastHurrahLogic.IsRunning())
            {
               scoreValue.AddTag(TAG_LASTHURRAH);
            }
            scoreValue.AddTag(TAG_BASE);
            scoreValue.AddTag(TAG_MULTIPLIED);
            this.scores.push(scoreValue);
            if(cascadeScore.cascadeCount == 0)
            {
               scoreValue = matchScore.AddPoints(this.moveBonus,this.m_Time,true);
               if(this.m_Logic.lastHurrahLogic.IsRunning())
               {
                  scoreValue.AddTag(TAG_LASTHURRAH);
               }
               scoreValue.AddTag(TAG_SPEED);
               scoreValue.AddTag(TAG_MULTIPLIED);
               this.scores.push(scoreValue);
            }
            move = this.m_Logic.moves[cId];
            cascadeBonus = cascadeScore.cascadeCount * CASCADE_BONUS;
            ++cascadeScore.cascadeCount;
            move.cascades = cascadeScore.cascadeCount;
            for each(curGem in match.matchGems)
            {
               if(cascadeScore.AddGem(curGem) == true)
               {
                  move.gemsCleared += 1;
               }
            }
            move.largestMatch = Math.max(move.largestMatch,match.matchGems.length);
            scoreValue = matchScore.AddPoints(cascadeBonus,this.m_Time,true);
            if(this.m_Logic.lastHurrahLogic.IsRunning())
            {
               scoreValue.AddTag(TAG_LASTHURRAH);
            }
            scoreValue.AddTag(TAG_CASCADE);
            scoreValue.AddTag(TAG_MULTIPLIED);
            this.scores.push(scoreValue);
            if(cascadeScore.cascadeCount > this.bestCascade)
            {
               this.bestCascade = cascadeScore.cascadeCount;
            }
            this.gemCount += matchSize;
            data = this.m_ScoreDataPool.GetNextScoreData();
            data.value = matchScore.GetTotalValue();
            data.id = mId;
            data.color = match.matchGems[0].color;
            data.x = (match.right - match.left) * 0.5 + match.left;
            data.y = (match.bottom - match.top) * 0.5 + match.top;
            this.DispatchPointScored(data);
            for each(gem in match.matchGems)
            {
               if(gem.bonusValue > 0)
               {
                  gId = gem.id;
                  gemScore = this.gemScores[gId];
                  gemScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
                  scoreValue = gemScore.AddPoints(gem.bonusValue,this.m_Time,false);
                  if(this.m_Logic.lastHurrahLogic.IsRunning())
                  {
                     scoreValue.AddTag(TAG_LASTHURRAH);
                  }
                  scoreValue.AddTag(TAG_BONUS);
                  this.scores.push(scoreValue);
                  gemScore.fresh = true;
                  locus = this.m_Logic.board.GetGem(gId);
                  data = this.m_ScoreDataPool.GetNextScoreData();
                  data.value = gemScore.GetTotalPoints();
                  data.id = gId;
                  data.gem = gem;
                  data.x = locus.x;
                  data.y = locus.y;
                  data.color = locus.color;
                  data.isFlashy = true;
                  this.DispatchPointScored(data);
                  gem.bonusValue = 0;
               }
            }
         }
      }
      
      private function scoreGems(gems:Vector.<Gem>) : void
      {
         var data:ScoreData = null;
         var gem:Gem = null;
         var cId:int = 0;
         var gId:int = 0;
         var gemScore:GemScore = null;
         var matchScore:MatchScore = null;
         var scoreValue:ScoreValue = null;
         var move:MoveData = null;
         var cascadeScore:CascadeScore = null;
         var locus:Gem = null;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(!(gem == null || gem.baseValue <= 0 && gem.bonusValue <= 0))
            {
               if(!(gem.id > 0 && gem.id < this.m_GemHistory.length && this.m_GemHistory[gem.id] != null))
               {
                  if(gem.IsMatched() || gem.IsShattered() || gem.IsDetonated())
                  {
                     if(gem.GetFuseTime() <= 0)
                     {
                        if(gem.id >= this.m_GemHistory.length)
                        {
                           this.m_GemHistory.length = gem.id + 1;
                        }
                        this.m_GemHistory[gem.id] = gem;
                        cId = gem.mMoveId;
                        gId = -1;
                        gemScore = null;
                        matchScore = null;
                        scoreValue = null;
                        move = this.m_Logic.moves[cId];
                        if(gem.IsMatching() || gem.IsShattering() || gem.IsDetonating() || gem.IsFuseLit() && gem.GetFuseTime() == 0)
                        {
                           cascadeScore = this.cascadeScores[cId];
                           if(cascadeScore.AddGem(gem))
                           {
                              ++move.gemsCleared;
                           }
                        }
                        if(gem.baseValue > 0)
                        {
                           if(gem.mMatchId >= 0)
                           {
                              matchScore = this.matchScores[gem.mMatchId];
                              scoreValue = matchScore.AddPoints(gem.baseValue,this.m_Time,true);
                           }
                           else
                           {
                              gId = gem.id;
                              if(gem.mShatterGemId >= 0)
                              {
                                 gId = gem.mShatterGemId;
                              }
                              gemScore = this.gemScores[gId];
                              gemScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
                              scoreValue = gemScore.AddPoints(gem.baseValue,this.m_Time,true);
                           }
                           if(this.m_Logic.lastHurrahLogic.IsRunning())
                           {
                              scoreValue.AddTag(TAG_LASTHURRAH);
                           }
                           scoreValue.AddTag(TAG_BASE);
                           scoreValue.AddTag(TAG_MULTIPLIED);
                           if(gem.mMatchId >= 0)
                           {
                              this.scores.push(scoreValue);
                              data = this.m_ScoreDataPool.GetNextScoreData();
                              data.value = matchScore.GetTotalValue();
                              data.id = gem.mMatchId;
                              this.DispatchPointScored(data);
                           }
                           else
                           {
                              this.scores.push(scoreValue);
                              gemScore.fresh = true;
                           }
                        }
                        if(gem.bonusValue > 0)
                        {
                           gId = gem.id;
                           gemScore = this.gemScores[gId];
                           gemScore.SetMultiplier(this.m_Logic.multiLogic.multiplier);
                           scoreValue = gemScore.AddPoints(gem.bonusValue,this.m_Time,false);
                           if(this.m_Logic.lastHurrahLogic.IsRunning())
                           {
                              scoreValue.AddTag(TAG_LASTHURRAH);
                           }
                           scoreValue.AddTag(TAG_BONUS);
                           this.scores.push(scoreValue);
                           gemScore.fresh = true;
                        }
                        if(gemScore != null)
                        {
                           locus = this.m_Logic.board.GetGem(gId);
                           data = this.m_ScoreDataPool.GetNextScoreData();
                           data.value = gemScore.GetTotalPoints();
                           data.id = gId;
                           data.gem = gem;
                           data.x = locus.x;
                           data.y = locus.y;
                           data.color = locus.color;
                           data.isFlashy = gem.type == Gem.TYPE_MULTI;
                           this.DispatchPointScored(data);
                        }
                        gem.baseValue = 0;
                        gem.bonusValue = 0;
                     }
                  }
               }
            }
         }
      }
   }
}
