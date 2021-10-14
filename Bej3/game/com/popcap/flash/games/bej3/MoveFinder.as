package com.popcap.flash.games.bej3
{
   import flash.utils.Dictionary;
   
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
       
      
      private var mMoveSet:Vector.<MoveData>;
      
      private var mMoveMap:Dictionary;
      
      public function MoveFinder()
      {
         super();
         this.mMoveSet = new Vector.<MoveData>();
         this.mMoveMap = new Dictionary();
      }
      
      public function Reset() : void
      {
         this.mMoveSet.length = 0;
      }
      
      public function FindAllMoves(board:Board) : Vector.<MoveData>
      {
         this.mMoveSet.length = 0;
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
               this.FindMoves(board,gems[i],this.mMoveSet);
            }
         }
         return this.mMoveSet;
      }
      
      public function FindMoves(board:Board, gem:Gem, moves:Vector.<MoveData> = null) : void
      {
         if(!gem.movePolicy.hasMoves)
         {
            return;
         }
         var gems:Vector.<Gem> = board.mGems;
         var aMove:MoveData = null;
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
            gems[index + NEIGHBOR_N].mIsMatchee = true;
            aMove = MovePool.allocMove();
            aMove.sourceGem = gem;
            aMove.sourcePos.x = col;
            aMove.sourcePos.y = row;
            aMove.isSwap = gem.movePolicy.canSwap;
            aMove.swapDir.x = 0;
            aMove.swapDir.y = -1;
            moves.push(aMove);
         }
         if(e && gem.movePolicy.hasMoveEast)
         {
            gem.mHasMove = true;
            gems[index + NEIGHBOR_E].mIsMatchee = true;
            aMove = MovePool.allocMove();
            aMove.sourceGem = gem;
            aMove.sourcePos.x = col;
            aMove.sourcePos.y = row;
            aMove.isSwap = gem.movePolicy.canSwap;
            aMove.swapDir.x = 1;
            aMove.swapDir.y = 0;
            moves.push(aMove);
         }
         if(s && gem.movePolicy.hasMoveSouth)
         {
            gem.mHasMove = true;
            gems[index + NEIGHBOR_S].mIsMatchee = true;
            aMove = MovePool.allocMove();
            aMove.sourceGem = gem;
            aMove.sourcePos.x = col;
            aMove.sourcePos.y = row;
            aMove.isSwap = gem.movePolicy.canSwap;
            aMove.swapDir.x = 0;
            aMove.swapDir.y = 1;
            moves.push(aMove);
         }
         if(w && gem.movePolicy.hasMoveWest)
         {
            gem.mHasMove = true;
            gems[index + NEIGHBOR_W].mIsMatchee = true;
            aMove = MovePool.allocMove();
            aMove.sourceGem = gem;
            aMove.sourcePos.x = col;
            aMove.sourcePos.y = row;
            aMove.isSwap = gem.movePolicy.canSwap;
            aMove.swapDir.x = -1;
            aMove.swapDir.y = 0;
            moves.push(aMove);
         }
         var nnn:Boolean = row > 2 && gems[index + NEIGHBOR_NNN] != null && gems[index + NEIGHBOR_NNN].canMatch() && gems[index + NEIGHBOR_NNN].color == gem.color;
         var nnw:Boolean = row > 1 && col > 0 && gems[index + NEIGHBOR_NNW] != null && gems[index + NEIGHBOR_NNW].canMatch() && gems[index + NEIGHBOR_NNW].color == gem.color;
         var nn:Boolean = row > 1 && gems[index + NEIGHBOR_NN] != null && gems[index + NEIGHBOR_NN].canMatch() && gems[index + NEIGHBOR_NN].color == gem.color;
         var nne:Boolean = row > 1 && col < Board.WIDTH - 1 && gems[index + NEIGHBOR_NNE] != null && gems[index + NEIGHBOR_NNE].canMatch() && gems[index + NEIGHBOR_NNE].color == gem.color;
         var nww:Boolean = row > 0 && col > 1 && gems[index + NEIGHBOR_NWW] != null && gems[index + NEIGHBOR_NWW].canMatch() && gems[index + NEIGHBOR_NWW].color == gem.color;
         var nw:Boolean = row > 0 && col > 0 && gems[index + NEIGHBOR_NW] != null && gems[index + NEIGHBOR_NW].canMatch() && gems[index + NEIGHBOR_NW].color == gem.color;
         var ne:Boolean = row > 0 && col < Board.WIDTH - 1 && gems[index + NEIGHBOR_NE] != null && gems[index + NEIGHBOR_NE].canMatch() && gems[index + NEIGHBOR_NE].color == gem.color;
         var nee:Boolean = row > 0 && col < Board.WIDTH - 2 && gems[index + NEIGHBOR_NEE] != null && gems[index + NEIGHBOR_NEE].canMatch() && gems[index + NEIGHBOR_NEE].color == gem.color;
         var www:Boolean = col > 2 && gems[index + NEIGHBOR_WWW] != null && gems[index + NEIGHBOR_WWW].canMatch() && gems[index + NEIGHBOR_WWW].color == gem.color;
         var ww:Boolean = col > 1 && gems[index + NEIGHBOR_WW] != null && gems[index + NEIGHBOR_WW].canMatch() && gems[index + NEIGHBOR_WW].color == gem.color;
         var ee:Boolean = col < Board.WIDTH - 2 && gems[index + NEIGHBOR_EE] != null && gems[index + NEIGHBOR_EE].canMatch() && gems[index + NEIGHBOR_EE].color == gem.color;
         var eee:Boolean = col < Board.WIDTH - 3 && gems[index + NEIGHBOR_EEE] != null && gems[index + NEIGHBOR_EEE].canMatch() && gems[index + NEIGHBOR_EEE].color == gem.color;
         var sww:Boolean = row < Board.HEIGHT - 1 && col > 1 && gems[index + NEIGHBOR_SWW] != null && gems[index + NEIGHBOR_SWW].canMatch() && gems[index + NEIGHBOR_SWW].color == gem.color;
         var sw:Boolean = row < Board.HEIGHT - 1 && col > 0 && gems[index + NEIGHBOR_SW] != null && gems[index + NEIGHBOR_SW].canMatch() && gems[index + NEIGHBOR_SW].color == gem.color;
         var se:Boolean = row < Board.HEIGHT - 1 && col < Board.WIDTH - 1 && gems[index + NEIGHBOR_SE] != null && gems[index + NEIGHBOR_SE].canMatch() && gems[index + NEIGHBOR_SE].color == gem.color;
         var see:Boolean = row < Board.HEIGHT - 1 && col < Board.WIDTH - 2 && gems[index + NEIGHBOR_SEE] != null && gems[index + NEIGHBOR_SEE].canMatch() && gems[index + NEIGHBOR_SEE].color == gem.color;
         var ssw:Boolean = row < Board.HEIGHT - 2 && col > 0 && gems[index + NEIGHBOR_SSW] != null && gems[index + NEIGHBOR_SSW].canMatch() && gems[index + NEIGHBOR_SSW].color == gem.color;
         var ss:Boolean = row < Board.HEIGHT - 2 && gems[index + NEIGHBOR_SS] != null && gems[index + NEIGHBOR_SS].canMatch() && gems[index + NEIGHBOR_SS].color == gem.color;
         var sse:Boolean = row < Board.HEIGHT - 2 && col < Board.WIDTH - 1 && gems[index + NEIGHBOR_SSE] != null && gems[index + NEIGHBOR_SSE].canMatch() && gems[index + NEIGHBOR_SSE].color == gem.color;
         var sss:Boolean = row < Board.HEIGHT - 3 && gems[index + NEIGHBOR_SSS] != null && gems[index + NEIGHBOR_SSS].canMatch() && gems[index + NEIGHBOR_SSS].color == gem.color;
         if(n)
         {
            if(nww && nw)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NWW].mIsMatchee = true;
               gems[index + NEIGHBOR_NW].mIsMatchee = true;
            }
            if(nw && ne)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NW].mIsMatchee = true;
               gems[index + NEIGHBOR_NE].mIsMatchee = true;
            }
            if(ne && nee)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NE].mIsMatchee = true;
               gems[index + NEIGHBOR_NEE].mIsMatchee = true;
            }
            if(nn && nnn)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NN].mIsMatchee = true;
               gems[index + NEIGHBOR_NNN].mIsMatchee = true;
            }
            if(gem.mHasMove)
            {
               aMove = MovePool.allocMove();
               aMove.sourceGem = gem;
               aMove.sourcePos.x = col;
               aMove.sourcePos.y = row;
               aMove.isSwap = true;
               aMove.swapDir.x = 0;
               aMove.swapDir.y = -1;
               moves.push(aMove);
            }
         }
         if(e)
         {
            if(nne && ne)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NNE].mIsMatchee = true;
               gems[index + NEIGHBOR_NE].mIsMatchee = true;
            }
            if(ne && se)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NE].mIsMatchee = true;
               gems[index + NEIGHBOR_SE].mIsMatchee = true;
            }
            if(se && sse)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_SE].mIsMatchee = true;
               gems[index + NEIGHBOR_SSE].mIsMatchee = true;
            }
            if(ee && eee)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_EE].mIsMatchee = true;
               gems[index + NEIGHBOR_EEE].mIsMatchee = true;
            }
            if(gem.mHasMove)
            {
               aMove = MovePool.allocMove();
               aMove.sourceGem = gem;
               aMove.sourcePos.x = col;
               aMove.sourcePos.y = row;
               aMove.isSwap = true;
               aMove.swapDir.x = 1;
               aMove.swapDir.y = 0;
               moves.push(aMove);
            }
         }
         if(s)
         {
            if(sww && sw)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_SWW].mIsMatchee = true;
               gems[index + NEIGHBOR_SW].mIsMatchee = true;
            }
            if(sw && se)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_SW].mIsMatchee = true;
               gems[index + NEIGHBOR_SE].mIsMatchee = true;
            }
            if(se && see)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_SE].mIsMatchee = true;
               gems[index + NEIGHBOR_SEE].mIsMatchee = true;
            }
            if(ss && sss)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_SS].mIsMatchee = true;
               gems[index + NEIGHBOR_SSS].mIsMatchee = true;
            }
            if(gem.mHasMove)
            {
               aMove = MovePool.allocMove();
               aMove.sourceGem = gem;
               aMove.sourcePos.x = col;
               aMove.sourcePos.y = row;
               aMove.isSwap = true;
               aMove.swapDir.x = 0;
               aMove.swapDir.y = 1;
               moves.push(aMove);
            }
         }
         if(w)
         {
            if(nnw && nw)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NNW].mIsMatchee = true;
               gems[index + NEIGHBOR_NW].mIsMatchee = true;
            }
            if(nw && sw)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_NW].mIsMatchee = true;
               gems[index + NEIGHBOR_SW].mIsMatchee = true;
            }
            if(sw && ssw)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_SW].mIsMatchee = true;
               gems[index + NEIGHBOR_SSW].mIsMatchee = true;
            }
            if(ww && www)
            {
               gem.mHasMove = true;
               gems[index + NEIGHBOR_WW].mIsMatchee = true;
               gems[index + NEIGHBOR_WWW].mIsMatchee = true;
            }
            if(gem.mHasMove)
            {
               aMove = MovePool.allocMove();
               aMove.sourceGem = gem;
               aMove.sourcePos.x = col;
               aMove.sourcePos.y = row;
               aMove.isSwap = true;
               aMove.swapDir.x = -1;
               aMove.swapDir.y = 0;
               moves.push(aMove);
            }
         }
      }
   }
}
