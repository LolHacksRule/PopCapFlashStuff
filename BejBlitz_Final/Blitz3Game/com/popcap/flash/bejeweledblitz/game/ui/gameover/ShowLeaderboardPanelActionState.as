package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   public class ShowLeaderboardPanelActionState extends GameOverBaseActionState
   {
       
      
      public function ShowLeaderboardPanelActionState()
      {
         super();
      }
      
      override public function processAction() : void
      {
         gameOverWidget.GameOverWidgetPlayAnim("introleaderboard",gameOverWidget.OnLeaderboardPanelAnimEnd);
      }
      
      override public function forceCompleteAction() : void
      {
         gameOverWidget.SkipToFinalFrame();
         gameOverWidget.OnLeaderboardPanelAnimEnd();
      }
   }
}
