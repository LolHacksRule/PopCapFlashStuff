package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TimerInfoState extends BaseTutorialState
   {
       
      
      private var m_App:Blitz3Game;
      
      public function TimerInfoState(app:Blitz3Game)
      {
         super(app);
         this.m_App = app;
      }
      
      override public function EnterState() : void
      {
         super.EnterState();
         this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_TIMER_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_TIMER),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_FINISH));
         this.m_App.metaUI.tutorial.infoBox.AddContinueButtonHandler(this.HandleContinueClicked);
         var topLeft:Point = new Point(0,Board.NUM_ROWS * GemSprite.GEM_SIZE);
         var bottomRight:Point = new Point(Board.NUM_COLS * GemSprite.GEM_SIZE,(Board.NUM_ROWS + 0.5) * GemSprite.GEM_SIZE);
         topLeft = this.m_App.ui.game.board.localToGlobal(topLeft);
         bottomRight = this.m_App.ui.game.board.localToGlobal(bottomRight);
         topLeft = this.m_App.metaUI.tutorial.globalToLocal(topLeft);
         bottomRight = this.m_App.metaUI.tutorial.globalToLocal(bottomRight);
         this.m_App.metaUI.highlight.HighlightRect(topLeft.x,topLeft.y,bottomRight.x - topLeft.x,bottomRight.y - topLeft.y,false);
         this.m_App.ui.game.board.clock.visible = true;
      }
      
      override public function ExitState() : void
      {
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.tutorial.infoBox.RemoveContinueButtonHandler(this.HandleContinueClicked);
         super.ExitState();
      }
      
      private function HandleContinueClicked(event:MouseEvent) : void
      {
         isDone = true;
      }
   }
}
