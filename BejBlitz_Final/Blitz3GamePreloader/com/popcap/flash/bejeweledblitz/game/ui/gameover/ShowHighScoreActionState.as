package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   public class ShowHighScoreActionState extends GameOverBaseActionState
   {
       
      
      public function ShowHighScoreActionState()
      {
         super();
      }
      
      override public function processAction() : void
      {
         gameOverWidget.GameOverWidgetPlayAnim("introhighscore",gameOverWidget.OnHighScoreAnimEnd);
      }
      
      override public function forceCompleteAction() : void
      {
         gameOverWidget.SkipToFinalFrame();
         gameOverWidget.OnHighScoreAnimEnd();
      }
   }
}
