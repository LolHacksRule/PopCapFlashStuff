package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
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
      
      public var gemCount:int;
      
      public var mGems:Vector.<Gem>;
      
      public var freshGems:Vector.<Gem>;
      
      private var mRandom:BlitzRandom;
      
      public var matchGenerator:MatchGenerator;
      
      private var mMatches:Vector.<Match>;
      
      private var mMoves:Vector.<MoveData>;
      
      private var mActiveCounter:int;
      
      public var gemPool:GemPool;
      
      private var mDeadGems:int;
      
      private var m_Candidates:Vector.<Gem>;
      
      private var m_GemMap:Vector.<Gem>;
      
      private var m_EmptyOverrides:Vector.<int>;
      
      public function Board(logic:BlitzLogic, generator:BlitzRandom)
      {
         super();
         this.mRandom = generator;
         this.gemCount = 0;
         this.freshGems = new Vector.<Gem>();
         this.matchGenerator = new MatchGenerator(logic);
         this.mMatches = new Vector.<Match>();
         this.mMoves = new Vector.<MoveData>();
         this.mActiveCounter = 0;
         this.mDeadGems = 0;
         this.m_Candidates = new Vector.<Gem>();
         this.gemPool = new GemPool();
         this.mGems = new Vector.<Gem>(NUM_GEMS);
         this.moveFinder = new MoveFinder(logic);
         this.m_GemMap = new Vector.<Gem>();
         this.m_EmptyOverrides = new Vector.<int>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.gemPool.Reset();
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
         this.matchGenerator.Reset();
         this.m_GemMap.length = 0;
         this.m_Candidates.length = 0;
         this.mRandom.Reset();
      }
      
      public function CopyGemArray(dest:Vector.<Gem>) : void
      {
         dest.length = 0;
         dest.length = NUM_GEMS;
         for(var i:int = 0; i < NUM_GEMS; i++)
         {
            dest[i] = this.mGems[i];
         }
      }
      
      public function SetGemArray(gems:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         for(var i:int = 0; i < NUM_GEMS; i++)
         {
            gem = gems[i];
            gem.row = i / NUM_COLS;
            gem.col = i % NUM_COLS;
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
         this.m_Candidates.length = 0;
         var gem:Gem = null;
         for(var row:int = 0; row < NUM_ROWS; row++)
         {
            rowOffset = row * NUM_COLS;
            this.m_Candidates.length = 0;
            for(col = 0; col < NUM_COLS; col++)
            {
               gem = this.mGems[rowOffset + col];
               if(gem != null)
               {
                  if(!(gem.type == Gem.TYPE_DETONATE || gem.type == Gem.TYPE_SCRAMBLE))
                  {
                     if(gem.isStill())
                     {
                        this.m_Candidates.push(gem);
                     }
                  }
               }
            }
            if(this.m_Candidates.length >= 2)
            {
               if(this.m_Candidates.length == 2)
               {
                  this.SwapGems(this.m_Candidates[0],this.m_Candidates[1]);
               }
               numCandidates = this.m_Candidates.length;
               for(i = 1; i < numCandidates; i++)
               {
                  index = this.mRandom.Int(0,i - 1);
                  a = this.m_Candidates[i];
                  b = this.m_Candidates[index];
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
            index = this.mRandom.Int(0,NUM_GEMS);
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
         if(id < 0 || id >= this.m_GemMap.length)
         {
            return null;
         }
         return this.m_GemMap[id];
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
            gem.SetDead(true);
         }
      }
      
      public function GetGemsByColor(color:int, dest:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         dest.length = 0;
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            if(gem != null)
            {
               if(color == Gem.COLOR_NONE)
               {
                  dest.push(gem);
               }
               else if(gem.color == color && gem.type != Gem.TYPE_HYPERCUBE)
               {
                  dest.push(gem);
               }
            }
         }
      }
      
      public function GetArea(centerX:Number, centerY:Number, range:Number, results:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         var left:Number = centerX - range;
         var right:Number = centerX + range;
         var top:Number = centerY - range;
         var bottom:Number = centerY + range;
         var br:Number = WIDTH - 1;
         var bb:Number = HEIGHT - 1;
         left = left > 0 ? Number(left) : Number(0);
         right = right < br ? Number(right) : Number(br);
         top = top > -2 ? Number(top) : Number(-2);
         bottom = bottom < bb ? Number(bottom) : Number(bb);
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            if(!(gem == null || gem.x < left || gem.x > right || gem.y < top || gem.y > bottom))
            {
               results.push(gem);
            }
         }
      }
      
      public function FindMatches(matchSets:Vector.<MatchSet>) : void
      {
         return this.matchGenerator.FindMatches(this.mGems,this.m_EmptyOverrides,matchSets);
      }
      
      public function SpawnGems() : Vector.<Gem>
      {
         var lowest:int = 0;
         var top:int = 0;
         var gem:Gem = null;
         var row:int = 0;
         var index:int = 0;
         this.freshGems.length = 0;
         for(var col:int = 0; col < WIDTH; col++)
         {
            lowest = -2;
            top = BOTTOM;
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
               gem = this.gemPool.GetNextGem();
               gem.id = this.gemCount++;
               gem.Reset();
               gem.row = row;
               gem.col = col;
               gem.x = col;
               gem.y = lowest;
               gem.activeCount = this.GetNextActiveCount();
               gem.fallVelocity = 0;
               if(gem.id >= this.m_GemMap.length)
               {
                  this.m_GemMap.length = gem.id + 1;
               }
               this.m_GemMap[gem.id] = gem;
               lowest -= 2;
               this.mGems[index] = gem;
               this.freshGems.push(gem);
            }
         }
         return this.freshGems;
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
               if(gem != null && gem.IsDead())
               {
                  ++this.mDeadGems;
               }
               if(gem == null || gem.IsDead())
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
      
      public function GetColorCount(gemColor:int, includeNew:Boolean) : int
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
         var index:int = this.mRandom.Int(0,Gem.GEM_COLORS.length);
         return Gem.GEM_COLORS[index];
      }
   }
}
