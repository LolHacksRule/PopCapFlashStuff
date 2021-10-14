package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   public class ShowCurrencyPanelActionState extends GameOverBaseActionState
   {
       
      
      public function ShowCurrencyPanelActionState()
      {
         super();
      }
      
      override public function processAction() : void
      {
         gameOverWidget.GameOverWidgetPlayAnim("introcurrency",gameOverWidget.OnCurrencyPanelAnimEnd);
      }
      
      override public function forceCompleteAction() : void
      {
         gameOverWidget.SkipToFinalFrame();
         gameOverWidget.OnCurrencyPanelAnimEnd();
      }
   }
}
