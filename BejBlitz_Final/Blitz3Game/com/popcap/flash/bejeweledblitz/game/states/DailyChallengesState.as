package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.events.EventDispatcher;
   
   public class DailyChallengesState extends EventDispatcher implements IAppState
   {
       
      
      private var _app:Blitz3Game;
      
      public function DailyChallengesState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
      }
      
      public function update() : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         (this._app.ui as MainWidgetGame).menu.leftPanel.onDailyChallengeScreen();
         this._app.dailyChallengeManager.show();
      }
      
      public function onExit() : void
      {
         this._app.dailyChallengeManager.Hide();
      }
   }
}
