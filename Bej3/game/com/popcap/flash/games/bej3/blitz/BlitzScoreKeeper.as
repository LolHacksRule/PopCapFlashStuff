package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.MoveData;
   import de.polygonal.ds.HashMap;
   import flash.events.EventDispatcher;
   
   public class BlitzScoreKeeper extends EventDispatcher
   {
      
      public static const CASCADE_BONUS:int = 50;
      
      public static const MATCH_3:int = 50;
      
      public static const MATCH_4:int = 150;
      
      public static const MATCH_5:int = 500;
      
      public static const MATCH_6:int = 1000;
      
      public static const MATCH_7:int = 1000;
      
      public static const MATCH_8:int = 1000;
      
      public static const MATCH_VALUES:Vector.<int> = new Vector.<int>();
      
      public static const SHATTER_VALUES:Vector.<int> = new Vector.<int>(Gem.NUM_TYPES);
      
      public static const DETONATE_VALUES:Vector.<int> = new Vector.<int>(Gem.NUM_TYPES);
      
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
         SHATTER_VALUES[Gem.TYPE_FLAME] = 0;
         SHATTER_VALUES[Gem.TYPE_RAINBOW] = 0;
         SHATTER_VALUES[Gem.TYPE_STAR] = 0;
         DETONATE_VALUES[Gem.TYPE_STANDARD] = 0;
         DETONATE_VALUES[Gem.TYPE_MULTI] = 0;
         DETONATE_VALUES[Gem.TYPE_FLAME] = 0;
         DETONATE_VALUES[Gem.TYPE_RAINBOW] = 0;
         DETONATE_VALUES[Gem.TYPE_STAR] = 0;
      }
      
      private var mLogic:BlitzLogic;
      
      public var moveBonus:int = 0;
      
      public var matchScores:Vector.<MatchScore>;
      
      public var cascadeScores:Vector.<CascadeScore>;
      
      public var gemScores:Vector.<GemScore>;
      
      public var matchesMade:int = 0;
      
      public var bestCascade:int = 0;
      
      public var gemCount:int = 0;
      
      public var scores:Vector.<ScoreValue>;
      
      private var mScore:int = 0;
      
      private var mTime:int = 0;
      
      private var mGemHistory:HashMap;
      
      public function BlitzScoreKeeper(logic:BlitzLogic)
      {
         this.matchScores = new Vector.<MatchScore>();
         this.cascadeScores = new Vector.<CascadeScore>();
         this.gemScores = new Vector.<GemScore>();
         super();
         this.mLogic = logic;
         this.mGemHistory = new HashMap(128);
         this.Reset();
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
         this.scores = new Vector.<ScoreValue>();
         this.mScore = 0;
         this.mTime = 0;
         this.mGemHistory.clear();
      }
      
      public function AddPoints(points:int, source:Gem) : void
      {
         var matchScore:MatchScore = null;
         var mE:ScoreEvent = null;
         var gemScore:GemScore = null;
         var e:ScoreEvent = null;
         if(source == null)
         {
            return;
         }
         if(source.mMatchId >= 0)
         {
            matchScore = this.matchScores[source.mMatchId];
            this.scores.push(matchScore.AddPoints(points,this.mTime,["Base","Multiplied"]));
            mE = new ScoreEvent();
            mE.value = matchScore.GetTotalValue();
            mE.id = source.mMatchId;
            mE.x = source.x;
            mE.y = source.y;
            mE.color = source.color;
            dispatchEvent(mE);
         }
         else
         {
            gemScore = null;
            if(source.mShatterGemId >= 0)
            {
               gemScore = this.gemScores[source.mShatterGemId];
               gemScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
               this.scores.push(gemScore.AddPoints(points,this.mTime,["Base","Multiplied"]));
               gemScore.fresh = true;
            }
            else
            {
               gemScore = this.gemScores[source.id];
               gemScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
               this.scores.push(gemScore.AddPoints(points,this.mTime,["Base","Multiplied"]));
               gemScore.fresh = true;
            }
            e = new ScoreEvent();
            e.value = gemScore.totalPoints;
            e.id = source.id;
            e.gem = source;
            e.x = source.x;
            e.y = source.y;
            e.color = source.color;
            dispatchEvent(e);
         }
      }
      
      public function GetLastHurrahPoints() : int
      {
         var sv:ScoreValue = null;
         var total:int = 0;
         for each(sv in this.scores)
         {
            if(sv.HasTag("LastHurrah"))
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
            if(sv.HasTag("Speed"))
            {
               total += sv.GetValue();
            }
         }
         return total;
      }
      
      public function IncrementMultiplier(moveId:int) : void
      {
         if(this.mLogic.lastHurrahLogic.IsRunning())
         {
            return;
         }
         if(moveId >= this.matchScores.length)
         {
            return;
         }
         var matchScore:MatchScore = this.matchScores[moveId];
         if(matchScore != null)
         {
            matchScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
         }
      }
      
      public function get score() : int
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
            score += gemScore.totalPoints;
         }
         return score;
      }
      
      public function Update(isStill:Boolean) : void
      {
         var matches:Vector.<Match> = this.mLogic.frameMatches;
         var gems:Vector.<Gem> = this.mLogic.board.mGems;
         var moveCount:int = this.mLogic.moves.length;
         var matchCount:int = this.mLogic.numMatches;
         var gemCount:int = this.mLogic.board.gemCount;
         this.mTime = this.mLogic.timerLogic.GetTimeElapsed();
         this.matchesMade = matches.length;
         this.bestCascade = 0;
         if(isStill && this.matchesMade == 0)
         {
            this.clearIds(gems);
         }
         this.fillVectors(gemCount,matchCount,moveCount);
         this.mLogic.coinTokenLogic.ScoreCoins();
         this.scoreMatches(matches);
         this.scoreGems(gems);
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
            gemScore = new GemScore();
            gemScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
            this.gemScores[this.gemScores.length] = new GemScore();
         }
         while(matches > this.matchScores.length)
         {
            matchScore = new MatchScore();
            matchScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
            this.matchScores[this.matchScores.length] = matchScore;
         }
         while(moves > this.cascadeScores.length)
         {
            this.cascadeScores[this.cascadeScores.length] = new CascadeScore();
         }
      }
      
      private function scoreMatches(matches:Vector.<Match>) : void
      {
         var match:Match = null;
         var mId:int = 0;
         var cId:int = 0;
         var matchSize:int = 0;
         var matchScore:MatchScore = null;
         var cascadeScore:CascadeScore = null;
         var hurrahTag:String = null;
         var move:MoveData = null;
         var cascadeBonus:int = 0;
         var gem:Gem = null;
         var e:ScoreEvent = null;
         var numMatches:int = matches.length;
         for(var i:int = 0; i < numMatches; i++)
         {
            match = matches[i];
            mId = match.mMatchId;
            cId = match.mCascadeId;
            matchSize = match.mGems.length;
            matchScore = this.matchScores[mId];
            cascadeScore = this.cascadeScores[cId];
            hurrahTag = "LastHurrah";
            if(!this.mLogic.lastHurrahLogic.IsRunning())
            {
               hurrahTag = null;
            }
            this.scores.push(matchScore.AddPoints(MATCH_VALUES[matchSize],this.mTime,["Base","Multiplied",hurrahTag]));
            if(cascadeScore.cascadeCount == 0)
            {
               this.scores.push(matchScore.AddPoints(this.moveBonus,this.mTime,["Speed","Multiplied",hurrahTag]));
            }
            move = this.mLogic.moves[cId];
            cascadeBonus = cascadeScore.cascadeCount * CASCADE_BONUS;
            ++cascadeScore.cascadeCount;
            move.cascades = cascadeScore.cascadeCount;
            for each(gem in match.mGems)
            {
               if(cascadeScore.AddGem(gem) == true)
               {
                  move.gemsCleared += 1;
               }
            }
            move.largestMatch = Math.max(move.largestMatch,match.mGems.length);
            this.scores.push(matchScore.AddPoints(cascadeBonus,this.mTime,["Cascade","Multiplied",hurrahTag]));
            if(cascadeScore.cascadeCount > this.bestCascade)
            {
               this.bestCascade = cascadeScore.cascadeCount;
            }
            if(cascadeScore.cascadeCount > this.mLogic.GetBestCascade())
            {
               this.mLogic.SetBestCascade(cascadeScore.cascadeCount);
            }
            this.gemCount += matchSize;
            cascadeScore.score = matchScore.GetTotalValue();
            e = new ScoreEvent();
            e.value = matchScore.GetTotalValue();
            e.id = mId;
            e.color = match.mGems[0].color;
            e.x = (match.mRight - match.mLeft) / 2 + match.mLeft;
            e.y = (match.mBottom - match.mTop) / 2 + match.mTop;
            e.cascade = cId;
            e.cascadeCount = cascadeScore.cascadeCount;
            dispatchEvent(e);
         }
      }
      
      private function scoreGems(gems:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         var gId:int = 0;
         var gemScore:GemScore = null;
         var move:MoveData = null;
         var hurrahTag:String = null;
         var cId:int = 0;
         var cascadeScore:CascadeScore = null;
         var matchScore:MatchScore = null;
         var mE:ScoreEvent = null;
         var locus:Gem = null;
         var e:ScoreEvent = null;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(!(gem == null || gem.baseValue <= 0 && gem.bonusValue <= 0))
            {
               if(!this.mGemHistory.containsKey(gem.id))
               {
                  if(gem.isMatched || gem.isShattered || gem.isDetonated)
                  {
                     if(gem.fuseTime <= 0)
                     {
                        this.mGemHistory.insert(gem.id,gem);
                        gId = -1;
                        gemScore = null;
                        move = this.mLogic.moves[gem.mMoveId];
                        if(gem.isMatching || gem.isShattering || gem.isDetonating || gem.isFuseLit && gem.fuseTime == 0)
                        {
                           cId = gem.mMoveId;
                           if(cId >= 0)
                           {
                              cascadeScore = this.cascadeScores[cId];
                              if(cascadeScore.AddGem(gem) == true)
                              {
                                 ++move.gemsCleared;
                              }
                           }
                        }
                        hurrahTag = "LastHurrah";
                        if(!this.mLogic.lastHurrahLogic.IsRunning())
                        {
                           hurrahTag = null;
                        }
                        if(gem.baseValue > 0)
                        {
                           if(gem.mMatchId >= 0)
                           {
                              matchScore = this.matchScores[gem.mMatchId];
                              this.scores.push(matchScore.AddPoints(gem.baseValue,this.mTime,["Base","Multiplied",hurrahTag]));
                              cascadeScore.score = matchScore.GetTotalValue();
                              mE = new ScoreEvent();
                              mE.value = matchScore.GetTotalValue();
                              mE.id = gem.mMatchId;
                              mE.cascade = cId;
                              mE.cascadeCount = cascadeScore.cascadeCount;
                              dispatchEvent(mE);
                           }
                           else if(gem.mShatterGemId >= 0)
                           {
                              gId = gem.mShatterGemId;
                              gemScore = this.gemScores[gId];
                              gemScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
                              this.scores.push(gemScore.AddPoints(gem.baseValue,this.mTime,["Base","Multiplied",hurrahTag]));
                              gemScore.fresh = true;
                           }
                           else
                           {
                              gId = gem.id;
                              gemScore = this.gemScores[gId];
                              gemScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
                              this.scores.push(gemScore.AddPoints(gem.baseValue,this.mTime,["Base","Multiplied",hurrahTag]));
                              gemScore.fresh = true;
                           }
                        }
                        if(gem.bonusValue > 0)
                        {
                           gId = gem.id;
                           gemScore = this.gemScores[gId];
                           gemScore.SetMultiplier(this.mLogic.multiLogic.multiplier,this.mTime);
                           this.scores.push(gemScore.AddPoints(gem.bonusValue,this.mTime,["Bonus",hurrahTag]));
                           gemScore.fresh = true;
                        }
                        if(gemScore != null)
                        {
                           locus = this.mLogic.board.GetGem(gId);
                           e = new ScoreEvent();
                           e.value = gemScore.totalPoints;
                           e.id = gId;
                           e.gem = gem;
                           e.x = locus.x;
                           e.y = locus.y;
                           e.color = locus.color;
                           e.cascade = cId;
                           e.cascadeCount = cascadeScore.cascadeCount;
                           cascadeScore.score = gemScore.totalPoints;
                           dispatchEvent(e);
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
