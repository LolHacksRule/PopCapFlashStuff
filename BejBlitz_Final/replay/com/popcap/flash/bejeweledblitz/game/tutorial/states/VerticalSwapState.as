package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class VerticalSwapState extends HorizontalSwapState
   {
      
      private static const BOARD_CONFIG:Array = [[7,2,6,6,5,7,4,4],[3,1,2,5,1,3,2,2],[1,1,6,4,4,1,6,4],[3,5,2,4,6,5,4,1],[7,6,5,3,2,4,7,7],[1,2,3,7,6,6,5,5],[2,2,4,7,5,4,6,2],[4,6,1,4,2,3,3,2]];
       
      
      private var m_App:Blitz3Game;
      
      private var m_Moves:Vector.<MoveData>;
      
      public function VerticalSwapState(app:Blitz3Game)
      {
         super(app);
         this.m_App = app;
         this.m_Moves = new Vector.<MoveData>();
      }
      
      override public function EnterState() : void
      {
         super.EnterState();
         this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SWAP_VERTICALLY_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SWAP_VERTICALLY));
      }
      
      override protected function GetInitialBoard() : Array
      {
         return BOARD_CONFIG;
      }
      
      override protected function NeedsLogicReset() : Boolean
      {
         return false;
      }
      
      override protected function GetValidMove() : MoveData
      {
         var move:MoveData = null;
         this.m_App.logic.board.moveFinder.FindAllMoves(this.m_App.logic.board,this.m_Moves);
         var numMoves:int = this.m_Moves.length;
         for(var i:int = 0; i < numMoves; i++)
         {
            if(this.m_Moves[i].swapDir.y != 0)
            {
               move = this.m_Moves[i];
               this.m_Moves.splice(i,1);
               break;
            }
         }
         this.m_App.logic.movePool.FreeMoves(this.m_Moves);
         return move;
      }
   }
}
