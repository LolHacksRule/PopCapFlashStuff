package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardCatalogueState;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardInfo;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import com.popcap.flash.framework.IAppState;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class MenuState extends EventDispatcher implements IAppState
   {
       
      
      private var _app:Blitz3Game;
      
      private var _mainWidget:MainWidgetGame;
      
      public function MenuState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._mainWidget = this._app.ui as MainWidgetGame;
         this._app.metaUI.tutorialWelcome.AddPlayButtonHandler(this.HandlePlayTutorialClick);
      }
      
      public function update() : void
      {
         this._app.metaUI.Update();
         (this._app.ui as MainWidgetGame).game.dailyChallengeLeaderboardAndQuestsCoverView.UpdateScore(this._app.logic.GetScoreKeeper().GetScore());
         this._mainWidget.menu.Update();
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         var _loc1_:SpinBoardInfo = null;
         this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_ENTER_LANDING_PAGE,null);
         if(SpinBoardController.GetInstance().GetCatalogue().GetCatalogueState() == SpinBoardCatalogueState.CatalogueFetched)
         {
            _loc1_ = SpinBoardController.GetInstance().GetActiveSpinBoardInfo();
            if(_loc1_ && _loc1_.IsFTUEBoard())
            {
               this._app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_SPINBOARD_AVAILABLE,null);
            }
            else
            {
               SpinBoardController.GetInstance().TryAutoShow();
            }
         }
         this._app.party.hideMe();
         this._mainWidget.menu.setCurrentMode(MenuWidget.MODE_LB);
         this._mainWidget.menu.ShowParticles();
         this._mainWidget.menu.leftPanel.onMainScreen();
         this._mainWidget.game.Hide();
         this._mainWidget.menu.updateBanners();
         this._app.mainmenuLeaderboard.Show();
         this._app.sessionData.configManager.SetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL,4);
         this._app.sessionData.configManager.CommitChanges();
         this._mainWidget.menu.SendAdAvailableReport();
      }
      
      public function onExit() : void
      {
         (this._app.ui as MainWidgetGame).menu.HideParticles();
      }
      
      private function HandlePlayTutorialClick(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(MainState.SIGNAL_PLAY_TUTORIAL));
      }
   }
}
