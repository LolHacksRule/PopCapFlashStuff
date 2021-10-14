package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import flash.geom.Point;
   
   public class BaseTutorialState implements ITutorialState
   {
       
      
      private var m_App:Blitz3Game;
      
      protected var isDone:Boolean;
      
      protected var isActive:Boolean;
      
      public function BaseTutorialState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.isDone = false;
         this.isActive = false;
      }
      
      public function Update() : void
      {
      }
      
      public function EnterState() : void
      {
         Utils.log(this,"EnterState entering state " + this);
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
         Utils.log(this,"ExitState exited state " + this);
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
      
      private function SetBoardConfig(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < Board.NUM_ROWS)
         {
            _loc3_ = 0;
            while(_loc3_ < Board.NUM_COLS)
            {
               if((_loc4_ = this.m_App.logic.board.GetGemAt(_loc2_,_loc3_)) != null)
               {
                  this.m_App.logic.QueueChangeGemColor(_loc4_,param1[_loc2_][_loc3_],-1,ReplayCommands.COMMAND_ONLY_PLAY);
               }
               _loc3_++;
            }
            _loc2_++;
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
      
      protected function ShowArrowAtGem(param1:int, param2:int, param3:Number) : void
      {
         var _loc4_:Point = new Point((param2 + 0.5) * GemSprite.GEM_SIZE,(param1 + 0.5) * GemSprite.GEM_SIZE);
         _loc4_ = (this.m_App.ui as MainWidgetGame).game.board.localToGlobal(_loc4_);
         _loc4_ = this.m_App.metaUI.tutorial.globalToLocal(_loc4_);
         this.m_App.metaUI.tutorial.ShowArrow(_loc4_,param3);
      }
   }
}
