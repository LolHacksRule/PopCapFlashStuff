package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IGameOverCurrencyContainerAnimListener;
   import com.popcap.flash.bejeweledblitz.topHUD.HUDCurrencyContainer;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.WatchAdBtnAnim;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GameOverCurrencyContainer extends HUDCurrencyContainer
   {
       
      
      private var _watchAdButton:GenericButtonClip;
      
      private var _btnAnimClip:WatchAdBtnAnim;
      
      private const dropDownAnimEndFrame:int = 37;
      
      private var _animEndCallback:IGameOverCurrencyContainerAnimListener = null;
      
      public function GameOverCurrencyContainer(param1:Blitz3Game, param2:String, param3:IGameOverCurrencyContainerAnimListener)
      {
         super(param1,param2);
         this._btnAnimClip = new WatchAdBtnAnim();
         this._watchAdButton = new GenericButtonClip(param1,new WatchAdBtn());
         this._btnAnimClip.WatchadBtnPlaceholder.addChild(this._watchAdButton.clipListener);
         Watchad_animplaceholder.addChild(this._btnAnimClip);
         super.setEnabled(true);
         super._addCurrency.clipListener.visible = false;
         this._btnAnimClip.gotoAndStop("idle");
         this._watchAdButton.clipListener.visible = false;
         this._watchAdButton.SetDisabled(true);
         this._watchAdButton.setPress(this.HandleAdButtonClicked);
         this._animEndCallback = param3;
         this.removeEventListener(MouseEvent.MOUSE_OVER,handleCartOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,handleCartOut);
         this.buttonMode = false;
         this.useHandCursor = false;
      }
      
      private function ShowAdButton() : void
      {
         if(_app.adFrequencyManager.canShowRetry(Blitz3Network.POSTGAME_PLACEMENT))
         {
            this._btnAnimClip.addEventListener(Event.ENTER_FRAME,this.GameOverCurrencyContainerAnimationUpdate);
            this._btnAnimClip.gotoAndPlay("dropdown");
            this._watchAdButton.SetDisabled(false);
            this._watchAdButton.activate();
            this._watchAdButton.clipListener.visible = true;
         }
         else
         {
            this.HideAdButton();
         }
      }
      
      private function HideAdButton() : void
      {
         this._btnAnimClip.gotoAndStop("idle");
         this._watchAdButton.SetDisabled(true);
         this._watchAdButton.clipListener.visible = false;
         if(this._animEndCallback)
         {
            this._animEndCallback.OnShowWatchAdButtonDone();
         }
      }
      
      private function HandleAdButtonClicked() : void
      {
         this._watchAdButton.SetDisabled(true);
         this._watchAdButton.clipListener.visible = false;
         _app.network.showAd(Blitz3Network.POSTGAME_PLACEMENT,_currencyGained);
      }
      
      private function HandleAdsStateChanged(param1:Boolean) : void
      {
         if(_app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_POST_GAME_2X_AD) && param1)
         {
            this.ShowAdButton();
         }
         else
         {
            _app.network.SendAdAvailabilityMetrics(Blitz3Network.POSTGAME_PLACEMENT);
            this.HideAdButton();
         }
      }
      
      public function ShowWatchAdButtonIfAdAvailable(param1:Boolean = true) : void
      {
         this.HandleAdsStateChanged(_app.network.IsAdAvailable() && param1);
      }
      
      private function GameOverCurrencyContainerAnimationUpdate(param1:Event) : void
      {
         switch(this._btnAnimClip.currentFrame)
         {
            case this.dropDownAnimEndFrame:
               this._btnAnimClip.gotoAndStop("dropdownend");
               this._btnAnimClip.removeEventListener(Event.ENTER_FRAME,this.GameOverCurrencyContainerAnimationUpdate);
               if(this._animEndCallback)
               {
                  this._animEndCallback.OnShowWatchAdButtonDone();
               }
         }
      }
   }
}
