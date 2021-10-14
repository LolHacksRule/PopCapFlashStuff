package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.IBoostDialogHandler;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuBoostState extends Sprite implements IAppState, IBoostDialogHandler
   {
       
      
      protected var m_App:Blitz3Game;
      
      public function PreGameMenuBoostState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         (this.m_App.ui as MainWidgetGame).boostDialog.AddHandler(this);
      }
      
      public function update() : void
      {
         (this.m_App.ui as MainWidgetGame).boostDialog.Update();
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         if(!this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_BOOST_SELECTION))
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_BOOST_CONTINUE));
            return;
         }
         this.m_App.sessionData.boostManager.DoAutorenew();
         (this.m_App.ui as MainWidgetGame).boostDialog.Show();
      }
      
      public function onExit() : void
      {
         (this.m_App.ui as MainWidgetGame).boostDialog.Hide();
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      public function HandleBoostDialogContinueClicked() : void
      {
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_BOOST_CONTINUE));
      }
   }
}
