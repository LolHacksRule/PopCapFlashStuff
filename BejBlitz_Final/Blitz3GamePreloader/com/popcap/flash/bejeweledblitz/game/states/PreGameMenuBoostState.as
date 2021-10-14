package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.IBoostDialogHandler;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuBoostState extends Sprite implements IAppState, IBoostDialogHandler
   {
       
      
      protected var _app:Blitz3Game;
      
      public function PreGameMenuBoostState(param1:Blitz3Game)
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
         var _loc1_:RareGemOffer = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         if(!this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_BOOSTS))
         {
            dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_BOOST_CONTINUE));
            return;
         }
         if(!this._app.isMultiplayerGame() || this._app.party.isDoneWithPartyTutorial())
         {
            _loc1_ = this._app.sessionData.rareGemManager.GetCurrentOffer();
            if(_loc1_.isAvailable())
            {
               _loc2_ = _loc1_.GetID();
               _loc3_ = 0;
               _loc4_ = this._app.sessionData.rareGemManager.GetStreakNum();
               _loc5_ = this._app.sessionData.rareGemManager.isDiscounted;
               this._app.sessionData.rareGemManager.ForceOffer(_loc2_,_loc3_,_loc4_,_loc5_);
               (this._app.ui as MainWidgetGame).rareGemDialog.Show();
               (this._app.ui as MainWidgetGame).boostDialog.Hide();
               return;
            }
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
