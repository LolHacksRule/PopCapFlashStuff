package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   public class ShowBoostPanelActionState extends GameOverBaseActionState
   {
       
      
      public function ShowBoostPanelActionState()
      {
         super();
      }
      
      override public function processAction() : void
      {
         gameOverWidget.GameOverWidgetPlayAnim("introboost",gameOverWidget.ShowShareButton);
      }
      
      override public function forceCompleteAction() : void
      {
         gameOverWidget.SkipToFinalFrame();
         gameOverWidget.ShowShareButton();
      }
   }
}
