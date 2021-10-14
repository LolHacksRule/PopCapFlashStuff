package com.popcap.flash.bejeweledblitz.logic
{
   public class GemGrid
   {
       
      
      private var mGrid:Vector.<Vector.<Gem>>;
      
      private var mRows:int;
      
      private var mCols:int;
      
      private var mNumGems:int;
      
      public function GemGrid(rows:int, cols:int)
      {
         super();
         this.mRows = rows;
         this.mCols = cols;
         this.mNumGems = rows * cols;
         this.mGrid = new Vector.<Vector.<Gem>>(rows);
         for(var row:int = 0; row < rows; row++)
         {
            this.mGrid[row] = new Vector.<Gem>(cols);
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
   }
}
