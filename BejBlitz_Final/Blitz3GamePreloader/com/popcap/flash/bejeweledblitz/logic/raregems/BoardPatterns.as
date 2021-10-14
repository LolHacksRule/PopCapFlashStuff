package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class BoardPatterns
   {
       
      
      protected var _boardPatterns:Vector.<Vector.<Vector.<int>>>;
      
      protected var _logic:BlitzLogic;
      
      private var _currentBoardPatternsIndex:int = 0;
      
      public function BoardPatterns()
      {
         super();
      }
      
      public function InitPatterns(param1:BlitzLogic) : void
      {
         this._logic = param1;
         this.clearBoardPatterns();
      }
      
      public function getCurrentFirstRow() : Vector.<int>
      {
         if(this._boardPatterns.length <= 0)
         {
            return new Vector.<int>();
         }
         return this._boardPatterns[this._currentBoardPatternsIndex][0];
      }
      
      public function clearBoardPatterns() : void
      {
         this._currentBoardPatternsIndex = 0;
         this._boardPatterns = new Vector.<Vector.<Vector.<int>>>(0);
      }
      
      public function getRandomBoard() : Vector.<Vector.<int>>
      {
         this._currentBoardPatternsIndex = this._logic.GetPrimaryRNG().Int(0,this._boardPatterns.length);
         return this._boardPatterns[this._currentBoardPatternsIndex];
      }
      
      public function getCurrentBoardPatternsIndex() : int
      {
         return this._currentBoardPatternsIndex;
      }
      
      public function getNumBoards() : int
      {
         return this._boardPatterns.length;
      }
      
      public function parseBoardString(param1:String) : void
      {
         var _loc3_:String = null;
         if(param1.length != Board.NUM_ROWS * Board.NUM_COLS)
         {
            return;
         }
         var _loc2_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(Board.NUM_ROWS);
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            _loc3_ = param1.substr(_loc7_,1);
            if(_loc3_ == "R")
            {
               _loc4_ = Gem.COLOR_RED;
            }
            else if(_loc3_ == "O")
            {
               _loc4_ = Gem.COLOR_ORANGE;
            }
            else if(_loc3_ == "Y")
            {
               _loc4_ = Gem.COLOR_YELLOW;
            }
            else if(_loc3_ == "G")
            {
               _loc4_ = Gem.COLOR_GREEN;
            }
            else if(_loc3_ == "B")
            {
               _loc4_ = Gem.COLOR_BLUE;
            }
            else if(_loc3_ == "P")
            {
               _loc4_ = Gem.COLOR_PURPLE;
            }
            else
            {
               if(_loc3_ != "W")
               {
                  return;
               }
               _loc4_ = Gem.COLOR_WHITE;
            }
            if(_loc6_ == 0)
            {
               _loc2_[_loc5_] = new Vector.<int>();
            }
            _loc2_[_loc5_].push(_loc4_);
            _loc6_++;
            if(_loc6_ >= 8)
            {
               _loc6_ = 0;
               _loc5_++;
            }
            _loc7_++;
         }
         this._boardPatterns.push(_loc2_);
      }
   }
}
