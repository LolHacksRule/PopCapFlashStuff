package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import flash.geom.Point;
   
   public class BaseTutorialState implements ITutorialState
   {
       
      
      private var m_App:Blitz3Game;
      
      protected var isDone:Boolean;
      
      protected var isActive:Boolean;
      
      public function BaseTutorialState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.isDone = false;
         this.isActive = false;
      }
      
      public function Update() : void
      {
      }
      
      public function EnterState() : void
      {
         this.isDone = false;
         this.isActive = true;
         if(this.NeedsLogicReset())
         {
            this.m_App.logic.isActive = true;
            this.SetBoardConfig(this.GetInitialBoard());
         }
      }
      
      public function ExitState() : void
      {
         this.isActive = false;
      }
      
      public function IsComplete() : Boolean
      {
         return this.isDone;
      }
      
      public function ForceComplete() : void
      {
         this.ExitState();
         this.isDone = true;
      }
      
      private function SetBoardConfig(config:Array) : void
      {
         var col:int = 0;
         var gem:Gem = null;
         if(config == null)
         {
            return;
         }
         for(var row:int = 0; row < Board.NUM_ROWS; row++)
         {
            for(col = 0; col < Board.NUM_COLS; col++)
            {
               gem = this.m_App.logic.board.GetGemAt(row,col);
               this.m_App.logic.QueueChangeGemColor(gem,config[row][col]);
            }
         }
         this.m_App.logic.Update();
      }
      
      protected function NeedsLogicReset() : Boolean
      {
         return false;
      }
      
      protected function GetInitialBoard() : Array
      {
         return null;
      }
      
      protected function ShowArrowAtGem(row:int, col:int, pointFrom:Number) : void
      {
         var target:Point = new Point((col + 0.5) * GemSprite.GEM_SIZE,(row + 0.5) * GemSprite.GEM_SIZE);
         target = this.m_App.ui.game.board.localToGlobal(target);
         target = this.m_App.metaUI.tutorial.globalToLocal(target);
         this.m_App.metaUI.tutorial.ShowArrow(target,pointFrom);
      }
   }
}
