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
      
      public function MoveFinder(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
      }
      
      public function Reset() : void
      {
      }
      
      public function FindAllMoves(board:Board, result:Vector.<MoveData>) : void
      {
         result.length = 0;
         var gems:Vector.<Gem> = board.mGems;
         var i:int = 0;
         var gem:Gem = null;
         var numGems:int = Board.NUM_GEMS;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               gem.mHasMove = false;
               gem.mIsMatchee = false;
            }
         }
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               this.FindMoves(board,gems[i],result);
            }
         }
      }
      
      public function FindMoves(board:Board, gem:Gem, moves:Vector.<MoveData>) : void
      {
         var otherGem:Gem = null;
         if(!gem.movePolicy.hasMoves)
         {
            return;
         }
         var gems:Vector.<Gem> = board.mGems;
         var row:int = gem.row;
         var col:int = gem.col;
         var index:int = row * Board.WIDTH + col;
         var n:Boolean = row > Board.TOP && gems[index + NEIGHBOR_N] != null && gems[index + NEIGHBOR_N].movePolicy.canSwapSouth;
         var e:Boolean = col < Board.RIGHT && gems[index + NEIGHBOR_E] != null && gems[index + NEIGHBOR_E].movePolicy.canSwapWest;
         var s:Boolean = row < Board.BOTTOM && gems[index + NEIGHBOR_S] != null && gems[index + NEIGHBOR_S].movePolicy.canSwapNorth;
         var w:Boolean = col > Board.LEFT && gems[index + NEIGHBOR_W] != null && gems[index + NEIGHBOR_W].movePolicy.canSwapEast;
         if(n && gem.movePolicy.hasMoveNorth)
         {
            gem.mHasMove = true;
            otherGem = gems[index + NEIGHBOR_N];
            otherGem.mIsMatchee = true;
            this.addMove(gem,otherGem,moves);
         }
         if(e && gem.movePolicy.hasMoveEast)
         {
            gem.mHasMove = true;
            otherGem = gems[index + NEIGHBOR_E];
            otherGem.mIsMatchee = true;
            this.addMove(gem,otherGem,moves);
         }
         if(s && gem.movePolicy.hasMoveSouth)
         {
            gem.mHasMove = true;
            otherGem = gems[index + NEIGHBOR_S];
            otherGem.mIsMatchee = true;
            this.addMove(gem,otherGem,moves);
         }
         if(w && gem.movePolicy.hasMoveWest)
         {
            gem.mHasMove = true;
            otherGem = gems[index + NEIGHBOR_W];
            otherGem.mIsMatchee = true;
            this.addMove(gem,otherGem,moves);
         }
         var nn:Boolean = row > 1 && this.isMatch(gems[index + NEIGHBOR_NN],gem);
         var nnn:Boolean = row > 2 && this.isMatch(gems[index + NEIGHBOR_NNN],gem);
         var ww:Boolean = col > 1 && this.isMatch(gems[index + NEIGHBOR_WW],gem);
         var www:Boolean = col > 2 && this.isMatch(gems[index + NEIGHBOR_WWW],gem);
         var ss:Boolean = row < Board.HEIGHT - 2 && this.isMatch(gems[index + NEIGHBOR_SS],gem);
         var sss:Boolean = row < Board.HEIGHT - 3 && this.isMatch(gems[index + NEIGHBOR_SSS],gem);
         var ee:Boolean = col < Board.WIDTH - 2 && this.isMatch(gems[index + NEIGHBOR_EE],gem);
         var eee:Boolean = col < Board.WIDTH - 3 && this.isMatch(gems[index + NEIGHBOR_EEE],gem);
         var nw:Boolean = row > 0 && col > 0 && this.isMatch(gems[index + NEIGHBOR_NW],gem);
         var nnw:Boolean = row > 1 && col > 0 && this.isMatch(gems[index + NEIGHBOR_NNW],gem);
         var nww:Boolean = row > 0 && col > 1 && this.isMatch(gems[index + NEIGHBOR_NWW],gem);
         var ne:Boolean = row > 0 && col < Board.WIDTH - 1 && this.isMatch(gems[index + NEIGHBOR_NE],gem);
         var nne:Boolean = row > 1 && col < Board.WIDTH - 1 && this.isMatch(gems[index + NEIGHBOR_NNE],gem);
         var nee:Boolean = row > 0 && col < Board.WIDTH - 2 && this.isMatch(gems[index + NEIGHBOR_NEE],gem);
         var sw:Boolean = row < Board.HEIGHT - 1 && col > 0 && this.isMatch(gems[index + NEIGHBOR_SW],gem);
         var ssw:Boolean = row < Board.HEIGHT - 2 && col > 0 && this.isMatch(gems[index + NEIGHBOR_SSW],gem);
         var sww:Boolean = row < Board.HEIGHT - 1 && col > 1 && this.isMatch(gems[index + NEIGHBOR_SWW],gem);
         var se:Boolean = row < Board.HEIGHT - 1 && col < Board.WIDTH - 1 && this.isMatch(gems[index + NEIGHBOR_SE],gem);
         var sse:Boolean = row < Board.HEIGHT - 2 && col < Board.WIDTH - 1 && this.isMatch(gems[index + NEIGHBOR_SSE],gem);
         var see:Boolean = row < Board.HEIGHT - 1 && col < Board.WIDTH - 2 && this.isMatch(gems[index + NEIGHBOR_SEE],gem);
         var hasMove:Boolean = false;
         if(n)
         {
            hasMove = false;
            if(nww && nw)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NWW,NEIGHBOR_NW);
            }
            if(nw && ne)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NW,NEIGHBOR_NE);
            }
            if(ne && nee)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NE,NEIGHBOR_NEE);
            }
            if(nn && nnn)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NN,NEIGHBOR_NNN);
            }
            if(hasMove)
            {
               this.addMove(gem,gems[index + NEIGHBOR_N],moves);
            }
         }
         if(e)
         {
            hasMove = false;
            if(nne && ne)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NNE,NEIGHBOR_NE);
            }
            if(ne && se)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NE,NEIGHBOR_SE);
            }
            if(se && sse)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_SE,NEIGHBOR_SSE);
            }
            if(ee && eee)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_EE,NEIGHBOR_EEE);
            }
            if(hasMove)
            {
               this.addMove(gem,gems[index + NEIGHBOR_E],moves);
            }
         }
         if(s)
         {
            hasMove = false;
            if(sww && sw)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_SWW,NEIGHBOR_SW);
            }
            if(sw && se)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_SW,NEIGHBOR_SE);
            }
            if(se && see)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_SE,NEIGHBOR_SEE);
            }
            if(ss && sss)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_SS,NEIGHBOR_SSS);
            }
            if(hasMove)
            {
               this.addMove(gem,gems[index + NEIGHBOR_S],moves);
            }
         }
         if(w)
         {
            hasMove = false;
            if(nnw && nw)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NNW,NEIGHBOR_NW);
            }
            if(nw && sw)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_NW,NEIGHBOR_SW);
            }
            if(sw && ssw)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_SW,NEIGHBOR_SSW);
            }
            if(ww && www)
            {
               hasMove = this.setMatch(gems,gem,index,NEIGHBOR_WW,NEIGHBOR_WWW);
            }
            if(hasMove)
            {
               this.addMove(gem,gems[index + NEIGHBOR_W],moves);
            }
         }
      }
      
      private function isMatch(gem1:Gem, gem2:Gem) : Boolean
      {
         return gem1 != null && gem1.canMatch() && (gem1.color == gem2.color || gem1.type == Gem.TYPE_PHOENIXPRISM || gem2.type == Gem.TYPE_PHOENIXPRISM);
      }
      
      private function setMatch(gems:Vector.<Gem>, gem:Gem, index:int, gemIndex1:int, gemIndex2:int) : Boolean
      {
         if(gem.type == Gem.TYPE_PHOENIXPRISM && gems[index + gemIndex1].color != gems[index + gemIndex2].color)
         {
            return false;
         }
         gem.mHasMove = true;
         gems[index + gemIndex1].mIsMatchee = true;
         gems[index + gemIndex2].mIsMatchee = true;
         return true;
      }
      
      private function addMove(srcGem:Gem, dstGem:Gem, moves:Vector.<MoveData>) : void
      {
         var aMove:MoveData = this.m_Logic.movePool.GetMove();
         aMove.sourceGem = srcGem;
         aMove.sourcePos.x = srcGem.col;
         aMove.sourcePos.y = srcGem.row;
         aMove.isSwap = srcGem.movePolicy.canSwap;
         if(dstGem != null)
         {
            aMove.swapDir.x = dstGem.col - srcGem.col;
            aMove.swapDir.y = dstGem.row - srcGem.row;
            aMove.swapGem = dstGem;
            aMove.swapPos.x = dstGem.col;
            aMove.swapPos.y = dstGem.row;
         }
         else
         {
            aMove.swapDir.x = 0;
            aMove.swapDir.y = 0;
            aMove.swapGem = null;
            aMove.swapPos.x = -1;
            aMove.swapPos.y = -1;
         }
         moves.push(aMove);
      }
   }
}
