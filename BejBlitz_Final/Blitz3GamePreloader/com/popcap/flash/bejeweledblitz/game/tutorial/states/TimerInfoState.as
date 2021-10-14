package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TimerInfoState extends BaseTutorialState
   {
       
      
      private var m_App:Blitz3Game;
      
      public function TimerInfoState(param1:Blitz3Game)
      {
         super(param1);
         this.m_App = param1;
      }
      
      override public function EnterState() : void
      {
         super.EnterState();
         this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_TIMER_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_TIMER),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_FINISH));
         this.m_App.metaUI.tutorial.infoBox.AddContinueButtonHandler(this.HandleContinueClicked);
         var _loc1_:Point = new Point(0,Board.NUM_ROWS * GemSprite.GEM_SIZE);
         var _loc2_:Point = new Point(Board.NUM_COLS * GemSprite.GEM_SIZE,(Board.NUM_ROWS + 0.5) * GemSprite.GEM_SIZE);
         _loc1_ = (this.m_App.ui as MainWidgetGame).game.board.localToGlobal(_loc1_);
         _loc2_ = (this.m_App.ui as MainWidgetGame).game.board.localToGlobal(_loc2_);
         _loc1_ = this.m_App.metaUI.tutorial.globalToLocal(_loc1_);
         _loc2_ = this.m_App.metaUI.tutorial.globalToLocal(_loc2_);
         this.m_App.metaUI.highlight.HighlightRect(_loc1_.x,_loc1_.y,_loc2_.x - _loc1_.x,_loc2_.y - _loc1_.y,true,true,0.65);
         (this.m_App.ui as MainWidgetGame).game.board.clock.visible = true;
      }
      
      override public function ExitState() : void
      {
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.tutorial.infoBox.RemoveContinueButtonHandler(this.HandleContinueClicked);
         super.ExitState();
      }
      
      private function HandleContinueClicked(param1:MouseEvent) : void
      {
         isDone = true;
      }
   }
}
