package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicEventHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.geom.Point;
   
   public class FlameGemSwapState extends BaseTutorialState implements IBlitzLogicEventHandler
   {
      
      private static const BOARD_CONFIG:Array = [[7,2,6,6,5,7,4,4],[3,1,2,5,1,3,2,2],[1,1,6,4,6,1,6,4],[3,5,2,4,6,5,4,1],[7,3,5,3,1,4,7,7],[1,2,6,6,1,6,5,1],[2,2,4,7,6,4,5,2],[4,6,3,4,7,3,3,2]];
      
      private static const FIRST_TARGET_ROW:int = 6;
      
      private static const FIRST_TARGET_COL:int = 4;
      
      private static const FIRST_POINT_FROM:Number = 90;
      
      private static const FIRST_HIGHLIGHT:Array = [5,2,6,5];
      
      private static const SECOND_TARGET_ROW:int = 5;
      
      private static const SECOND_TARGET_COL:int = 4;
      
      private static const SECOND_POINT_FROM:Number = 90;
      
      private static const SECOND_HIGHLIGHT:Array = [2,4,5,4];
      
      private static const STATE_INITIAL:int = 0;
      
      private static const STATE_GEM_CREATED:int = 1;
      
      private static const STATE_GEM_MATCHED:int = 2;
       
      
      private var m_App:Blitz3Game;
      
      private var m_State:int;
      
      public function FlameGemSwapState(app:Blitz3Game)
      {
         super(app);
         this.m_App = app;
         this.m_State = STATE_INITIAL;
      }
      
      override public function Update() : void
      {
         if(this.m_State == STATE_INITIAL)
         {
            if(!this.m_App.metaUI.tutorial.arrow.visible && this.m_App.logic.board.IsStill())
            {
               ShowArrowAtGem(FIRST_TARGET_ROW,FIRST_TARGET_COL,FIRST_POINT_FROM);
               this.BlockIncorrectSwaps();
            }
         }
         else if(this.m_State == STATE_GEM_CREATED)
         {
            if(!this.m_App.metaUI.tutorial.arrow.visible && this.m_App.logic.board.IsIdle())
            {
               ShowArrowAtGem(SECOND_TARGET_ROW,SECOND_TARGET_COL,SECOND_POINT_FROM);
               this.ShowSecondHighlight();
               this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_FLAME_GEM_MATCH_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_FLAME_GEM_MATCH));
            }
         }
         else if(this.m_State == STATE_GEM_MATCHED)
         {
            if(this.m_App.logic.board.IsStill())
            {
               isDone = true;
            }
         }
      }
      
      override public function EnterState() : void
      {
         super.EnterState();
         this.m_State = STATE_INITIAL;
         this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_FLAME_GEM_CREATE_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_FLAME_GEM_CREATE));
         this.ShowFirstHighlight();
         this.m_App.logic.AddEventHandler(this);
      }
      
      override public function ExitState() : void
      {
         this.m_App.metaUI.highlight.Hide();
         this.m_App.logic.RemoveEventHandler(this);
         super.ExitState();
      }
      
      public function HandleSwapBegin(swap:SwapData) : void
      {
         var centerX:int = 0;
         var centerY:int = 0;
         if(isActive && swap.isForwardSwap)
         {
            centerX = -1;
            centerY = -1;
            if(swap.moveData.sourceGem.type == Gem.TYPE_FLAME && swap.moveData.swapDir.y == -1)
            {
               centerX = swap.moveData.swapGem.col;
               centerY = swap.moveData.swapGem.row;
            }
            else
            {
               if(!(swap.moveData.swapGem.type == Gem.TYPE_FLAME && swap.moveData.swapDir.y == 1))
               {
                  return;
               }
               centerX = swap.moveData.sourceGem.col;
               centerY = swap.moveData.sourceGem.row;
            }
            this.ShowHighlight(centerX - 1,centerY - 1,centerX + 1,centerY + 1);
         }
      }
      
      public function HandleSwapComplete(swap:SwapData) : void
      {
         if(isActive && swap.isForwardSwap)
         {
            this.m_App.metaUI.tutorial.HideArrow();
            if(this.m_State == STATE_INITIAL)
            {
               this.m_State = STATE_GEM_CREATED;
               this.m_App.metaUI.tutorial.HideArrow();
               this.UnblockIncorrectSwaps();
            }
            else if(this.m_State == STATE_GEM_CREATED)
            {
               this.m_State = STATE_GEM_MATCHED;
            }
         }
      }
      
      override protected function GetInitialBoard() : Array
      {
         return BOARD_CONFIG;
      }
      
      override protected function NeedsLogicReset() : Boolean
      {
         return false;
      }
      
      private function BlockIncorrectSwaps() : void
      {
         var gem:Gem = this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW - 1,FIRST_TARGET_COL);
         gem.movePolicy.canSwapEast = false;
         gem = this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW - 1,FIRST_TARGET_COL + 1);
         gem.movePolicy.canSwapWest = false;
      }
      
      private function UnblockIncorrectSwaps() : void
      {
         var gem:Gem = this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW,FIRST_TARGET_COL);
         gem.movePolicy.canSwapEast = true;
      }
      
      private function ShowFirstHighlight() : void
      {
         this.ShowHighlight(FIRST_HIGHLIGHT[0],FIRST_HIGHLIGHT[1],FIRST_HIGHLIGHT[2],FIRST_HIGHLIGHT[3]);
         this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW,FIRST_TARGET_COL).isHinted = true;
      }
      
      private function ShowSecondHighlight() : void
      {
         this.ShowHighlight(SECOND_HIGHLIGHT[0],SECOND_HIGHLIGHT[1],SECOND_HIGHLIGHT[2],SECOND_HIGHLIGHT[3]);
         this.m_App.logic.board.GetGemAt(SECOND_TARGET_ROW,SECOND_TARGET_COL).isHinted = true;
      }
      
      private function ShowHighlight(minRow:int, minCol:int, maxRow:int, maxCol:int) : void
      {
         var moveMin:Point = new Point(minCol,minRow);
         var moveMax:Point = new Point(maxCol + 1,maxRow + 1);
         this.m_App.metaUI.highlight.Show();
         moveMin.x *= GemSprite.GEM_SIZE;
         moveMin.y *= GemSprite.GEM_SIZE;
         moveMax.x *= GemSprite.GEM_SIZE;
         moveMax.y *= GemSprite.GEM_SIZE;
         moveMin = this.m_App.ui.game.board.localToGlobal(moveMin);
         moveMax = this.m_App.ui.game.board.localToGlobal(moveMax);
         moveMin = this.m_App.metaUI.tutorial.globalToLocal(moveMin);
         moveMax = this.m_App.metaUI.tutorial.globalToLocal(moveMax);
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.highlight.HighlightRect(moveMin.x,moveMin.y,moveMax.x - moveMin.x,moveMax.y - moveMin.y,true);
      }
   }
}
