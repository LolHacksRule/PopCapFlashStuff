package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicEventHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.geom.Point;
   
   public class HorizontalSwapState extends BaseTutorialState implements IBlitzLogicEventHandler
   {
      
      private static const HINT_DELAY:int = 200;
      
      private static const BOARD_CONFIG:Array = [[1,7,4,4,5,4,6,6],[2,3,2,3,1,3,2,2],[1,1,6,5,6,1,6,4],[1,3,2,4,6,5,4,1],[7,5,5,3,1,4,7,7],[1,2,6,6,1,6,5,1],[2,2,4,7,6,4,5,2],[4,6,3,4,7,3,3,2]];
       
      
      private var m_App:Blitz3Game;
      
      private var m_IsSwapMade:Boolean;
      
      private var m_HintTimer:int;
      
      private var m_Move:MoveData;
      
      private var m_Moves:Vector.<MoveData>;
      
      public function HorizontalSwapState(app:Blitz3Game)
      {
         super(app);
         this.m_App = app;
         this.m_IsSwapMade = false;
         this.m_HintTimer = 0;
         this.m_Move = null;
         this.m_Moves = new Vector.<MoveData>();
      }
      
      override public function Update() : void
      {
         var pointFrom:Number = NaN;
         if(this.m_IsSwapMade)
         {
            if(this.m_App.logic.board.IsStill())
            {
               isDone = true;
            }
         }
         else
         {
            if(!this.m_App.metaUI.tutorial.arrow.visible && this.m_Move != null && this.m_App.logic.board.IsStill())
            {
               pointFrom = 180 + Math.atan2(this.m_Move.swapDir.y,this.m_Move.swapDir.x) * (180 / Math.PI);
               ShowArrowAtGem(this.m_Move.sourceGem.row,this.m_Move.sourceGem.col,pointFrom);
               this.ShowHighlight();
            }
            --this.m_HintTimer;
            if(this.m_HintTimer <= 0)
            {
               this.m_Move.sourceGem.isHinted = true;
               this.m_HintTimer = HINT_DELAY;
            }
         }
      }
      
      override public function EnterState() : void
      {
         this.m_HintTimer = 0;
         this.m_IsSwapMade = false;
         super.EnterState();
         this.m_App.logic.AddEventHandler(this);
         this.m_Move = this.GetValidMove();
         this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SWAP_HORIZONTAL_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SWAP_HORIZONTAL));
      }
      
      override public function ExitState() : void
      {
         this.m_App.metaUI.highlight.Hide();
         super.ExitState();
         this.m_App.logic.RemoveEventHandler(this);
      }
      
      public function HandleSwapBegin(swap:SwapData) : void
      {
      }
      
      public function HandleSwapComplete(swap:SwapData) : void
      {
         if(isActive && swap.isForwardSwap)
         {
            this.m_IsSwapMade = true;
            this.m_App.metaUI.tutorial.HideArrow();
         }
      }
      
      override protected function GetInitialBoard() : Array
      {
         return BOARD_CONFIG;
      }
      
      override protected function NeedsLogicReset() : Boolean
      {
         return true;
      }
      
      protected function GetValidMove() : MoveData
      {
         var move:MoveData = null;
         this.m_App.logic.board.moveFinder.FindAllMoves(this.m_App.logic.board,this.m_Moves);
         var numMoves:int = this.m_Moves.length;
         for(var i:int = 0; i < numMoves; i++)
         {
            if(this.m_Moves[i].swapDir.x != 0)
            {
               move = this.m_Moves[i];
               this.m_Moves.splice(i,1);
               break;
            }
         }
         this.m_App.logic.movePool.FreeMoves(this.m_Moves);
         return move;
      }
      
      private function ShowHighlight() : void
      {
         var moveOne:Point = new Point(this.m_Move.swapGem.col,this.m_Move.swapGem.row);
         var moveTwo:Point = new Point(this.m_Move.sourceGem.col + 1,this.m_Move.sourceGem.row + 1);
         if(this.m_Move.swapDir.x < 0)
         {
            moveOne.x -= 2;
         }
         else if(this.m_Move.swapDir.x > 0)
         {
            moveOne.x += 3;
            moveTwo.x -= 1;
         }
         else if(this.m_Move.swapDir.y < 0)
         {
            moveOne.y -= 2;
         }
         else if(this.m_Move.swapDir.y > 0)
         {
            moveOne.y += 3;
            moveTwo.y -= 1;
         }
         this.m_App.metaUI.highlight.Show();
         moveOne.x *= GemSprite.GEM_SIZE;
         moveOne.y *= GemSprite.GEM_SIZE;
         moveTwo.x *= GemSprite.GEM_SIZE;
         moveTwo.y *= GemSprite.GEM_SIZE;
         moveOne = this.m_App.ui.game.board.localToGlobal(moveOne);
         moveTwo = this.m_App.ui.game.board.localToGlobal(moveTwo);
         moveOne = this.m_App.metaUI.tutorial.globalToLocal(moveOne);
         moveTwo = this.m_App.metaUI.tutorial.globalToLocal(moveTwo);
         this.m_App.metaUI.highlight.Hide();
         var moveX:Number = Math.min(moveOne.x,moveTwo.x);
         var moveY:Number = Math.min(moveOne.y,moveTwo.y);
         var moveWidth:Number = Math.max(moveOne.x,moveTwo.x) - moveX;
         var moveHeight:Number = Math.max(moveOne.y,moveTwo.y) - moveY;
         this.m_App.metaUI.highlight.HighlightRect(moveX,moveY,moveWidth,moveHeight,true);
      }
   }
}
