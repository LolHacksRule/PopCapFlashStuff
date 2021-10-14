package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class Match implements IPoolObject
   {
       
      
      public var matchId:int;
      
      public var cascadeId:int;
      
      public var matchGems:Vector.<Gem>;
      
      public var overlaps:Vector.<Match>;
      
      public var matchColor:int;
      
      public var left:int;
      
      public var right:int;
      
      public var top:int;
      
      public var bottom:int;
      
      public var matchSet:MatchSet;
      
      private var m_X:Number;
      
      private var m_Y:Number;
      
      public function Match()
      {
         super();
         this.overlaps = new Vector.<Match>();
         this.matchGems = new Vector.<Gem>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.matchId = 0;
         this.cascadeId = 0;
         this.matchGems.length = 0;
         this.overlaps.length = 0;
         this.matchColor = Gem.COLOR_NONE;
         this.left = -1;
         this.right = -1;
         this.top = -1;
         this.bottom = -1;
         this.matchSet = null;
         this.m_X = 0;
         this.m_Y = 0;
      }
      
      public function Init(gems:Vector.<Gem>, color:int) : void
      {
         var i:int = 0;
         var gem:Gem = null;
         var row:int = 0;
         var col:int = 0;
         this.matchGems.length = 0;
         var numGems:int = gems.length;
         this.matchGems.length = numGems;
         for(i = 0; i < numGems; i++)
         {
            this.matchGems[i] = gems[i];
         }
         this.matchColor = color;
         this.left = Board.WIDTH;
         this.right = -1;
         this.top = Board.HEIGHT;
         this.bottom = -1;
         for(i = 0; i < numGems; i++)
         {
            gem = this.matchGems[i];
            row = gem.row;
            col = gem.col;
            this.left = col < this.left ? int(col) : int(this.left);
            this.right = col > this.right ? int(col) : int(this.right);
            this.top = row < this.top ? int(row) : int(this.top);
            this.bottom = row > this.bottom ? int(row) : int(this.bottom);
            gem.mHasMatch = true;
            this.cascadeId = gem.mMoveId > this.cascadeId ? int(gem.mMoveId) : int(this.cascadeId);
         }
         for(i = 0; i < numGems; i++)
         {
            gem = this.matchGems[i];
            gem.mMoveId = this.cascadeId;
         }
         this.overlaps.length = 0;
         this.m_X = this.left + (this.right - this.left) * 0.5;
         this.m_Y = this.top + (this.bottom - this.top) * 0.5;
      }
      
      public function IsOverlapping(other:Match) : Boolean
      {
         if(this.left > other.right)
         {
            return false;
         }
         if(this.right < other.left)
         {
            return false;
         }
         if(this.top > other.bottom)
         {
            return false;
         }
         if(this.bottom < other.top)
         {
            return false;
         }
         return true;
      }
   }
}
