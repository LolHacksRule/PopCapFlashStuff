package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.IAppState;
   import flash.events.EventDispatcher;
   
   public class TournamentState extends EventDispatcher implements IAppState
   {
       
      
      private var _app:Blitz3Game;
      
      public function TournamentState(param1:Blitz3Game)
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
         SpinBoardController.GetInstance().CloseSpinBoard();
         _loc1_.game.Hide();
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(true);
         _loc1_.menu.tournamentMenu.buildList();
         _loc1_.menu.tournamentMenu.setVisibility(true);
      }
      
      public function onExit() : void
      {
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         _loc1_.menu.tournamentMenu.clear();
         _loc1_.menu.tournamentMenu.setVisibility(false);
      }
   }
}
