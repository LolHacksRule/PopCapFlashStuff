package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.UserTournamentProgressManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentConfigData;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.ITournamentEvent;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.TournamentViewListBox;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class TournamentMainMenuListBox extends ListBox implements ITournamentEvent
   {
       
      
      private var _tournamentViewListBox:TournamentViewListBox;
      
      private var _bgImageLoader:Loader;
      
      private var _iconLoader:Loader;
      
      private var _bgLoadingFinished:Boolean;
      
      private var _iconLoadingFinished:Boolean;
      
      private var _bgBtn:GenericButtonClip;
      
      private var _onBgPress:Function;
      
      private var _loadingClip:MovieClip;
      
      private var _attachedToInfoPopup:Boolean;
      
      public function TournamentMainMenuListBox(param1:Blitz3Game, param2:Boolean = false)
      {
         super(param1);
         this._attachedToInfoPopup = param2;
         this._tournamentViewListBox = new TournamentViewListBox();
         addChild(this._tournamentViewListBox);
         this._bgImageLoader = new Loader();
         this._iconLoader = new Loader();
         this._bgBtn = new GenericButtonClip(_app,this._tournamentViewListBox,true);
         this._bgBtn.setRelease(this.bgBtnPress);
         this._loadingClip = this._tournamentViewListBox.loadingClip;
         this._loadingClip.txtLoading.visible = false;
      }
      
      override public function setData(param1:TournamentRuntimeEntity) : void
      {
         var _loc2_:TournamentConfigData = param1.Data;
         super.setData(param1);
         if(this._loadingClip != null)
         {
            this._loadingClip.visible = false;
         }
         if(_loc2_.Label != "")
         {
            this._tournamentViewListBox.TournamentbgClip.NewTag.amount.text = _loc2_.Label;
         }
         else
         {
            this._tournamentViewListBox.TournamentbgClip.NewTag.visible = false;
         }
         this._tournamentViewListBox.TournamentbgClip.TournamentTitle.TournamentTitle.text = _loc2_.Name;
         this._bgLoadingFinished = true;
         this._iconLoadingFinished = true;
         if(_loc2_.IconURL != "")
         {
            this._iconLoadingFinished = false;
            this._iconLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleIconLoadScuccess);
            this._iconLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
            this._iconLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
            this._iconLoader.load(new URLRequest(_loc2_.IconURL),new LoaderContext(true));
            if(this._loadingClip != null)
            {
               this._loadingClip.visible = true;
            }
         }
         if(_loc2_.BgURL != "")
         {
            this._bgLoadingFinished = false;
            this._tournamentViewListBox.TournamentbgClip.Background.gotoAndStop("dynamic");
            this._tournamentViewListBox.TournamentbgClip.Rank.gotoAndStop("dynamic");
            this._bgImageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.handleBgLoadingSucess);
            this._bgImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleBgLoadingFail);
            this._bgImageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleBgLoadingSecurityError);
            this._bgImageLoader.load(new URLRequest(_loc2_.BgURL),new LoaderContext(true));
            if(this._loadingClip != null)
            {
               this._loadingClip.visible = true;
            }
         }
         else
         {
            this.updateBG();
         }
         var _loc3_:String = "";
         if(_tournament.RemainingTime > 0)
         {
            _loc3_ = Utils.getHourStringFromSeconds(_tournament.RemainingTime);
         }
         else
         {
            _loc3_ = "Ended";
         }
         this._tournamentViewListBox.TournamentbgClip.TimerTextClip.TimerText.text = _loc3_;
         this.updateAccordingToStatus();
         param1.addEventListener(this);
      }
      
      public function get TournamentListBoxObject() : TournamentViewListBox
      {
         return this._tournamentViewListBox;
      }
      
      public function handleBgLoadingSucess(param1:Event) : void
      {
         var width:Number = NaN;
         var height:Number = NaN;
         var bgImage:Bitmap = null;
         var event:Event = param1;
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            return;
         }
         try
         {
            width = this._tournamentViewListBox.TournamentbgClip.Background.width;
            height = this._tournamentViewListBox.TournamentbgClip.Background.height;
            bgImage = new Bitmap();
            bgImage.bitmapData = (this._bgImageLoader.content as Bitmap).bitmapData.clone();
            bgImage.width = width;
            bgImage.height = height;
            bgImage.smoothing = true;
            this._tournamentViewListBox.TournamentbgClip.Background.addChild(bgImage);
            this._tournamentViewListBox.TournamentbgClip.Background.cacheAsBitmap = true;
            this._bgImageLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleBgLoadingSucess);
            this._bgImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleBgLoadingFail);
            this._bgImageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleBgLoadingSecurityError);
         }
         catch(e:Error)
         {
            updateBG();
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to load Bg " + e.message);
         }
         this._bgLoadingFinished = true;
      }
      
      public function handleBgLoadingFail(param1:Event) : void
      {
         this.updateBG();
         this._bgImageLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleBgLoadingSucess);
         this._bgImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleBgLoadingFail);
         this._bgImageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleBgLoadingSecurityError);
         this._bgLoadingFinished = true;
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError on loading bg ");
      }
      
      public function handleBgLoadingSecurityError(param1:Event) : void
      {
         this.updateBG();
         this._bgImageLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleBgLoadingSucess);
         this._bgImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleBgLoadingFail);
         this._bgImageLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleBgLoadingSecurityError);
         this._bgLoadingFinished = true;
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"SecurityError on loading bg ");
      }
      
      public function handleIconLoadScuccess(param1:Event) : void
      {
         var icon:Bitmap = null;
         var width:Number = NaN;
         var height:Number = NaN;
         var event:Event = param1;
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            return;
         }
         try
         {
            icon = new Bitmap();
            width = this._tournamentViewListBox.TournamentbgClip.TournamentIconPlaceholder.width;
            height = this._tournamentViewListBox.TournamentbgClip.TournamentIconPlaceholder.height;
            icon.bitmapData = (this._iconLoader.content as Bitmap).bitmapData.clone();
            icon.x = icon.y = 0;
            icon.width = width;
            icon.height = height;
            icon.smoothing = true;
            Utils.removeAllChildrenFrom(this._tournamentViewListBox.TournamentbgClip.TournamentIconPlaceholder);
            this._tournamentViewListBox.TournamentbgClip.TournamentIconPlaceholder.addChild(icon);
            this._iconLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleIconLoadScuccess);
            this._iconLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
            this._iconLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to load icon " + e.message);
         }
         this._iconLoadingFinished = true;
      }
      
      public function handleIconLoadFail(param1:Event) : void
      {
         this._iconLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleIconLoadScuccess);
         this._iconLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
         this._iconLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
         this._iconLoadingFinished = true;
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError on loading icon ");
      }
      
      public function handleIconSecurityError(param1:Event) : void
      {
         this._iconLoader.contentLoaderInfo.removeEventListener(Event.INIT,this.handleIconLoadScuccess);
         this._iconLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleIconLoadFail);
         this._iconLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.handleIconSecurityError);
         this._iconLoadingFinished = true;
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"SecurityError on loading icon ");
      }
      
      public function get isImageLoadingFinished() : Boolean
      {
         return this._bgLoadingFinished && this._iconLoadingFinished;
      }
      
      public function update() : void
      {
         var _loc4_:Date = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:Boolean = false;
         var _loc1_:Number = _tournament.RemainingTime;
         if(_loc1_ > 0)
         {
            this._tournamentViewListBox.TournamentbgClip.TimerTextClip.TimerText.text = Utils.getHourStringFromSeconds(_loc1_);
         }
         else
         {
            this._tournamentViewListBox.TournamentbgClip.TimerTextClip.TimerText.text = "Ended";
         }
         var _loc2_:UserTournamentProgressManager = _app.sessionData.tournamentController.UserProgressManager;
         if(this.isImageLoadingFinished && UserTournamentProgressManager.firstTimeFetched)
         {
            if(this._loadingClip != null)
            {
               this._loadingClip.visible = false;
            }
            var _loc3_:UserTournamentProgress = _loc2_.getUserProgress(_tournament.Data.Id);
            if(_tournament.Status == TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
            {
               this._tournamentViewListBox.TournamentbgClip.Background.joinRetryBg.visible = false;
               if(_loc3_ != null)
               {
                  _loc5_ = (_loc4_ = new Date()).getTime().valueOf() / 1000;
                  _loc7_ = (_loc6_ = _tournament.getExpectedResultsAvailableTime()) - _loc5_;
                  _loc8_ = Utils.getHourStringFromSeconds(_loc7_);
                  this._tournamentViewListBox.TournamentbgClip.Discription.visible = true;
                  _loc9_ = "Results are loading in";
                  if(_loc7_ > 0)
                  {
                     _loc9_ += " " + _loc8_;
                  }
                  this._tournamentViewListBox.TournamentbgClip.Discription.TournamentDiscription.text = _loc9_;
                  this._tournamentViewListBox.TournamentbgClip.gotoAndStop("computing");
                  this._tournamentViewListBox.TournamentbgClip.Rank.visible = false;
               }
            }
            else if(_tournament.IsUserEligibleForReward())
            {
               this._tournamentViewListBox.TournamentbgClip.Background.joinRetryBg.visible = false;
               if(!_loc3_.hasClaimed)
               {
                  if(_loc10_ = _tournament.serverHasValidatedEndState)
                  {
                     _loc5_ = (_loc4_ = new Date()).getTime().valueOf() / 1000;
                     _loc7_ = _tournament.Data.ExpiryTime - _loc5_;
                     _loc8_ = Utils.getHourStringFromSeconds(_loc7_);
                     this._tournamentViewListBox.TournamentbgClip.Discription.visible = true;
                     this._tournamentViewListBox.TournamentbgClip.Discription.TournamentDiscription.text = "Claim your Reward\nReward expires in " + _loc8_;
                  }
               }
               else
               {
                  this._tournamentViewListBox.TournamentbgClip.Discription.visible = false;
               }
               this._tournamentViewListBox.TournamentbgClip.gotoAndStop("ended");
            }
            return;
         }
      }
      
      public function onStatusChanged(param1:int, param2:int) : void
      {
         this.updateAccordingToStatus();
      }
      
      public function onRankChanged(param1:int, param2:int) : void
      {
      }
      
      private function updateBG() : void
      {
         if(_tournament.Data.Category == TournamentCommonInfo.TOUR_CATEGORY_COMMON)
         {
            this._tournamentViewListBox.TournamentbgClip.Background.gotoAndStop("common");
            this._tournamentViewListBox.TournamentbgClip.Rank.gotoAndStop("common");
            this._tournamentViewListBox.TournamentbgClip.sheenAnimation.visible = false;
         }
         else if(_tournament.Data.Category == TournamentCommonInfo.TOUR_CATEGORY_RARE)
         {
            this._tournamentViewListBox.TournamentbgClip.Background.gotoAndStop("rare");
            this._tournamentViewListBox.TournamentbgClip.Rank.gotoAndStop("rare");
         }
         else if(_tournament.Data.Category == TournamentCommonInfo.TOUR_CATEGORY_VIP)
         {
            this._tournamentViewListBox.TournamentbgClip.Background.gotoAndStop("vip");
            this._tournamentViewListBox.TournamentbgClip.Rank.gotoAndStop("vip");
         }
      }
      
      private function updateAccordingToStatus() : void
      {
         var _loc1_:UserTournamentProgress = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         if(!this._attachedToInfoPopup)
         {
            this._tournamentViewListBox.TournamentbgClip.Discription.TournamentDiscription.text = "";
            _loc1_ = _app.sessionData.tournamentController.UserProgressManager.getUserProgress(_tournament.Data.Id);
            if(_tournament.IsRunning())
            {
               this._tournamentViewListBox.TournamentbgClip.gotoAndStop("ongoing");
               if(_loc1_ == null)
               {
                  this._tournamentViewListBox.TournamentbgClip.Rank.visible = false;
                  if(_tournament.Data.JoiningCost.mAmount <= 0)
                  {
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.visible = false;
                     this._tournamentViewListBox.TournamentbgClip.JoinNoCost.visible = true;
                     this._tournamentViewListBox.TournamentbgClip.JoinNoCost.JoinText.text = "JOIN";
                  }
                  else
                  {
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.visible = true;
                     _loc2_ = _tournament.Data.JoiningCost.mAmount;
                     _loc3_ = _loc2_ < 99999 ? Utils.commafy(_loc2_) : Utils.formatNumberToBJBNumberString(_loc2_);
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.CostAmount.text = _loc3_;
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.JoinText.text = "JOIN";
                     (_loc4_ = CurrencyManager.getImageByType(_tournament.Data.JoiningCost.mCurrencyType,false)).smoothing = true;
                     Utils.removeAllChildrenFrom(this._tournamentViewListBox.TournamentbgClip.JoinCost.CurrencyPlaceholder);
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.CurrencyPlaceholder.addChild(_loc4_);
                     this._tournamentViewListBox.TournamentbgClip.JoinNoCost.visible = false;
                  }
               }
               else
               {
                  if(_tournament.Data.RetryCost.mAmount <= 0)
                  {
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.visible = false;
                     this._tournamentViewListBox.TournamentbgClip.JoinNoCost.visible = true;
                     this._tournamentViewListBox.TournamentbgClip.JoinNoCost.JoinText.text = "RETRY";
                  }
                  else
                  {
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.visible = true;
                     _loc2_ = _tournament.Data.RetryCost.mAmount;
                     _loc3_ = _loc2_ < 99999 ? Utils.commafy(_loc2_) : Utils.formatNumberToBJBNumberString(_loc2_);
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.CostAmount.text = _loc3_;
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.JoinText.text = "RETRY";
                     (_loc4_ = CurrencyManager.getImageByType(_tournament.Data.RetryCost.mCurrencyType,false)).smoothing = true;
                     Utils.removeAllChildrenFrom(this._tournamentViewListBox.TournamentbgClip.JoinCost.CurrencyPlaceholder);
                     this._tournamentViewListBox.TournamentbgClip.JoinCost.CurrencyPlaceholder.addChild(_loc4_);
                     this._tournamentViewListBox.TournamentbgClip.JoinNoCost.visible = false;
                  }
                  this._tournamentViewListBox.TournamentbgClip.Rank.visible = true;
                  this._tournamentViewListBox.TournamentbgClip.Rank.RankText.text = Utils.getRankText(_loc1_.getUserRank());
               }
            }
            else
            {
               _loc5_ = _tournament.HasEnded();
               _loc6_ = _tournament.IsComputingResults();
               _loc7_ = false;
               _loc8_ = _tournament.serverHasValidatedEndState;
               if(_loc1_ != null)
               {
                  _loc9_ = _loc1_.getUserRank();
                  this._tournamentViewListBox.TournamentbgClip.Rank.visible = true;
                  this._tournamentViewListBox.TournamentbgClip.Rank.RankText.text = Utils.getRankText(_loc9_);
                  if(_loc10_ = _tournament.Data.rankHasReward(_loc9_))
                  {
                     _loc7_ = true;
                  }
                  if(_loc6_)
                  {
                     this._tournamentViewListBox.TournamentbgClip.gotoAndStop("computing");
                     this._tournamentViewListBox.TournamentbgClip.Rank.visible = false;
                  }
                  else if(_loc5_ && _loc7_)
                  {
                     if(_loc8_)
                     {
                        this._tournamentViewListBox.TournamentbgClip.gotoAndStop("ended");
                        this._tournamentViewListBox.TournamentbgClip.Discription.visible = true;
                        this._tournamentViewListBox.TournamentbgClip.Discription.TournamentDiscription.text = "Claim your Reward";
                     }
                     else
                     {
                        this._tournamentViewListBox.TournamentbgClip.Discription.TournamentDiscription.text = "Results are loading..";
                     }
                  }
               }
               else if(_loc1_ == null)
               {
                  this.HideJoinCostTextForInfoScreen();
               }
            }
         }
         else
         {
            this.HideJoinCostTextForInfoScreen();
         }
      }
      
      private function bgBtnPress() : void
      {
         if(this._onBgPress != null && UserTournamentProgressManager.firstTimeFetched)
         {
            this._onBgPress(_tournament.Id);
         }
      }
      
      public function setOnBgPressed(param1:Function) : void
      {
         this._onBgPress = param1;
      }
      
      public function reset() : void
      {
         _tournament.removeEventListener(this);
      }
      
      public function HideJoinCostTextForInfoScreen() : void
      {
         var _loc1_:UserTournamentProgress = null;
         if(this._tournamentViewListBox.TournamentbgClip.JoinCost != null)
         {
            this._tournamentViewListBox.TournamentbgClip.JoinCost.visible = false;
         }
         if(this._tournamentViewListBox.TournamentbgClip.JoinNoCost != null)
         {
            this._tournamentViewListBox.TournamentbgClip.JoinNoCost.visible = false;
         }
         if(this._tournamentViewListBox.TournamentbgClip.Discription != null && this._tournamentViewListBox.TournamentbgClip.Discription.TournamentDiscription != null)
         {
            this._tournamentViewListBox.TournamentbgClip.Discription.TournamentDiscription.text = "";
         }
         this._tournamentViewListBox.TournamentbgClip.Background.joinRetryBg.visible = false;
         this._tournamentViewListBox.TournamentbgClip.InfoGlow.visible = !this._attachedToInfoPopup;
         if(this._bgBtn != null)
         {
            this._bgBtn.IgnoreHover = this._attachedToInfoPopup;
         }
         if(_tournament != null)
         {
            _loc1_ = _app.sessionData.tournamentController.UserProgressManager.getUserProgress(_tournament.Data.Id);
            if(_loc1_ != null)
            {
               this._tournamentViewListBox.TournamentbgClip.Rank.visible = true;
               this._tournamentViewListBox.TournamentbgClip.Rank.RankText.text = Utils.getRankText(_loc1_.getUserRank());
            }
            else
            {
               this._tournamentViewListBox.TournamentbgClip.Rank.visible = false;
            }
         }
      }
      
      public function DisableBgButton() : void
      {
         this._bgBtn.deactivate();
      }
   }
}
