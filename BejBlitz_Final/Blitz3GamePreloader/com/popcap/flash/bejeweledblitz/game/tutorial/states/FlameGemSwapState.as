package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
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
      
      public function FlameGemSwapState(param1:Blitz3Game)
      {
         super(param1);
         this.m_App = param1;
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
      
      public function HandleSwapBegin(param1:SwapData) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(isActive && param1.isForwardSwap)
         {
            _loc2_ = -1;
            _loc3_ = -1;
            if(param1.moveData.sourceGem.type == Gem.TYPE_FLAME && param1.moveData.swapDir.y == -1)
            {
               _loc2_ = param1.moveData.swapGem.col;
               _loc3_ = param1.moveData.swapGem.row;
            }
            else
            {
               if(!(param1.moveData.swapGem.type == Gem.TYPE_FLAME && param1.moveData.swapDir.y == 1))
               {
                  return;
               }
               _loc2_ = param1.moveData.sourceGem.col;
               _loc3_ = param1.moveData.sourceGem.row;
            }
            this.ShowHighlight(_loc2_ - 1,_loc3_ - 1,_loc2_ + 1,_loc3_ + 1);
         }
      }
      
      public function HandleSwapComplete(param1:SwapData) : void
      {
         if(isActive && param1.isForwardSwap)
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
      
      public function HandleLastSuccessfulSwapComplete(param1:SwapData) : void
      {
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
         var _loc1_:Gem = this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW - 1,FIRST_TARGET_COL);
         if(_loc1_ != null)
         {
            _loc1_.movePolicy.canSwapEast = false;
            _loc1_ = this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW - 1,FIRST_TARGET_COL + 1);
            _loc1_.movePolicy.canSwapWest = false;
         }
      }
      
      private function UnblockIncorrectSwaps() : void
      {
         var _loc1_:Gem = this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW,FIRST_TARGET_COL);
         if(_loc1_ != null)
         {
            _loc1_.movePolicy.canSwapEast = true;
         }
      }
      
      private function ShowFirstHighlight() : void
      {
         this.ShowHighlight(FIRST_HIGHLIGHT[0],FIRST_HIGHLIGHT[1],FIRST_HIGHLIGHT[2],FIRST_HIGHLIGHT[3]);
         var _loc1_:Gem = this.m_App.logic.board.GetGemAt(FIRST_TARGET_ROW,FIRST_TARGET_COL);
         if(_loc1_ != null)
         {
            _loc1_.isHinted = true;
         }
      }
      
      private function ShowSecondHighlight() : void
      {
         this.ShowHighlight(SECOND_HIGHLIGHT[0],SECOND_HIGHLIGHT[1],SECOND_HIGHLIGHT[2],SECOND_HIGHLIGHT[3]);
         var _loc1_:Gem = this.m_App.logic.board.GetGemAt(SECOND_TARGET_ROW,SECOND_TARGET_COL);
         if(_loc1_ != null)
         {
            _loc1_.isHinted = true;
         }
      }
      
      private function ShowHighlight(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:Point = new Point(param2,param1);
         var _loc6_:Point = new Point(param4 + 1,param3 + 1);
         this.m_App.metaUI.highlight.Show();
         _loc5_.x *= GemSprite.GEM_SIZE;
         _loc5_.y *= GemSprite.GEM_SIZE;
         _loc6_.x *= GemSprite.GEM_SIZE;
         _loc6_.y *= GemSprite.GEM_SIZE;
         _loc5_ = (this.m_App.ui as MainWidgetGame).game.board.localToGlobal(_loc5_);
         _loc6_ = (this.m_App.ui as MainWidgetGame).game.board.localToGlobal(_loc6_);
         _loc5_ = this.m_App.metaUI.tutorial.globalToLocal(_loc5_);
         _loc6_ = this.m_App.metaUI.tutorial.globalToLocal(_loc6_);
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.highlight.HighlightRect(_loc5_.x,_loc5_.y,_loc6_.x - _loc5_.x,_loc6_.y - _loc5_.y,true,true,0.65);
      }
      
      public function HandleSwapCancel(param1:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlast(param1:Gem) : void
      {
      }
   }
}
