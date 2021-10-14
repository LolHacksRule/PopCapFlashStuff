package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3.session.FeatureManager;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.IBoostDialogHandler;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuBoostState extends Sprite implements IAppState, IBoostDialogHandler
   {
       
      
      protected var m_App:Blitz3Game;
      
      public function PreGameMenuBoostState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_App.ui.boostDialog.AddHandler(this);
      }
      
      public function update() : void
      {
         this.m_App.ui.boostDialog.Update();
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
         this.m_App.ui.boostDialog.Show();
      }
      
      public function onExit() : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
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
