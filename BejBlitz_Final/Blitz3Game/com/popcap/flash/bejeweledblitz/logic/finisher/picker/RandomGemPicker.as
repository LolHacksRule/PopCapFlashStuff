package com.popcap.flash.bejeweledblitz.logic.finisher.picker
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.math.MersenneTwister;
   
   public class RandomGemPicker implements IGemPicker
   {
       
      
      private var pattern:Vector.<Vector.<String>>;
      
      private var nonZeroRows:Vector.<int>;
      
      private var _gameBoard:Board = null;
      
      private var _logic:BlitzLogic = null;
      
      private var _random:BlitzRandom = null;
      
      public function RandomGemPicker(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._gameBoard = this._logic.board;
         this.pattern = new Vector.<Vector.<String>>();
         this._random = new BlitzRandom(new MersenneTwister());
         this._random.SetSeed(this._logic.GetCurrentSeed());
      }
      
      public function addPattern(param1:Vector.<String>) : void
      {
         this.pattern.push(param1);
      }
      
      public function PostAddingPattern() : void
      {
         this.PickNonZeroRow();
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
      
      public function GetGem() : Gem
      {
         if(this.nonZeroRows.length == 0)
         {
            return null;
         }
         var _loc1_:int = this.nonZeroRows[Math.floor(this._random.Float(0,1) * (this.nonZeroRows.length - 1))];
         var _loc2_:Vector.<String> = this.pattern[_loc1_];
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_] != "0")
            {
               _loc3_.push(_loc4_);
            }
            _loc4_++;
         }
         var _loc5_:Number = Math.floor(this._random.Float(0,1) * (_loc3_.length - 1)) + 1;
         if(_loc3_.length == 0 || _loc5_ >= _loc3_.length || _loc5_ < 0)
         {
            return null;
         }
         return this._logic.board.GetGemAt(_loc1_,_loc3_[_loc5_]);
      }
      
      public function GetName() : String
      {
         return "RandomGemPicker";
      }
      
      public function Release() : void
      {
      }
   }
}
