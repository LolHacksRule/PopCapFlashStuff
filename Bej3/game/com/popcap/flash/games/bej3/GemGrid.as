package com.popcap.flash.games.bej3
{
   public class GemGrid
   {
       
      
      private var mGrid:Vector.<Vector.<Gem>>;
      
      private var mRows:int = 0;
      
      private var mCols:int = 0;
      
      private var mNumGems:int = 0;
      
      public function GemGrid(rows:int, cols:int)
      {
         super();
         this.mRows = rows;
         this.mCols = cols;
         this.mNumGems = rows * cols;
         this.mGrid = new Vector.<Vector.<Gem>>(rows,true);
         for(var row:int = 0; row < rows; row++)
         {
            this.mGrid[row] = new Vector.<Gem>(cols,true);
         }
         this.Reset();
      }
      
      public function Reset() : void
      {
         var row:Vector.<Gem> = null;
         var c:int = 0;
         for(var r:int = 0; r < this.mGrid.length; r++)
         {
            row = this.mGrid[r];
            for(c = 0; c < row.length; c++)
            {
               row[c] = null;
            }
         }
      }
      
      public function getRows() : int
      {
         return this.mRows;
      }
      
      public function getCols() : int
      {
         return this.mCols;
      }
      
      public function getNumGems() : int
      {
         return this.mNumGems;
      }
      
      public function getArea(row:int, col:int, range:int) : Vector.<Gem>
      {
         var c:int = 0;
         var gems:Vector.<Gem> = new Vector.<Gem>();
         var left:int = col - range;
         var right:int = col + range;
         var top:int = row - range;
         var bottom:int = row + range;
         var bl:int = 0;
         var br:int = this.mCols - 1;
         var bt:int = 0;
         var bb:int = this.mRows - 1;
         left = left > bl ? int(left) : int(bl);
         right = right < br ? int(right) : int(br);
         top = top > bt ? int(top) : int(bt);
         bottom = bottom < bb ? int(bottom) : int(bb);
         for(var r:int = top; r <= bottom; r++)
         {
            for(c = left; c <= right; c++)
            {
               gems.push(this.getGem(r,c));
            }
         }
         return gems;
      }
      
      public function getCross(row:int, col:int, range:int, includeLocus:Boolean = false) : Vector.<Gem>
      {
         var gems:Vector.<Gem> = new Vector.<Gem>();
         var left:int = col - range;
         var right:int = col + range;
         var top:int = row - range;
         var bottom:int = row + range;
         var bl:int = 0;
         var br:int = this.mCols - 1;
         var bt:int = 0;
         var bb:int = this.mRows - 1;
         left = left > bl ? int(left) : int(bl);
         right = right < br ? int(right) : int(br);
         top = top > bt ? int(top) : int(bt);
         bottom = bottom < bb ? int(bottom) : int(bb);
         var gem:Gem = null;
         if(includeLocus)
         {
            gems.push(this.getGem(row,col));
         }
         for(var r:int = top; r <= bottom; r++)
         {
            if(r != row)
            {
               gems.push(this.getGem(r,col));
            }
         }
         for(var c:int = left; c <= right; c++)
         {
            if(c != col)
            {
               gems.push(this.getGem(row,c));
            }
         }
         return gems;
      }
      
      public function getGem(row:int, col:int) : Gem
      {
         if(row < 0 || col < 0 || row >= this.mRows || col >= this.mCols)
         {
            return null;
         }
         return this.mGrid[row][col];
      }
      
      public function setGem(row:int, col:int, gem:Gem) : void
      {
         if(row < 0 || col < 0 || row >= this.mRows || col >= this.mCols)
         {
            return;
         }
         this.mGrid[row][col] = gem;
      }
      
      public function clearGrid() : void
      {
         var col:int = 0;
         for(var row:int = 0; row < this.mRows; row++)
         {
            for(col = 0; col < this.mCols; col++)
            {
               this.mGrid[row][col] = null;
            }
         }
      }
      
      public function toString() : String
      {
         var col:int = 0;
         var gem:Gem = null;
         var str:String = "";
         for(var row:int = 0; row < this.mRows; row++)
         {
            for(col = 0; col < this.mCols; col++)
            {
               gem = this.getGem(row,col);
               if(gem == null)
               {
                  str += "  ";
               }
               else
               {
                  str += gem.toColorString() + " ";
               }
            }
            str += "\n";
         }
         return str;
      }
   }
}
