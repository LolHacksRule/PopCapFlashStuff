package com.popcap.flash.bejeweledblitz.logic
{
   public class BoardPatternConverter
   {
       
      
      private var _gemColors:GemColors;
      
      public function BoardPatternConverter(param1:GemColors)
      {
         super();
         this._gemColors = param1;
      }
      
      public function convertBoardStringToIntVector(param1:String) : Vector.<Vector.<int>>
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc2_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>(Board.NUM_ROWS);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = param1.substr(_loc5_,1);
            _loc7_ = this._gemColors.getIndexFromChar(_loc6_);
            if(_loc4_ == 0)
            {
               _loc2_[_loc3_] = new Vector.<int>();
            }
            _loc2_[_loc3_].push(_loc7_);
            _loc4_++;
            if(_loc4_ >= 8)
            {
               _loc4_ = 0;
               _loc3_++;
            }
            _loc5_++;
         }
         return _loc2_;
      }
   }
}
