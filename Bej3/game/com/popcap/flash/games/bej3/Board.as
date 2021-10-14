package com.popcap.flash.games.bej3
{
   import com.popcap.flash.framework.math.Random;
   import flash.utils.Dictionary;
   
   public class Board
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
      
      public var gemCount:int = 0;
      
      public var mGems:Vector.<Gem>;
      
      public var freshGems:Vector.<Gem>;
      
      private var mRandom:Random = null;
      
      private var mMatcher:Matcher;
      
      private var mMatches:Vector.<Match>;
      
      private var mMoves:Vector.<MoveData>;
      
      private var mTempMatches:Vector.<Match>;
      
      private var mTempGems:Vector.<Gem>;
      
      private var mActiveCounter:int = 0;
      
      private var mGemPool:GemPool = null;
      
      private var mDeadGems:int = 0;
      
      private var mGemMap:Dictionary;
      
      public function Board(generator:Random)
      {
         this.freshGems = new Vector.<Gem>();
         this.mMatcher = new Matcher();
         this.mMatches = new Vector.<Match>();
         this.mMoves = new Vector.<MoveData>();
         this.mTempMatches = new Vector.<Match>();
         this.mTempGems = new Vector.<Gem>();
         super();
         this.mRandom = generator;
         this.mGemPool = new GemPool();
         this.mGems = new Vector.<Gem>(NUM_GEMS,true);
         this.moveFinder = new MoveFinder();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.mGemPool.Reset();
         this.moveFinder.Reset();
         this.gemCount = 0;
         this.mActiveCounter = 0;
         this.mDeadGems = 0;
         this.freshGems.length = 0;
         this.mMatches.length = 0;
         this.mMoves.length = 0;
         for(var i:int = 0; i < this.mGems.length; i++)
         {
            this.mGems[i] = null;
         }
         this.mMatcher.Reset();
         this.mGemMap = new Dictionary();
         this.mRandom.Reset();
      }
      
      public function GetGemArray() : Array
      {
         var gems:Array = [];
         for(var i:int = 0; i < NUM_GEMS; i++)
         {
            gems[i] = this.mGems[i];
         }
         return gems;
      }
      
      public function SetGemArray(gems:Array) : void
      {
         var gem:Gem = null;
         for(var i:int = 0; i < NUM_GEMS; i++)
         {
            gem = gems[i];
            gem.row = int(i / NUM_COLS);
            gem.col = int(i % NUM_COLS);
            this.mGems[i] = gem;
         }
      }
      
      public function ScrambleGems() : void
      {
         var rowOffset:int = 0;
         var col:int = 0;
         var numCandidates:int = 0;
         var i:int = 0;
         var index:int = 0;
         var a:Gem = null;
         var b:Gem = null;
         var candidates:Array = [];
         var gem:Gem = null;
         for(var row:int = 0; row < NUM_ROWS; row++)
         {
            rowOffset = row * NUM_COLS;
            candidates.length = 0;
            for(col = 0; col < NUM_COLS; col++)
            {
               gem = this.mGems[rowOffset + col];
               if(gem != null)
               {
                  if(!(gem.type == Gem.TYPE_DETONATE || gem.type == Gem.TYPE_SCRAMBLE))
                  {
                     if(gem.isStill())
                     {
                        candidates.push(gem);
                     }
                  }
               }
            }
            if(candidates.length >= 2)
            {
               if(candidates.length == 2)
               {
                  this.SwapGems(candidates[0],candidates[1]);
               }
               numCandidates = candidates.length;
               for(i = 1; i < numCandidates; i++)
               {
                  index = this.mRandom.Int(i - 1);
                  a = candidates[i];
                  b = candidates[index];
                  this.SwapGems(a,b);
               }
            }
         }
      }
      
      public function GetRandomGem() : Gem
      {
         var index:int = 0;
         var gem:Gem = null;
         while(gem == null)
         {
            index = this.mRandom.Int(NUM_GEMS);
            gem = this.mGems[index];
         }
         return gem;
      }
      
      public function GetNumGemsCleared() : int
      {
         return this.mDeadGems;
      }
      
      public function IsStill() : Boolean
      {
         var gem:Gem = null;
         for(var i:int = 0; i < NUM_GEMS; i++)
         {
            gem = this.mGems[i];
            if(gem == null || !gem.isStill())
            {
               return false;
            }
         }
         return true;
      }
      
      public function IsIdle() : Boolean
      {
         var gem:Gem = null;
         for(var i:int = 0; i < NUM_GEMS; i++)
         {
            gem = this.mGems[i];
            if(gem == null || !gem.isIdle())
            {
               return false;
            }
         }
         return true;
      }
      
      public function GetNextActiveCount() : int
      {
         return ++this.mActiveCounter;
      }
      
      public function GetGem(id:int) : Gem
      {
         return this.mGemMap[id];
      }
      
      public function GetGemAt(row:int, col:int) : Gem
      {
         if(row < 0 || col < 0 || row >= HEIGHT || col >= WIDTH)
         {
            return null;
         }
         var index:int = row * WIDTH + col;
         return this.mGems[index];
      }
      
      public function SwapGems(a:Gem, b:Gem) : void
      {
         var index1:int = a.row * WIDTH + a.col;
         var index2:int = b.row * WIDTH + b.col;
         this.mGems[index1] = b;
         this.mGems[index2] = a;
         var tRow:int = a.row;
         var tCol:int = a.col;
         a.row = b.row;
         a.col = b.col;
         b.row = tRow;
         b.col = tCol;
         b.activeCount = this.GetNextActiveCount();
         a.activeCount = this.GetNextActiveCount();
      }
      
      public function KillGems(gems:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            gem.isDead = true;
         }
      }
      
      public function GetGemsByColor(color:int) : Vector.<Gem>
      {
         var gem:Gem = null;
         var gems:Vector.<Gem> = new Vector.<Gem>();
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            if(gem != null)
            {
               if(color == Gem.COLOR_NONE)
               {
                  gems.push(gem);
               }
               else if(gem.color == color && gem.type != Gem.TYPE_RAINBOW)
               {
                  gems.push(gem);
               }
            }
         }
         return gems;
      }
      
      public function GetArea(centerX:Number, centerY:Number, range:Number, results:Vector.<Gem> = null) : Vector.<Gem>
      {
         var gem:Gem = null;
         var left:Number = centerX - range;
         var right:Number = centerX + range;
         var top:Number = centerY - range;
         var bottom:Number = centerY + range;
         var bl:Number = 0;
         var br:Number = WIDTH - 1;
         var bt:Number = -2;
         var bb:Number = HEIGHT - 1;
         left = left > bl ? Number(left) : Number(bl);
         right = right < br ? Number(right) : Number(br);
         top = top > bt ? Number(top) : Number(bt);
         bottom = bottom < bb ? Number(bottom) : Number(bb);
         if(results == null)
         {
            results = new Vector.<Gem>();
         }
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            if(!(gem == null || gem.x < left || gem.x > right || gem.y < top || gem.y > bottom))
            {
               results.push(gem);
            }
         }
         return results;
      }
      
      public function FindHypers() : Boolean
      {
         var col:int = 0;
         var gem:Gem = null;
         var gotHyper:Boolean = false;
         for(var row:int = 0; row < Board.HEIGHT; row++)
         {
            for(col = 0; col < Board.WIDTH; col++)
            {
               gem = this.GetGemAt(row,col);
               if(gem.type == Gem.TYPE_RAINBOW)
               {
                  gotHyper = true;
               }
            }
         }
         return gotHyper;
      }
      
      public function FindMatches() : Vector.<MatchSet>
      {
         var aOtherMatch:Match = null;
         var aSet:MatchSet = null;
         var probe:Match = null;
         var overlaps:Vector.<Match> = null;
         var aNumOverlaps:int = 0;
         var row:int = 0;
         var col:int = 0;
         var aGem:Gem = null;
         var anIndex:int = 0;
         var aMatch:Match = null;
         var matches:Vector.<Match> = this.mTempMatches;
         matches.length = 0;
         for each(aGem in this.mGems)
         {
            if(aGem != null)
            {
               aGem.mHasMatch = false;
            }
         }
         for(col = 0; col < WIDTH; col++)
         {
            this.mMatcher.start(this.mGems[col]);
            for(row = WIDTH; row < NUM_GEMS; row += WIDTH)
            {
               anIndex = row + col;
               aGem = this.mGems[anIndex];
               aMatch = this.mMatcher.push(aGem);
               if(aMatch != null)
               {
                  matches.push(aMatch);
                  for each(aGem in aMatch.mGems)
                  {
                     aGem.mHasMatch = true;
                  }
               }
            }
            aMatch = this.mMatcher.end();
            if(aMatch != null)
            {
               matches.push(aMatch);
            }
         }
         for(row = 0; row < NUM_GEMS; row += WIDTH)
         {
            this.mMatcher.start(this.mGems[row]);
            for(col = 1; col < WIDTH; col++)
            {
               anIndex = row + col;
               aGem = this.mGems[anIndex];
               aMatch = this.mMatcher.push(aGem);
               if(aMatch != null)
               {
                  matches.push(aMatch);
                  for each(aGem in aMatch.mGems)
                  {
                     aGem.mHasMatch = true;
                  }
               }
            }
            aMatch = this.mMatcher.end();
            if(aMatch != null)
            {
               matches.push(aMatch);
            }
         }
         var aNumMatches:int = matches.length;
         var i:int = 0;
         var k:int = 0;
         for(i = 0; i < aNumMatches; i++)
         {
            aMatch = matches[i];
            for(k = i + 1; k < aNumMatches; k++)
            {
               aOtherMatch = matches[k];
               if(aMatch.isOverlapping(aOtherMatch))
               {
                  aMatch.mOverlaps.push(aOtherMatch);
                  aOtherMatch.mOverlaps.push(aMatch);
               }
            }
         }
         var matchSets:Vector.<MatchSet> = new Vector.<MatchSet>();
         var queue:Vector.<Match> = new Vector.<Match>();
         for(i = 0; i < aNumMatches; i++)
         {
            aMatch = matches[i];
            if(aMatch.mSet == null)
            {
               aSet = new MatchSet();
               queue.length = 0;
               queue.push(aMatch);
               while(queue.length > 0)
               {
                  probe = queue.shift() as Match;
                  if(probe.mSet == null)
                  {
                     aSet.mMatches.push(probe);
                     probe.mSet = aSet;
                     overlaps = probe.mOverlaps;
                     aNumOverlaps = overlaps.length;
                     for(k = 0; k < aNumOverlaps; k++)
                     {
                        queue.push(overlaps[k]);
                     }
                  }
               }
               aSet.resolve();
               matchSets.push(aSet);
            }
         }
         return matchSets;
      }
      
      public function SpawnGems(spawnInPlace:Boolean = false) : Vector.<Gem>
      {
         var lowest:int = 0;
         var top:int = 0;
         var row:int = 0;
         var index:int = 0;
         var gem:Gem = null;
         this.freshGems.length = 0;
         for(var col:int = 0; col < WIDTH; col++)
         {
            lowest = -2;
            top = BOTTOM;
            if(spawnInPlace)
            {
               lowest = 7;
            }
            for(row = 0; row <= BOTTOM; row++)
            {
               index = row * WIDTH + col;
               gem = this.mGems[index];
               if(gem != null)
               {
                  top = gem.row - 1;
                  break;
               }
            }
            for(row = top; row >= 0; row--)
            {
               index = row * WIDTH + col;
               gem = this.mGems[index];
               gem = this.mGemPool.GetGem();
               gem.id = this.gemCount++;
               gem.Reset();
               gem.row = row;
               gem.col = col;
               gem.x = col;
               gem.y = lowest;
               gem.activeCount = this.GetNextActiveCount();
               gem.fallVelocity = 0;
               this.mGemMap[gem.id] = gem;
               if(spawnInPlace)
               {
                  lowest -= 1;
               }
               else
               {
                  lowest -= 2;
               }
               this.mGems[index] = gem;
               this.freshGems.push(gem);
            }
         }
         return this.freshGems;
      }
      
      public function GetSpecialGems() : Vector.<int>
      {
         var col:int = 0;
         var gem:Gem = null;
         var specialGems:Vector.<int> = new Vector.<int>();
         for(var row:int = 0; row < Board.HEIGHT; row++)
         {
            for(col = 0; col < Board.WIDTH; col++)
            {
               gem = this.GetGemAt(row,col);
               if(gem.type != Gem.TYPE_STANDARD)
               {
                  specialGems.push(gem.type);
               }
            }
         }
         return specialGems;
      }
      
      public function DropGems() : void
      {
         var foundEmpty:Boolean = false;
         var emptyRow:int = 0;
         var row:int = 0;
         var index:int = 0;
         var gem:Gem = null;
         var emptyIndex:int = 0;
         for(var col:int = 0; col < WIDTH; col++)
         {
            foundEmpty = false;
            emptyRow = HEIGHT;
            for(row = HEIGHT - 1; row >= 0; row--)
            {
               index = row * WIDTH + col;
               gem = this.mGems[index];
               if(gem != null && gem.isDead)
               {
                  ++this.mDeadGems;
               }
               if(gem == null || gem.isDead)
               {
                  this.mGems[index] = null;
               }
               else
               {
                  emptyRow--;
                  if(gem.row != emptyRow)
                  {
                     if(gem.mIsSwapping)
                     {
                        emptyRow = gem.row;
                     }
                     else
                     {
                        this.mGems[index] = null;
                        gem.row = emptyRow;
                        gem.activeCount = this.GetNextActiveCount();
                        emptyIndex = emptyRow * WIDTH + col;
                        this.mGems[emptyIndex] = gem;
                     }
                  }
               }
            }
         }
      }
      
      public function RandomizeColors(gems:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            gem.color = this.RandomColor();
         }
      }
      
      public function GetColorCount(gemColor:int, includeNew:Boolean = true) : int
      {
         var gem:Gem = null;
         var colorCount:int = 0;
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            if(gem != null)
            {
               if(!(gem.lifetime == 0 && !includeNew))
               {
                  if(gem.color == gemColor)
                  {
                     colorCount++;
                  }
               }
            }
         }
         return colorCount;
      }
      
      private function RandomColor() : int
      {
         var index:int = this.mRandom.Int(Gem.GEM_COLORS.length);
         return Gem.GEM_COLORS[index];
      }
   }
}
