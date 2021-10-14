package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.finisher.FinisherConfig;
   import com.popcap.flash.bejeweledblitz.game.session.FinisherSessionData;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkBuySkuCallback;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.ICost;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherPopupConfig;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherPopupText;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherPopupHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class FinisherPopupWidget implements IUserDataHandler, IHandleNetworkBuySkuCallback
   {
       
      
      private var app:Blitz3App = null;
      
      private var movie:MovieClip = null;
      
      private var alignmentAnchor:MovieClip = null;
      
      private var awesomeGame:MovieClip = null;
      
      private var value:int = 0;
      
      private var _currencyType:int;
      
      private var currencyTypeString:String;
      
      private var _handlers:Vector.<IFinisherPopupHandler> = null;
      
      private var timeUpIsCompletelyHidden:Boolean = false;
      
      private var hideAnimationHasStarted:Boolean = false;
      
      private var audioIsPlayed:Boolean = false;
      
      private var playAudioFrame:int = -1;
      
      private var timeUpHidingFrame:int = -1;
      
      private var timeUpHidingFrameAwesomeGame:int = -1;
      
      private var hidePopupFrame:int = -1;
      
      private var timer:Number = 0;
      
      private var popupConfig:IFinisherPopupConfig = null;
      
      private var isBlocked:Boolean = false;
      
      private var isTimedPopup:Boolean = true;
      
      private var playButton:MovieClip = null;
      
      private var cancelButton:MovieClip = null;
      
      private var timerClip:MovieClip = null;
      
      private var finisherWidget:FinisherWidget = null;
      
      private var finisherFacade:FinisherFacade = null;
      
      private var activeFinisherCount:Number = 0;
      
      public function FinisherPopupWidget(param1:Blitz3App, param2:MovieClip, param3:FinisherWidget, param4:IFinisherPopupConfig)
      {
         var _loc7_:FrameLabel = null;
         super();
         this.app = param1;
         this.movie = param2;
         this.finisherWidget = param3;
         this.popupConfig = param4;
         this._handlers = new Vector.<IFinisherPopupHandler>();
         var _loc5_:Array = param2.currentLabels;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_.length)
         {
            if((_loc7_ = _loc5_[_loc6_]).name == "stopAnimation")
            {
               this.timeUpHidingFrame = _loc7_.frame;
            }
            else if(_loc7_.name == "hidePopup")
            {
               this.hidePopupFrame = _loc7_.frame;
            }
            else if(_loc7_.name == "playAudio")
            {
               this.playAudioFrame = _loc7_.frame;
            }
            _loc6_++;
         }
         this.playButton = this.movie.getChildByName("playbutton") as MovieClip;
         this.timerClip = this.movie.getChildByName("timer") as MovieClip;
         this.timerClip.gotoAndStop(1);
         this.UpdatePopupText();
         this.addCancelButtonListener(this.onCancelled);
      }
      
      private function UpdatePopupText() : void
      {
         var _loc2_:IFinisherPopupText = null;
         var _loc3_:TextField = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc1_:Vector.<IFinisherPopupText> = this.popupConfig.GetPopupTexts();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = this.movie.getChildByName(_loc2_.GetFieldId()) as TextField;
            if(_loc3_ != null)
            {
               _loc3_.text = _loc2_.GetValue();
            }
            else if(_loc2_.GetFieldId() == "encore_text")
            {
               if((_loc4_ = this.movie.getChildByName("encore_name") as MovieClip) != null)
               {
                  if((_loc5_ = _loc4_.getChildByName("encore_text") as TextField) != null)
                  {
                     _loc5_.text = _loc2_.GetValue();
                  }
               }
            }
         }
      }
      
      private function onPurchaseConfirmed(param1:Event) : void
      {
         var _loc2_:InsufficientFundsDialog = null;
         if(!this.timeUpIsCompletelyHidden)
         {
            return;
         }
         if(this.timer == 0)
         {
            return;
         }
         if(this._currencyType == FinisherSessionData.CURRENCY_TYPE_IAP)
         {
            this.app.sessionData.finisherManager.BlockFinisherPopupTimerAnimation(true);
            this.app.network.AddNetworkBuySkuCallbackHandler(this);
            this.app.network.ForcePurchaseSku(this.value.toString(),false);
         }
         else if(!this.HasCurrency(this.value,this.currencyTypeString))
         {
            this.app.sessionData.finisherManager.BlockFinisherPopupTimerAnimation(true);
            _loc2_ = new InsufficientFundsDialog(this.app,this.currencyTypeString);
            _loc2_.Show();
            this.app.sessionData.userData.currencyManager.AddHandler(this);
         }
         else
         {
            this.app.sessionData.userData.currencyManager.SetCurrencyByType(this.GetBalance(this.value,this.currencyTypeString),this.currencyTypeString);
            this.DispatchPopupConfirmed();
         }
      }
      
      private function onCancelled(param1:Event) : void
      {
         if(!this.timeUpIsCompletelyHidden)
         {
            return;
         }
         this.playExitAnimation();
         this.DispatchPopupCancelled();
      }
      
      public function onPopupClose() : void
      {
         if(!this.timeUpIsCompletelyHidden || this.hideAnimationHasStarted)
         {
            return;
         }
         this.playExitAnimation();
         this.DispatchPopupCancelled(false);
      }
      
      public function SetInfo(param1:FinisherFacade) : void
      {
         var _loc6_:TextField = null;
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:FrameLabel = null;
         this.finisherFacade = param1;
         var _loc2_:FinisherConfig = this.finisherFacade.GetFinisherConfig();
         var _loc3_:Boolean = this.app.sessionData.finisherManager.IsOfferActive(_loc2_.GetID());
         var _loc4_:ICost = _loc2_.GetCost();
         this.value = _loc4_.GetValue();
         this.currencyTypeString = _loc4_.GetType();
         this._currencyType = FinisherSessionData.CURRENCY_TYPE_NONE;
         if(!_loc3_ && this.value != 0)
         {
            if(this.currencyTypeString == CurrencyManager.TYPE_SHARDS)
            {
               this.playButton.gotoAndStop("shards");
            }
            else
            {
               this.playButton.gotoAndStop("coin");
            }
            this.playButton.priceTxt.text = _loc4_.GetDisplayCost();
            if(_loc4_.IsCurrencyPurchase())
            {
               this._currencyType = FinisherSessionData.CURRENCY_TYPE_INGAME_CURRENCY;
            }
            else
            {
               this._currencyType = FinisherSessionData.CURRENCY_TYPE_IAP;
            }
         }
         else
         {
            this.playButton.gotoAndStop("free");
            this.value = 0;
            this._currencyType = FinisherSessionData.CURRENCY_TYPE_FREE;
         }
         this.addConfirmButtonListener(this.onPurchaseConfirmed);
         var _loc5_:MovieClip;
         if((_loc5_ = this.movie.getChildByName("extratime") as MovieClip) != null)
         {
            if((_loc6_ = _loc5_.getChildByName("extratimetxt") as TextField) != null)
            {
               _loc6_.text = "+" + _loc2_.GetExtraTime() / 100;
            }
         }
         if(this.finisherFacade.IsPrimaryPopup())
         {
            this.awesomeGame = this.finisherWidget.getMovieClip(FinisherFacade.FINISHER_AWESOME_GAME_INTRO);
            if(this.awesomeGame)
            {
               _loc7_ = this.awesomeGame.currentLabels;
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  if((_loc9_ = _loc7_[_loc8_]).name == "stopAnimation")
                  {
                     this.timeUpHidingFrameAwesomeGame = _loc9_.frame;
                  }
                  _loc8_++;
               }
            }
         }
         this.activeFinisherCount = Blitz3App.app.sessionData.finisherManager.GetActiveFinishers().length;
      }
      
      public function AddToStage() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         if(this.activeFinisherCount > 1)
         {
            _loc1_ = this.finisherFacade.GetFinisherConfig().GetAssetID();
            _loc2_ = "AlignmentAnchor_" + _loc1_;
            this.alignmentAnchor = (this.app.ui as MainWidgetGame).game.getChildByName(_loc2_) as MovieClip;
            if(_loc1_ == "SuperEncore")
            {
               if(this.cancelButton != null)
               {
                  this.cancelButton.visible = false;
               }
               _loc3_ = this.movie.getChildByName("NoThanksbutton") as MovieClip;
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
            }
         }
         if(this.alignmentAnchor == null)
         {
            this.alignmentAnchor = (this.app.ui as MainWidgetGame).game.AlignmentAnchor;
         }
         if(this.alignmentAnchor)
         {
            this.alignmentAnchor.addChild(this.movie);
         }
         if(this.awesomeGame)
         {
            (this.app.ui as MainWidgetGame).game.AlignmentAnchor_Awesome.addChild(this.awesomeGame);
         }
      }
      
      public function RemoveFromStage() : void
      {
         this.app.sessionData.userData.currencyManager.RemoveHandler(this);
         if(this.movie != null)
         {
            if(this.alignmentAnchor)
            {
               this.alignmentAnchor.removeChild(this.movie);
            }
            this.movie.removeChildren();
            this.movie.stop();
            this.movie = null;
         }
         if(this.awesomeGame)
         {
            (this.app.ui as MainWidgetGame).game.AlignmentAnchor_Awesome.removeChild(this.awesomeGame);
            this.awesomeGame.removeChildren();
            this.awesomeGame.stop();
            this.awesomeGame = null;
         }
      }
      
      private function addConfirmButtonListener(param1:Function) : void
      {
         var _loc2_:MovieClip = this.movie.getChildByName("confirmbutton") as MovieClip;
         if(_loc2_ != null)
         {
            _loc2_.useHandCursor = true;
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK,param1);
         }
      }
      
      private function addCancelButtonListener(param1:Function) : void
      {
         this.cancelButton = this.movie.getChildByName("closebutton") as MovieClip;
         if(this.cancelButton != null)
         {
            this.cancelButton.useHandCursor = true;
            this.cancelButton.buttonMode = true;
            this.cancelButton.addEventListener(MouseEvent.CLICK,param1);
         }
      }
      
      public function didAnimationComplete() : Boolean
      {
         return this.movie.currentFrame == this.movie.totalFrames;
      }
      
      private function playExitAnimation() : void
      {
         this.hideAnimationHasStarted = true;
         this.movie.mouseChildren = false;
         this.movie.gotoAndPlay(this.hidePopupFrame);
      }
      
      public function Update(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(!this.audioIsPlayed && this.movie.currentFrame >= this.playAudioFrame)
         {
            this.finisherWidget.playSound(FinisherFacade.FINISHER_POPUP);
            this.audioIsPlayed = true;
         }
         if(!this.timeUpIsCompletelyHidden && this.awesomeGame && this.awesomeGame.currentFrame >= this.timeUpHidingFrameAwesomeGame)
         {
            this.awesomeGame.stop();
         }
         if(!this.timeUpIsCompletelyHidden && this.movie.currentFrame >= this.timeUpHidingFrame)
         {
            this.movie.stop();
            this.timeUpIsCompletelyHidden = true;
         }
         else if(!this.hideAnimationHasStarted && this.timeUpIsCompletelyHidden && this.isTimedPopup && !this.isBlocked)
         {
            ++this.timer;
            if(Blitz3App.app.mIsReplay)
            {
               if((Blitz3App.app.ui as MainWidgetGame).game.encoreForReplayConsumed)
               {
                  this.DispatchPopupConfirmed();
               }
               else
               {
                  this.playExitAnimation();
                  this.DispatchPopupCancelled();
               }
            }
            if(this.timer >= this.popupConfig.GetLifeTime())
            {
               this.playExitAnimation();
               this.DispatchPopupCancelled();
            }
            else
            {
               _loc2_ = 140 * (this.timer * 100) / this.popupConfig.GetLifeTime() / 100;
               this.timerClip.gotoAndStop(_loc2_);
               if(this.timer % 100 == 0)
               {
                  this.app.SoundManager.playSound(Blitz3GameSounds.SOUND_ENCORE_WARNING);
               }
            }
         }
         if(this.hideAnimationHasStarted && this.didAnimationComplete())
         {
            this.DispatchPopupAnimationCompleted();
         }
      }
      
      public function AddHandler(param1:IFinisherPopupHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IFinisherPopupHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      private function DispatchPopupConfirmed() : void
      {
         var _loc1_:IFinisherPopupHandler = null;
         this.playExitAnimation();
         for each(_loc1_ in this._handlers)
         {
            _loc1_.OnFinisherPopupConfirm();
         }
         if(!this.app.mIsReplay)
         {
            this.app.network.HandleFinisherPurchased(true);
            Blitz3App.app.sessionData.finisherManager.ConsumeActiveFinisher(this.finisherFacade.GetFinisherConfig());
            this.app.sessionData.finisherSessionData.FinisherIsPurchased();
            this.app.sessionData.finisherSessionData.SetFinisherHarvestedCurrency(this._currencyType,this.currencyTypeString);
            this.app.sessionData.finisherSessionData.SetFinisherPrice(this.value);
            this.app.sessionData.finisherSessionData.SetCurrentFinisher(this.finisherFacade.GetFinisherConfig().GetID());
            this.app.sessionData.finisherSessionData.SetScoreBeforeFinisher(this.app.logic.GetScoreKeeper().GetScore());
         }
      }
      
      private function DispatchPopupCancelled(param1:Boolean = true) : void
      {
         var _loc2_:IFinisherPopupHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.OnFinisherPopupCancel();
         }
         if(param1)
         {
            this.UpdateFinisherPurchaseCancelled();
         }
      }
      
      private function DispatchPopupAnimationCompleted() : void
      {
         var _loc1_:IFinisherPopupHandler = null;
         for each(_loc1_ in this._handlers)
         {
            _loc1_.OnFinisherPopupAnimationComplete();
         }
      }
      
      private function UpdateFinisherPurchaseCancelled() : void
      {
         if(!this.app.mIsReplay)
         {
            this.app.network.HandleFinisherPurchased(false);
         }
      }
      
      public function HandleBalanceChangedByType(param1:Number, param2:String) : void
      {
      }
      
      public function HandleXPTotalChanged(param1:Number, param2:int) : void
      {
      }
      
      public function HandleBuySkuCallback(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         if(param1 != null)
         {
            _loc2_ = param1.skuId;
            _loc3_ = param1.success;
            if(_loc3_ == true && _loc2_ == "" + this.value)
            {
               this.playExitAnimation();
               this.DispatchPopupConfirmed();
            }
            else
            {
               this.app.sessionData.finisherManager.BlockFinisherPopupTimerAnimation(false);
            }
         }
         else
         {
            this.app.sessionData.finisherManager.BlockFinisherPopupTimerAnimation(false);
         }
         this.app.network.RemoveBuySkuCallbackHandler(this);
      }
      
      private function HasCurrency(param1:int, param2:String) : Boolean
      {
         return this.GetBalance(param1,param2) >= 0;
      }
      
      private function GetBalance(param1:int, param2:String) : Number
      {
         var _loc3_:Number = this.app.sessionData.userData.currencyManager.GetCurrencyByType(param2);
         return _loc3_ - param1;
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.movie.visible = param1;
         if(this.awesomeGame)
         {
            this.awesomeGame.visible = param1;
         }
      }
      
      public function BlockTimerAnimation(param1:Boolean) : void
      {
         this.isBlocked = param1;
      }
   }
}
