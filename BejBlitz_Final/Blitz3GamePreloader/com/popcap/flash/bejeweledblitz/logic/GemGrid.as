package com.popcap.flash.bejeweledblitz.logic
{
   public class GemGrid
   {
       
      
      private var mGrid:Vector.<Vector.<Gem>>;
      
      private var mRows:int;
      
      private var mCols:int;
      
      private var mNumGems:int;
      
      public function GemGrid(param1:int, param2:int)
      {
         super();
         this.mRows = param1;
         this.mCols = param2;
         this.mNumGems = param1 * param2;
         this.mGrid = new Vector.<Vector.<Gem>>(param1);
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            this.mGrid[_loc3_] = new Vector.<Gem>(param2);
            _loc3_++;
         }
         this.Reset();
      }
      
      public function Reset() : void
      {
         var _loc2_:Vector.<Gem> = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.mGrid.length)
         {
            _loc2_ = this.mGrid[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc2_[_loc3_] = null;
               _loc3_++;
            }
            _loc1_++;
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
      
      public function getGem(param1:int, param2:int) : Gem
      {
         if(param1 < 0 || param2 < 0 || param1 >= this.mRows || param2 >= this.mCols)
         {
            return null;
         }
         return this.mGrid[param1][param2];
      }
      
      public function setGem(param1:int, param2:int, param3:Gem) : void
      {
         if(param1 < 0 || param2 < 0 || param1 >= this.mRows || param2 >= this.mCols)
         {
            return;
         }
         this.mGrid[param1][param2] = param3;
      }
      
      public function clearGrid() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.mRows)
         {
            _loc2_ = 0;
            while(_loc2_ < this.mCols)
            {
               this.mGrid[_loc1_][_loc2_] = null;
               _loc2_++;
            }
            _loc1_++;
         }
      }
   }
}
