package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class MoveFinder
   {
      
      public static const NEIGHBOR_NW:int = -Board.WIDTH - 1;
      
      public static const NEIGHBOR_N:int = -Board.WIDTH;
      
      public static const NEIGHBOR_NE:int = -Board.WIDTH + 1;
      
      public static const NEIGHBOR_E:int = 1;
      
      public static const NEIGHBOR_SE:int = Board.WIDTH + 1;
      
      public static const NEIGHBOR_S:int = Board.WIDTH;
      
      public static const NEIGHBOR_SW:int = Board.WIDTH - 1;
      
      public static const NEIGHBOR_W:int = -1;
      
      public static const NEIGHBOR_NNE:int = -Board.WIDTH - Board.WIDTH + 1;
      
      public static const NEIGHBOR_NNW:int = -Board.WIDTH - Board.WIDTH - 1;
      
      public static const NEIGHBOR_SSE:int = Board.WIDTH + Board.WIDTH + 1;
      
      public static const NEIGHBOR_SSW:int = Board.WIDTH + Board.WIDTH - 1;
      
      public static const NEIGHBOR_NEE:int = -Board.WIDTH + 2;
      
      public static const NEIGHBOR_NWW:int = -Board.WIDTH - 2;
      
      public static const NEIGHBOR_SEE:int = Board.WIDTH + 2;
      
      public static const NEIGHBOR_SWW:int = Board.WIDTH - 2;
      
      public static const NEIGHBOR_NN:int = -Board.WIDTH - Board.WIDTH;
      
      public static const NEIGHBOR_NNN:int = -Board.WIDTH - Board.WIDTH - Board.WIDTH;
      
      public static const NEIGHBOR_EE:int = 2;
      
      public static const NEIGHBOR_EEE:int = 3;
      
      public static const NEIGHBOR_SS:int = Board.WIDTH + Board.WIDTH;
      
      public static const NEIGHBOR_SSS:int = Board.WIDTH + Board.WIDTH + Board.WIDTH;
      
      public static const NEIGHBOR_WW:int = -2;
      
      public static const NEIGHBOR_WWW:int = -3;
       
      
      private var m_Logic:BlitzLogic;
      
      public function MoveFinder(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function Reset() : void
      {
      }
      
      public function FindAllMoves(param1:Board, param2:Vector.<MoveData>) : void
      {
         param2.length = 0;
         var _loc3_:Vector.<Gem> = param1.mGems;
         var _loc4_:int = 0;
         var _loc5_:Gem = null;
         var _loc6_:int = Board.NUM_GEMS;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            if((_loc5_ = _loc3_[_loc4_]) != null)
            {
               _loc5_.hasMove = false;
               _loc5_.isMatchee = false;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            if((_loc5_ = _loc3_[_loc4_]) != null)
            {
               this.FindMoves(param1,_loc3_[_loc4_],param2);
            }
            _loc4_++;
         }
      }
      
      public function FindMoves(param1:Board, param2:Gem, param3:Vector.<MoveData>) : void
      {
         var _loc12_:Gem = null;
         if(!param2.movePolicy.hasMoves)
         {
            return;
         }
         var _loc4_:Vector.<Gem> = param1.mGems;
         var _loc5_:int = param2.row;
         var _loc6_:int = param2.col;
         var _loc7_:int = _loc5_ * Board.WIDTH + _loc6_;
         var _loc8_:Boolean = _loc5_ > Board.TOP && _loc4_[_loc7_ + NEIGHBOR_N] != null && _loc4_[_loc7_ + NEIGHBOR_N].movePolicy.canSwapSouth;
         var _loc9_:Boolean = _loc6_ < Board.RIGHT && _loc4_[_loc7_ + NEIGHBOR_E] != null && _loc4_[_loc7_ + NEIGHBOR_E].movePolicy.canSwapWest;
         var _loc10_:Boolean = _loc5_ < Board.BOTTOM && _loc4_[_loc7_ + NEIGHBOR_S] != null && _loc4_[_loc7_ + NEIGHBOR_S].movePolicy.canSwapNorth;
         var _loc11_:Boolean = _loc6_ > Board.LEFT && _loc4_[_loc7_ + NEIGHBOR_W] != null && _loc4_[_loc7_ + NEIGHBOR_W].movePolicy.canSwapEast;
         if(_loc8_ && param2.movePolicy.hasMoveNorth)
         {
            param2.hasMove = true;
            (_loc12_ = _loc4_[_loc7_ + NEIGHBOR_N]).isMatchee = true;
            this.addMove(param2,_loc12_,param3);
         }
         if(_loc9_ && param2.movePolicy.hasMoveEast)
         {
            param2.hasMove = true;
            (_loc12_ = _loc4_[_loc7_ + NEIGHBOR_E]).isMatchee = true;
            this.addMove(param2,_loc12_,param3);
         }
         if(_loc10_ && param2.movePolicy.hasMoveSouth)
         {
            param2.hasMove = true;
            (_loc12_ = _loc4_[_loc7_ + NEIGHBOR_S]).isMatchee = true;
            this.addMove(param2,_loc12_,param3);
         }
         if(_loc11_ && param2.movePolicy.hasMoveWest)
         {
            param2.hasMove = true;
            (_loc12_ = _loc4_[_loc7_ + NEIGHBOR_W]).isMatchee = true;
            this.addMove(param2,_loc12_,param3);
         }
         var _loc13_:Boolean = _loc5_ > 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NN],param2);
         var _loc14_:Boolean = _loc5_ > 2 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NNN],param2);
         var _loc15_:Boolean = _loc6_ > 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_WW],param2);
         var _loc16_:Boolean = _loc6_ > 2 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_WWW],param2);
         var _loc17_:Boolean = _loc5_ < Board.HEIGHT - 2 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SS],param2);
         var _loc18_:Boolean = _loc5_ < Board.HEIGHT - 3 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SSS],param2);
         var _loc19_:Boolean = _loc6_ < Board.WIDTH - 2 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_EE],param2);
         var _loc20_:Boolean = _loc6_ < Board.WIDTH - 3 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_EEE],param2);
         var _loc21_:Boolean = _loc5_ > 0 && _loc6_ > 0 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NW],param2);
         var _loc22_:Boolean = _loc5_ > 1 && _loc6_ > 0 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NNW],param2);
         var _loc23_:Boolean = _loc5_ > 0 && _loc6_ > 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NWW],param2);
         var _loc24_:Boolean = _loc5_ > 0 && _loc6_ < Board.WIDTH - 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NE],param2);
         var _loc25_:Boolean = _loc5_ > 1 && _loc6_ < Board.WIDTH - 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NNE],param2);
         var _loc26_:Boolean = _loc5_ > 0 && _loc6_ < Board.WIDTH - 2 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_NEE],param2);
         var _loc27_:Boolean = _loc5_ < Board.HEIGHT - 1 && _loc6_ > 0 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SW],param2);
         var _loc28_:Boolean = _loc5_ < Board.HEIGHT - 2 && _loc6_ > 0 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SSW],param2);
         var _loc29_:Boolean = _loc5_ < Board.HEIGHT - 1 && _loc6_ > 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SWW],param2);
         var _loc30_:Boolean = _loc5_ < Board.HEIGHT - 1 && _loc6_ < Board.WIDTH - 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SE],param2);
         var _loc31_:Boolean = _loc5_ < Board.HEIGHT - 2 && _loc6_ < Board.WIDTH - 1 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SSE],param2);
         var _loc32_:Boolean = _loc5_ < Board.HEIGHT - 1 && _loc6_ < Board.WIDTH - 2 && this.isMatch(_loc4_[_loc7_ + NEIGHBOR_SEE],param2);
         var _loc33_:Boolean = false;
         if(_loc8_)
         {
            _loc33_ = false;
            if(_loc23_ && _loc21_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NWW,NEIGHBOR_NW);
            }
            if(_loc21_ && _loc24_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NW,NEIGHBOR_NE);
            }
            if(_loc24_ && _loc26_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NE,NEIGHBOR_NEE);
            }
            if(_loc13_ && _loc14_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NN,NEIGHBOR_NNN);
            }
            if(_loc33_)
            {
               this.addMove(param2,_loc4_[_loc7_ + NEIGHBOR_N],param3);
            }
         }
         if(_loc9_)
         {
            _loc33_ = false;
            if(_loc25_ && _loc24_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NNE,NEIGHBOR_NE);
            }
            if(_loc24_ && _loc30_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NE,NEIGHBOR_SE);
            }
            if(_loc30_ && _loc31_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_SE,NEIGHBOR_SSE);
            }
            if(_loc19_ && _loc20_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_EE,NEIGHBOR_EEE);
            }
            if(_loc33_)
            {
               this.addMove(param2,_loc4_[_loc7_ + NEIGHBOR_E],param3);
            }
         }
         if(_loc10_)
         {
            _loc33_ = false;
            if(_loc29_ && _loc27_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_SWW,NEIGHBOR_SW);
            }
            if(_loc27_ && _loc30_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_SW,NEIGHBOR_SE);
            }
            if(_loc30_ && _loc32_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_SE,NEIGHBOR_SEE);
            }
            if(_loc17_ && _loc18_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_SS,NEIGHBOR_SSS);
            }
            if(_loc33_)
            {
               this.addMove(param2,_loc4_[_loc7_ + NEIGHBOR_S],param3);
            }
         }
         if(_loc11_)
         {
            _loc33_ = false;
            if(_loc22_ && _loc21_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NNW,NEIGHBOR_NW);
            }
            if(_loc21_ && _loc27_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_NW,NEIGHBOR_SW);
            }
            if(_loc27_ && _loc28_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_SW,NEIGHBOR_SSW);
            }
            if(_loc15_ && _loc16_)
            {
               _loc33_ = this.setMatch(_loc4_,param2,_loc7_,NEIGHBOR_WW,NEIGHBOR_WWW);
            }
            if(_loc33_)
            {
               this.addMove(param2,_loc4_[_loc7_ + NEIGHBOR_W],param3);
            }
         }
      }
      
      private function isMatch(param1:Gem, param2:Gem) : Boolean
      {
         return param1 != null && param1.canMatch() && (param1.color == param2.color || param1.type == Gem.TYPE_PHOENIXPRISM || param2.type == Gem.TYPE_PHOENIXPRISM);
      }
      
      private function setMatch(param1:Vector.<Gem>, param2:Gem, param3:int, param4:int, param5:int) : Boolean
      {
         if(param2.type == Gem.TYPE_PHOENIXPRISM && param1[param3 + param4].color != param1[param3 + param5].color)
         {
            return false;
         }
         param2.hasMove = true;
         param1[param3 + param4].isMatchee = true;
         param1[param3 + param5].isMatchee = true;
         return true;
      }
      
      private function addMove(param1:Gem, param2:Gem, param3:Vector.<MoveData>) : void
      {
         var _loc4_:MoveData;
         (_loc4_ = this.m_Logic.movePool.GetMove()).sourceGem = param1;
         _loc4_.sourcePos.x = param1.col;
         _loc4_.sourcePos.y = param1.row;
         _loc4_.isSwap = param1.movePolicy.canSwap;
         if(param2 != null)
         {
            _loc4_.swapDir.x = param2.col - param1.col;
            _loc4_.swapDir.y = param2.row - param1.row;
            _loc4_.swapGem = param2;
            _loc4_.swapPos.x = param2.col;
            _loc4_.swapPos.y = param2.row;
         }
         else
         {
            _loc4_.swapDir.x = 0;
            _loc4_.swapDir.y = 0;
            _loc4_.swapGem = null;
            _loc4_.swapPos.x = -1;
            _loc4_.swapPos.y = -1;
         }
         param3.push(_loc4_);
      }
   }
}
