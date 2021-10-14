package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.IBoostDialogHandler;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameGotoBoostState extends Sprite implements IAppState, IBoostDialogHandler
   {
       
      
      protected var _app:Blitz3Game;
      
      public function PreGameGotoBoostState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         (this._app.ui as MainWidgetGame).boostDialog.AddHandler(this);
      }
      
      public function update() : void
      {
         (this._app.ui as MainWidgetGame).boostDialog.Update();
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         if(!this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_BOOSTS))
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_BOOST_CONTINUE));
            return;
         }
         (this._app.ui as MainWidgetGame).boostDialog.Show();
         (this._app.ui as MainWidgetGame).menu.leftPanel.onBoostsScreen();
      }
      
      public function onExit() : void
      {
         (this._app.ui as MainWidgetGame).boostDialog.Hide();
      }
      
      public function HandleBoostDialogContinueClicked() : void
      {
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_BOOST_CONTINUE));
      }
   }
}
