package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkAdStateChangeCallback;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.logic.DailyChallengeLogicConfig;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   public class DailyChallengeDialogButtons implements IHandleNetworkAdStateChangeCallback
   {
       
      
      private var _loader:DynamicRareGemLoader;
      
      private var _rewardRGLoader:DynamicRareGemLoader;
      
      private var _retryButton:MovieClip;
      
      private var _retryWatchAdButton:MovieClip;
      
      private var _watchAdButton:MovieClip;
      
      private var _watchAdRetryPanel:MovieClip;
      
      private var _refreshButton:MovieClip;
      
      private var _playButton:SimpleButton;
      
      private var _loadingButton:MovieClip;
      
      private var _isLoading:Boolean = true;
      
      private var _isExpired:Boolean = false;
      
      private var _isRewardGemLoading:Boolean = true;
      
      private var _areAdsAvailable:Boolean = false;
      
      private var _adIsNotAvailable:Boolean = false;
      
      public function DailyChallengeDialogButtons(param1:DynamicRareGemLoader, param2:DynamicRareGemLoader, param3:MovieClip, param4:MovieClip, param5:SimpleButton, param6:MovieClip, param7:MovieClip, param8:MovieClip, param9:MovieClip)
      {
         super();
         this._loader = param1;
         this._rewardRGLoader = param2;
         this._retryButton = param3;
         this._refreshButton = param4;
         this._playButton = param5;
         this._loadingButton = param6;
         this._retryWatchAdButton = param8;
         this._watchAdButton = param7;
         this._watchAdRetryPanel = param9;
         this._loadingButton.visible = true;
         this._playButton.visible = false;
         this._watchAdRetryPanel.visible = false;
         this._retryWatchAdButton.visible = false;
         this._watchAdButton.visible = false;
         this._retryWatchAdButton.buttonMode = true;
         this._watchAdButton.buttonMode = true;
         this._retryButton.buttonMode = true;
         this._refreshButton.buttonMode = true;
         Blitz3App.app.network.AddAdStateChangHandler(this);
      }
      
      public function get isLoading() : Boolean
      {
         return this._isLoading;
      }
      
      public function get isExpired() : Boolean
      {
         return this._isExpired;
      }
      
      public function loadGem(param1:DailyChallengeLogicConfig) : void
      {
         var reward:DailyChallengeRareGemReward = null;
         var config:DailyChallengeLogicConfig = param1;
         var gemId:String = config.rareGem;
         var rewardGemId:String = "";
         var arrayLength:int = config.starCatRewards.length;
         var idx:int = 0;
         while(idx < arrayLength)
         {
            reward = config.starCatRewards[idx] as DailyChallengeRareGemReward;
            if(reward)
            {
               rewardGemId = reward._gemId;
            }
            idx++;
         }
         if(rewardGemId != gemId && DynamicRareGemWidget.isValidGemId(rewardGemId))
         {
            this._isRewardGemLoading = true;
            this._rewardRGLoader.load(rewardGemId,function():void
            {
            },function():void
            {
               _isRewardGemLoading = false;
               if(!_isRewardGemLoading && !_isLoading)
               {
                  determinePlayButtonState(config);
               }
            });
         }
         else
         {
            this._isRewardGemLoading = false;
         }
         if(DynamicRareGemWidget.isValidGemId(gemId))
         {
            this._isLoading = true;
            this._loader.load(gemId,function():void
            {
            },function():void
            {
               _isLoading = false;
               if(!_isRewardGemLoading && !_isLoading)
               {
                  determinePlayButtonState(config);
               }
            });
         }
         else
         {
            this._isLoading = false;
         }
      }
      
      public function determinePlayButtonState(param1:DailyChallengeLogicConfig) : void
      {
         this._playButton.visible = false;
         this._loadingButton.visible = false;
         this._retryButton.visible = false;
         this._watchAdRetryPanel.visible = false;
         if(!this._isExpired)
         {
            if(this._isLoading)
            {
               this._loadingButton.visible = true;
            }
            else if(param1.hasBeenPlayed())
            {
               if(param1.retryCost > 0 && this._areAdsAvailable && Blitz3App.app.adFrequencyManager.canShowRetry(Blitz3Network.DC_PLACEMENT))
               {
                  this._watchAdRetryPanel.visible = true;
                  this._retryWatchAdButton.retryCostT.text = Utils.commafy(param1.retryCost);
                  this._retryWatchAdButton.visible = true;
                  this._watchAdButton.visible = true;
               }
               else
               {
                  if(param1.retryCost > 0)
                  {
                     this._adIsNotAvailable = true;
                  }
                  this._retryButton.retryCostT.text = Utils.commafy(param1.retryCost);
                  this._retryButton.visible = true;
               }
            }
            else
            {
               this._playButton.visible = true;
            }
         }
      }
      
      public function setExpired() : void
      {
         this._isExpired = true;
         this._refreshButton.visible = true;
      }
      
      public function setExpiringSoon() : void
      {
         this._isExpired = false;
         this._refreshButton.visible = false;
      }
      
      public function setActive() : void
      {
         this._isExpired = false;
         this._refreshButton.visible = false;
      }
      
      public function HandleAdsStateChanged(param1:Boolean) : void
      {
         this._areAdsAvailable = param1;
      }
      
      public function HandleAdComplete(param1:String) : void
      {
      }
      
      public function HandleAdCapExhausted(param1:String) : void
      {
         if(param1 == Blitz3Network.DC_PLACEMENT)
         {
            this._areAdsAvailable = false;
         }
      }
      
      public function HandleAdClosed(param1:String) : void
      {
      }
      
      public function isWatchAdBtnHidden() : Boolean
      {
         return this._adIsNotAvailable;
      }
   }
}
