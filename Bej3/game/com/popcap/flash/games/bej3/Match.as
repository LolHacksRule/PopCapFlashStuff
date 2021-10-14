package com.popcap.flash.games.bej3
{
   public class Match
   {
       
      
      public var mMatchId:int = 0;
      
      public var mCascadeId:int = 0;
      
      public var mGems:Vector.<Gem>;
      
      public var mOverlaps:Vector.<Match>;
      
      public var mDeferred:Boolean = false;
      
      public var mLeft:int = -1;
      
      public var mRight:int = -1;
      
      public var mTop:int = -1;
      
      public var mBottom:int = -1;
      
      public var mSet:MatchSet = null;
      
      public var mX:Number = 0;
      
      public var mY:Number = 0;
      
      public function Match()
      {
         this.mOverlaps = new Vector.<Match>();
         super();
      }
      
      public function init(gems:Vector.<Gem>) : void
      {
         var gem:Gem = null;
         var row:int = 0;
         var col:int = 0;
         this.mGems = gems;
         this.mLeft = Board.WIDTH;
         this.mRight = -1;
         this.mTop = Board.HEIGHT;
         this.mBottom = -1;
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            row = gem.row;
            col = gem.col;
            this.mLeft = col < this.mLeft ? int(col) : int(this.mLeft);
            this.mRight = col > this.mRight ? int(col) : int(this.mRight);
            this.mTop = row < this.mTop ? int(row) : int(this.mTop);
            this.mBottom = row > this.mBottom ? int(row) : int(this.mBottom);
            gem.mHasMatch = true;
            this.mCascadeId = gem.mMoveId > this.mCascadeId ? int(gem.mMoveId) : int(this.mCascadeId);
         }
         for(i = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            gem.mMoveId = this.mCascadeId;
         }
         this.mOverlaps.length = 0;
         this.mX = this.mLeft + (this.mRight - this.mLeft) / 2;
         this.mY = this.mTop + (this.mBottom - this.mTop) / 2;
      }
      
      public function isOverlapping(other:Match) : Boolean
      {
         if(this.mLeft > other.mRight)
         {
            return false;
         }
         if(this.mRight < other.mLeft)
         {
            return false;
         }
         if(this.mTop > other.mBottom)
         {
            return false;
         }
         if(this.mBottom < other.mTop)
         {
            return false;
         }
         return true;
      }
      
      public function toString() : String
      {
         var str:String = "( ";
         for(var i:int = 0; i < this.mGems.length; i++)
         {
            str += this.mGems[i] + " ";
         }
         return str + ")";
      }
   }
}
