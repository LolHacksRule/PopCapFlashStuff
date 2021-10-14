package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
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
      
      public function HorizontalSwapState(param1:Blitz3Game)
      {
         super(param1);
         this.m_App = param1;
         this.m_IsSwapMade = false;
         this.m_HintTimer = 0;
         this.m_Move = null;
         this.m_Moves = new Vector.<MoveData>();
      }
      
      override public function Update() : void
      {
         var _loc1_:Number = NaN;
         if(this.m_IsSwapMade)
         {
            if(this.m_App.logic.board.IsStill())
            {
               isDone = true;
            }
         }
         else
         {
            this.BlockDisabledSwaps();
            if(!this.m_App.metaUI.tutorial.arrow.visible && this.m_Move != null && this.m_App.logic.board.IsStill())
            {
               _loc1_ = 180 + Math.atan2(this.m_Move.swapDir.y,this.m_Move.swapDir.x) * (180 / Math.PI);
               ShowArrowAtGem(this.m_Move.sourceGem.row,this.m_Move.sourceGem.col,_loc1_);
               this.ShowHighlight();
            }
            --this.m_HintTimer;
            if(this.m_HintTimer <= 0)
            {
               if(this.m_Move == null)
               {
                  return;
               }
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
         this.UnblockDisabledSwaps();
         this.m_App.metaUI.highlight.Hide();
         super.ExitState();
         this.m_App.logic.RemoveEventHandler(this);
      }
      
      public function HandleSwapBegin(param1:SwapData) : void
      {
      }
      
      public function HandleSwapComplete(param1:SwapData) : void
      {
         if(isActive && param1.isForwardSwap)
         {
            this.m_IsSwapMade = true;
            this.m_App.metaUI.tutorial.HideArrow();
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
         return true;
      }
      
      protected function GetValidMove() : MoveData
      {
         var _loc1_:MoveData = null;
         this.m_App.logic.board.moveFinder.FindAllMoves(this.m_App.logic.board,this.m_Moves);
         var _loc2_:int = this.m_Moves.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.m_Moves[_loc3_].swapDir.x != 0)
            {
               _loc1_ = this.m_Moves[_loc3_];
               this.m_Moves.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         this.m_App.logic.movePool.FreeMoves(this.m_Moves);
         return _loc1_;
      }
      
      private function ShowHighlight() : void
      {
         var _loc1_:Point = null;
         if(this.m_Move == null)
         {
            return;
         }
         _loc1_ = new Point(this.m_Move.swapGem.col,this.m_Move.swapGem.row);
         var _loc2_:Point = new Point(this.m_Move.sourceGem.col + 1,this.m_Move.sourceGem.row + 1);
         if(this.m_Move.swapDir.x < 0)
         {
            _loc1_.x -= 2;
         }
         else if(this.m_Move.swapDir.x > 0)
         {
            _loc1_.x += 3;
            --_loc2_.x;
         }
         else if(this.m_Move.swapDir.y < 0)
         {
            _loc1_.y -= 2;
         }
         else if(this.m_Move.swapDir.y > 0)
         {
            _loc1_.y += 3;
            --_loc2_.y;
         }
         this.m_App.metaUI.highlight.Show();
         _loc1_.x *= GemSprite.GEM_SIZE;
         _loc1_.y *= GemSprite.GEM_SIZE;
         _loc2_.x *= GemSprite.GEM_SIZE;
         _loc2_.y *= GemSprite.GEM_SIZE;
         _loc1_ = (this.m_App.ui as MainWidgetGame).game.board.localToGlobal(_loc1_);
         _loc2_ = (this.m_App.ui as MainWidgetGame).game.board.localToGlobal(_loc2_);
         _loc1_ = this.m_App.metaUI.tutorial.globalToLocal(_loc1_);
         _loc2_ = this.m_App.metaUI.tutorial.globalToLocal(_loc2_);
         this.m_App.metaUI.highlight.Hide();
         var _loc3_:Number = Math.min(_loc1_.x,_loc2_.x);
         var _loc4_:Number = Math.min(_loc1_.y,_loc2_.y);
         var _loc5_:Number = Math.max(_loc1_.x,_loc2_.x) - _loc3_;
         var _loc6_:Number = Math.max(_loc1_.y,_loc2_.y) - _loc4_;
         this.m_App.metaUI.highlight.HighlightRect(_loc3_,_loc4_,_loc5_,_loc6_,true,true,0.65);
      }
      
      protected function BlockDisabledSwaps() : void
      {
         var _loc1_:Gem = this.m_App.logic.board.GetGemAt(6,4);
         if(_loc1_ != null)
         {
            _loc1_.movePolicy.canSwapNorth = false;
            _loc1_.movePolicy.canSwapSouth = false;
         }
      }
      
      protected function UnblockDisabledSwaps() : void
      {
         var _loc1_:Gem = this.m_App.logic.board.GetGemAt(6,4);
         if(_loc1_ != null)
         {
            _loc1_.movePolicy.canSwapNorth = true;
            _loc1_.movePolicy.canSwapSouth = true;
         }
      }
      
      public function HandleSwapCancel(param1:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlast(param1:Gem) : void
      {
      }
   }
}
