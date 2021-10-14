package com.popcap.flash.bejeweledblitz.logic.finisher.picker
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class CustomGemPickerLtoR implements IGemPicker
   {
       
      
      private var pattern:Vector.<Vector.<String>>;
      
      private var nonZeroRows:Vector.<int>;
      
      private var nonZeroCols:Vector.<int>;
      
      private var _gameBoard:Board = null;
      
      private var _logic:BlitzLogic = null;
      
      private var currRow:int = 0;
      
      private var currCol:int = 0;
      
      public function CustomGemPickerLtoR(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._gameBoard = this._logic.board;
         this.pattern = new Vector.<Vector.<String>>();
      }
      
      public function addPattern(param1:Vector.<String>) : void
      {
         this.pattern.push(param1);
      }
      
      public function PostAddingPattern() : void
      {
         this.PickNonZeroRow();
         this.PickNonZeroCol();
         this.currCol = 0;
         this.currRow = 0;
      }
      
      private function PickNonZeroRow() : void
      {
         var _loc4_:Vector.<String> = null;
         var _loc5_:int = 0;
         this.nonZeroRows = new Vector.<int>();
         var _loc1_:int = this.pattern.length;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = (_loc4_ = this.pattern[_loc3_]).length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               if(_loc4_[_loc5_] != "0")
               {
                  this.nonZeroRows.push(_loc3_);
                  break;
               }
               _loc5_++;
            }
            _loc3_++;
         }
      }
      
      private function PickNonZeroCol() : void
      {
         var _loc4_:int = 0;
         this.nonZeroCols = new Vector.<int>();
         var _loc1_:int = this.pattern[0].length;
         var _loc2_:int = this.pattern.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               if(this.pattern[_loc4_][_loc3_] != "0")
               {
                  this.nonZeroCols.push(_loc3_);
                  break;
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function GetGem() : Gem
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(this.currCol < this.nonZeroCols.length)
         {
            _loc1_ = this.nonZeroCols[this.currCol];
            _loc2_ = this.currRow;
            while(_loc2_ < this.pattern.length)
            {
               if(this.pattern[_loc2_][_loc1_] != "0")
               {
                  this.currRow = _loc2_ + 1;
                  return this._logic.board.GetGemAt(_loc2_,_loc1_);
               }
               _loc2_++;
            }
            this.currCol += 1;
            this.currRow = 0;
         }
         return null;
      }
      
      public function GetName() : String
      {
         return "CustomGemPicker";
      }
      
      public function Release() : void
      {
      }
   }
}
