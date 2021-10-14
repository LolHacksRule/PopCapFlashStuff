package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkAdStateChangeCallback;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   
   public class SpinBoardNetworkHandler implements IHandleNetworkAdStateChangeCallback
   {
       
      
      private var _app:Blitz3App;
      
      private var _controller:SpinBoardController;
      
      private var _isAdThrottleOpen:Boolean;
      
      public function SpinBoardNetworkHandler(param1:Blitz3App, param2:SpinBoardController)
      {
         super();
         this._app = param1;
         this._controller = param2;
         this.init();
      }
      
      private function init() : void
      {
         this._app.network.AddAdStateChangHandler(this);
         this._isAdThrottleOpen = false;
      }
      
      public function IsAdThrottleOpen() : Boolean
      {
         return this._isAdThrottleOpen;
      }
      
      public function HandleWatchAdBtnClicked() : void
      {
         var _loc1_:SpinBoardInfo = SpinBoardController.GetInstance().GetActiveSpinBoardInfo();
         if(_loc1_ != null)
         {
            this._controller.GetStateHandler().SetState(SpinBoardState.WatchAdSpinClaim);
            (this._app.ui as MainWidgetGame).networkWait.Show(this);
            this._app.network.showAd(Blitz3Network.DS_PLACEMENT,1,_loc1_.GetId());
         }
      }
      
      public function HandleAdsStateChanged(param1:Boolean) : void
      {
         this._isAdThrottleOpen = param1;
      }
      
      public function HandleAdComplete(param1:String) : void
      {
         if(Blitz3Network.DS_PLACEMENT == param1)
         {
            this._controller.GetPlayerDataHandler().SetAdRewardSpinAvailable(true);
            this._app.adFrequencyManager.decrementRemainingUsesByPlacement(param1);
            this._controller.GetStateHandler().SetState(SpinBoardState.BoardRunning);
            (this._app.ui as MainWidgetGame).networkWait.Hide(this);
         }
      }
      
      public function HandleAdCapExhausted(param1:String) : void
      {
         if(param1 == Blitz3Network.DS_PLACEMENT)
         {
            this._isAdThrottleOpen = false;
         }
      }
      
      public function HandleAdClosed(param1:String) : void
      {
         if(param1 == Blitz3Network.DS_PLACEMENT)
         {
            (this._app.ui as MainWidgetGame).networkWait.Hide(this);
            this._controller.GetStateHandler().SetState(SpinBoardState.BoardRunning);
         }
      }
   }
}
