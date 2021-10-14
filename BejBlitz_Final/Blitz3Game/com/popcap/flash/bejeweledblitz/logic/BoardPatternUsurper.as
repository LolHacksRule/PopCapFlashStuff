package com.popcap.flash.bejeweledblitz.logic
{
   public class BoardPatternUsurper
   {
       
      
      public function BoardPatternUsurper()
      {
         super();
      }
      
      public function overridePattern(param1:Vector.<Vector.<int>>, param2:IBoard) : void
      {
         var _loc5_:Gem = null;
         var _loc3_:Vector.<Gem> = new Vector.<Gem>();
         var _loc4_:Vector.<Gem> = param2.GetGems();
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length)
         {
            if((_loc5_ = _loc4_[_loc6_]).type == Gem.TYPE_STANDARD || _loc5_.type == Gem.TYPE_MULTI || _loc5_.type == Gem.TYPE_FLAME || _loc5_.type == Gem.TYPE_STAR)
            {
               _loc5_.color = param1[_loc5_.row][_loc5_.col];
            }
            _loc3_.push(_loc4_[_loc6_]);
            _loc6_++;
         }
         param2.SetGemArray(_loc3_);
      }
   }
}
