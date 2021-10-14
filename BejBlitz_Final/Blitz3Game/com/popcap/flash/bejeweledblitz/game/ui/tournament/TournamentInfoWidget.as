package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.TournamentController;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentConfigData;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRewardTierInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.ITournamentEvent;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.InsufficientFundsDialog;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.games.blitz3.BlitzChampions_InfoWidget;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   public class TournamentInfoWidget extends ListBox implements ITournamentEvent
   {
      
      private static var _MAX_ENTRIES:int = 3;
      
      public static const BOX_HEIGHT:Number = 77;
      
      public static const PAGINATION_HEIGHT:Number = BOX_HEIGHT * _MAX_ENTRIES;
      
      public static const START_Y:Number = 37;
      
      public static const DETAILS_TAB:String = "details";
      
      public static const LEADERBOARD_TAB:String = "leaderboard";
       
      
      private var _widget:BlitzChampions_InfoWidget;
      
      private var _btnClose:GenericButtonClip;
      
      private var _btnJoinRetry:GenericButtonClip;
      
      private var _tourId:String;
      
      private var _detailsTab:GenericButtonClip;
      
      private var _tLBTab:GenericButtonClip;
      
      private var _rewardContainer:MovieClip;
      
      private var _listBoxArray:Vector.<TournamentInfoRewardListBox>;
      
      private var _minY:Number = 0;
      
      private var _currentTopBoxIndex:int = 0;
      
      private var _maxTopBoxIndex:int = 0;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      private var _leaderboardView:TournamentLeaderboardWidget;
      
      private var _leftPanelInfoView:TournamentMainMenuListBox;
      
      private var _leftPanelTimer:Timer;
      
      private var _joinOrRetry:Boolean;
      
      private var _showJoinRetryButton:Boolean;
      
      private var _allRulesTextFields:Vector.<TextField>;
      
      private var _allRulesTextFieldsBulletPoints:Vector.<MovieClip>;
      
      private var _tieBreakerInfoBtn:GenericButtonClip;
      
      private var _currentActiveTab:String = "";
      
      private var _currentParent:String = "";
      
      public function TournamentInfoWidget(param1:Blitz3Game)
      {
         super(param1);
         this._tourId = "";
         this._leaderboardView = null;
         this._leftPanelInfoView = null;
         this._leftPanelTimer = null;
         this._widget = null;
         this._showJoinRetryButton = true;
         this._allRulesTextFields = new Vector.<TextField>();
         this._allRulesTextFieldsBulletPoints = new Vector.<MovieClip>();
      }
      
      public function Init() : void
      {
         if(this._widget == null)
         {
            this._widget = new BlitzChampions_InfoWidget();
            addChild(this._widget);
         }
         this._joinOrRetry = true;
         this._btnClose = new GenericButtonClip(_app,this._widget.InfoWidget.closebutton,true);
         this._btnClose.setPress(this.closePress);
         this._btnJoinRetry = new GenericButtonClip(_app,this._widget.InfoWidget.JoinRetry,false);
         this._btnJoinRetry.setPress(this.onJoinRetryClicked);
         this._detailsTab = new GenericButtonClip(_app,this._widget.InfoWidget.DetailsButton);
         this._detailsTab.setRelease(this.onTabPress,DETAILS_TAB);
         this._detailsTab.setShowGraphics(false);
         this._detailsTab.activate();
         this._tLBTab = new GenericButtonClip(_app,this._widget.InfoWidget.LeaderboardButton);
         this._tLBTab.setRelease(this.onTabPress,LEADERBOARD_TAB);
         this._tLBTab.setShowGraphics(false);
         this._tLBTab.activate();
         this._rewardContainer = this._widget.InfoWidget.ChampionshipInfoView.RewardContainer;
         this._rewardContainer.visible = false;
         this._widget.InfoWidget.ChampionshipInfoView.loadingClip.visible = true;
         this._btnDown = new GenericButtonClip(_app,this._widget.InfoWidget.ChampionshipInfoView.btnDown,false);
         this._btnDown.setPress(this.downPress);
         this._btnDown.clipListener.gotoAndStop("disable");
         this._btnUp = new GenericButtonClip(_app,this._widget.InfoWidget.ChampionshipInfoView.btnUp,false);
         this._btnUp.setPress(this.upPress);
         this._btnUp.clipListener.gotoAndStop("disable");
         this._tieBreakerInfoBtn = new GenericButtonClip(_app,this._widget.InfoWidget.ChampionshipInfoView.TieBreakerInfoButton,true);
         this._tieBreakerInfoBtn.activate();
         this._tieBreakerInfoBtn.IgnoreClick = true;
         this._widget.InfoWidget.ChampionshipInfoView.Objective_Txt.visible = false;
         this.hideLeaderboard();
         if(this._leaderboardView == null)
         {
            this._leaderboardView = new TournamentLeaderboardWidget(_app);
            this._leaderboardView.init(this._widget.InfoWidget.LeaderboardData);
            addChild(this._leaderboardView);
         }
         if(this._leftPanelInfoView == null)
         {
            this._leftPanelInfoView = new TournamentMainMenuListBox(_app,true);
            this._leftPanelInfoView.setOnBgPressed(null);
            this._widget.TournamentbgClip.addChild(this._leftPanelInfoView);
         }
         if(this._leftPanelTimer == null)
         {
            this._leftPanelTimer = new Timer(1000);
            this._leftPanelTimer.addEventListener(TimerEvent.TIMER,this.updateLeftPanelInfo);
         }
         this._allRulesTextFields.splice(0,this._allRulesTextFields.length);
         this._allRulesTextFieldsBulletPoints.splice(0,this._allRulesTextFieldsBulletPoints.length);
         this._allRulesTextFields.push(this._widget.InfoWidget.ChampionshipInfoView.RulesText1);
         this._allRulesTextFields.push(this._widget.InfoWidget.ChampionshipInfoView.RulesText2);
         this._allRulesTextFields.push(this._widget.InfoWidget.ChampionshipInfoView.RulesText3);
         this._allRulesTextFieldsBulletPoints.push(this._widget.InfoWidget.ChampionshipInfoView.Ruleset_bullet1);
         this._allRulesTextFieldsBulletPoints.push(this._widget.InfoWidget.ChampionshipInfoView.Ruleset_bullet2);
         this._allRulesTextFieldsBulletPoints.push(this._widget.InfoWidget.ChampionshipInfoView.Ruleset_bullet3);
      }
      
      private function onTabPress(param1:String) : void
      {
         if(this._currentActiveTab == param1)
         {
            return;
         }
         this._currentActiveTab = param1;
         this.hideLeaderboard();
         if(param1 == DETAILS_TAB)
         {
            this._leaderboardView.updateData(_tournament);
            this._widget.InfoWidget.ChampionshipInfoView.visible = true;
            this._widget.InfoWidget.LeaderboardData.visible = false;
            this._widget.InfoWidget.DetailsButton.gotoAndStop("enable");
            this._widget.InfoWidget.LeaderboardButton.gotoAndStop("disable");
            this._tieBreakerInfoBtn.clipListener.visible = _tournament.Data.Objective.Type != TournamentCommonInfo.OBJECTIVE_SCORE;
            this._widget.InfoWidget.ChampionshipInfoView.Objective_Txt.visible = _tournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_SCORE;
            this._tieBreakerInfoBtn.SetDisabled(!this._tieBreakerInfoBtn.clipListener.visible);
            this._leaderboardView.setVisibility(false);
            if(_app.mainState.isCurrentStateGame())
            {
               _app.network.SendUIMetrics("Tournament Info","Tournament Game End",this._tourId);
            }
            else if(((_app as Blitz3App).ui as MainWidgetGame).boostDialog && ((_app as Blitz3App).ui as MainWidgetGame).boostDialog.visible == true)
            {
               _app.network.SendUIMetrics("Tournament Info","Boost Loadout",this._tourId);
            }
            _tournament.addEventListener(this);
         }
         else
         {
            this._widget.InfoWidget.ChampionshipInfoView.visible = false;
            this._widget.InfoWidget.LeaderboardData.visible = true;
            this._widget.InfoWidget.DetailsButton.gotoAndStop("disable");
            this._widget.InfoWidget.LeaderboardButton.gotoAndStop("enable");
            this._leaderboardView.setVisibility(true);
            this._leaderboardView.updateData(_tournament);
         }
      }
      
      public function hideLeaderboard() : void
      {
         this._widget.InfoWidget.LeaderboardData.visible = false;
         this._widget.InfoWidget.LeaderboardButton.gotoAndPlay("disable");
      }
      
      private function onJoinRetryClicked() : void
      {
         var _loc2_:String = null;
         var _loc3_:InsufficientFundsDialog = null;
         var _loc1_:TournamentController = _app.sessionData.tournamentController;
         _loc1_.setCurrentTournamentId(this._tourId);
         if(!_loc1_.ValidateJoinAndRetryCost(this._joinOrRetry))
         {
            _loc2_ = "";
            if(this._joinOrRetry)
            {
               _loc2_ = _loc1_.getCurrentTournament().Data.JoiningCost.mCurrencyType;
            }
            else
            {
               _loc2_ = _loc1_.getCurrentTournament().Data.RetryCost.mCurrencyType;
            }
            _loc3_ = new InsufficientFundsDialog(_app,_loc2_);
            _loc3_.Show();
            return;
         }
         _loc1_.HandleJoinRetryCost(this._joinOrRetry);
         (_app.ui as MainWidgetGame).menu.leftPanel.showMainButton(true);
         _app.logic.SetConfig(BlitzLogic.TOURNAMENT_CONFIG);
         _loc1_.setRareGemForHarvestScreen();
         _app.mainState.onLeaveMainMenu();
         if(this._tourId == "")
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Setting tournament Id empty !!! ");
         }
         this.closePress();
         this._currentActiveTab = "";
      }
      
      override public function setData(param1:TournamentRuntimeEntity) : void
      {
         super.setData(param1);
         this._tourId = param1.Id;
         this.setupInfoScreen();
         this.buildRewardList();
         this._rewardContainer.visible = true;
         this._widget.InfoWidget.ChampionshipInfoView.loadingClip.visible = false;
      }
      
      private function buildRewardList() : void
      {
         var _loc2_:TournamentInfoRewardListBox = null;
         this.clearRewardList();
         var _loc1_:Vector.<TournamentRewardTierInfo> = _tournament.Data.tournamentRewards;
         var _loc3_:Number = this._rewardContainer.RewardtemplateClip.x;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = new TournamentInfoRewardListBox(_app,_loc1_[_loc4_]);
            _loc2_.x = _loc3_;
            _loc2_.y = START_Y + _loc4_ * BOX_HEIGHT;
            this._listBoxArray.push(_loc2_);
            this._rewardContainer.addChild(_loc2_);
            _loc4_++;
         }
         this._rewardContainer.RewardtemplateClip.visible = false;
         this.setBoundaries();
         this.handleArrowButtons();
      }
      
      private function setupInfoScreen() : void
      {
         var _loc13_:MovieClip = null;
         this._widget.InfoWidget.ChampionshipInfoView.visible = true;
         this._widget.InfoWidget.DetailsButton.gotoAndPlay("enable");
         this._widget.InfoWidget.ChampionshipInfoView.Requirments1.text = "";
         this._widget.InfoWidget.ChampionshipInfoView.Requirments2.text = "";
         this._widget.InfoWidget.ChampionshipInfoView.Requirement_bullet1.visible = false;
         this._widget.InfoWidget.ChampionshipInfoView.Requirement_bullet2.visible = false;
         var _loc1_:int = this._allRulesTextFields.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._allRulesTextFields[_loc2_].text = "";
            this._allRulesTextFieldsBulletPoints[_loc2_].visible = false;
            _loc2_++;
         }
         var _loc3_:TournamentConfigData = _tournament.Data;
         this._widget.InfoWidget.ChampionshipInfoView.Objective.Desciption.text = _loc3_.Description;
         this._widget.InfoWidget.ChampionshipInfoView.MaxParticipantsCount.text = _loc3_.LeaderboardSize.toString();
         var _loc4_:UserTournamentProgress = _app.sessionData.tournamentController.UserProgressManager.getUserProgress(_loc3_.Id);
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:int = 0;
         var _loc8_:String = "";
         var _loc9_:String = "";
         if(_tournament.IsRunning())
         {
            if(_loc4_ == null)
            {
               if((_loc7_ = _loc3_.JoiningCost.mAmount) == 0)
               {
                  _loc6_ = "JOIN";
                  _loc5_ = "";
                  _loc9_ = "";
               }
               else
               {
                  _loc6_ = "";
                  _loc5_ = "JOIN";
                  _loc8_ = _loc3_.JoiningCost.mCurrencyType;
                  _loc9_ = _loc7_ <= 99999 ? Utils.commafy(_loc7_) : Utils.formatNumberToBJBNumberString(_loc7_);
               }
               this._joinOrRetry = true;
            }
            else
            {
               if((_loc7_ = _loc3_.RetryCost.mAmount) == 0)
               {
                  _loc6_ = "RETRY";
                  _loc5_ = "";
                  _loc9_ = "";
               }
               else
               {
                  _loc6_ = "";
                  _loc5_ = "RETRY";
                  _loc8_ = _loc3_.RetryCost.mCurrencyType;
                  _loc9_ = _loc7_ <= 99999 ? Utils.commafy(_loc7_) : Utils.formatNumberToBJBNumberString(_loc7_);
               }
               this._joinOrRetry = false;
            }
            this._widget.InfoWidget.JoinRetry.visible = this._showJoinRetryButton;
            this._widget.InfoWidget.JoinRetry.textWithoutCurrency.text = _loc6_;
            this._widget.InfoWidget.JoinRetry.textWithCurrency.text = _loc5_;
            this._widget.InfoWidget.JoinRetry.amount.text = _loc9_;
            Utils.removeAllChildrenFrom(this._widget.InfoWidget.JoinRetry.currency_palceholder);
            if(_loc8_ != "")
            {
               _loc13_ = CurrencyManager.getImageByType(_loc8_,false);
               _loc13_.width *= 0.7;
               _loc13_.height *= 0.7;
               _loc13_.smoothing = true;
               this._widget.InfoWidget.JoinRetry.currency_palceholder.addChild(_loc13_);
            }
         }
         else
         {
            this._widget.InfoWidget.JoinRetry.visible = false;
         }
         var _loc10_:Object;
         if((_loc10_ = _loc3_.getRequirementsText())["rg"] != "" || _loc10_["boost"] != "")
         {
            this._widget.InfoWidget.ChampionshipInfoView.Requirments1.text = _loc10_["rg"];
            this._widget.InfoWidget.ChampionshipInfoView.Requirement_bullet1.visible = true;
            if(this._widget.InfoWidget.ChampionshipInfoView.Requirments1.text == "")
            {
               if(_loc10_["boost"] != "")
               {
                  this._widget.InfoWidget.ChampionshipInfoView.Requirments1.text = _loc10_["boost"];
               }
               else
               {
                  this._widget.InfoWidget.ChampionshipInfoView.Requirement_bullet1.visible = false;
               }
            }
            else if(_loc10_["boost"] != "")
            {
               this._widget.InfoWidget.ChampionshipInfoView.Requirments2.text = _loc10_["boost"];
               this._widget.InfoWidget.ChampionshipInfoView.Requirement_bullet2.visible = true;
            }
         }
         else
         {
            this._widget.InfoWidget.ChampionshipInfoView.Requirments1.text = "No Holds Barred";
            this._widget.InfoWidget.ChampionshipInfoView.Requirement_bullet1.visible = true;
         }
         var _loc11_:Object = _loc3_.getRulesTextDictionary();
         var _loc12_:int = 0;
         if(_loc11_["game_duration"] != "")
         {
            this._allRulesTextFields[_loc12_].text = _loc11_["game_duration"];
            this._allRulesTextFieldsBulletPoints[_loc12_].visible = true;
            _loc12_++;
         }
         if(_loc11_["colors"] != "")
         {
            this._allRulesTextFields[_loc12_].text = _loc11_["colors"];
            this._allRulesTextFieldsBulletPoints[_loc12_].visible = true;
            _loc12_++;
         }
         if(_loc11_["eternal_blazing_Speed"] != "")
         {
            this._allRulesTextFields[_loc12_].text = _loc11_["eternal_blazing_Speed"];
            this._allRulesTextFieldsBulletPoints[_loc12_].visible = true;
            _loc12_++;
         }
         if(_loc11_["fast_gem_drop"] != "")
         {
            if(_loc12_ > 2)
            {
               _loc12_ = 2;
            }
            this._allRulesTextFields[_loc12_].text = _loc11_["fast_gem_drop"];
            this._allRulesTextFieldsBulletPoints[_loc12_].visible = true;
         }
      }
      
      public function Show(param1:String, param2:String) : void
      {
         this._currentActiveTab = "";
         this._currentParent = param2;
         _app.quest.Hide();
         if(this._leftPanelInfoView == null)
         {
            this._leftPanelInfoView = new TournamentMainMenuListBox(_app,true);
            this._leftPanelInfoView.setOnBgPressed(null);
            this._widget.TournamentbgClip.addChild(this._leftPanelInfoView);
         }
         this._leftPanelInfoView.setData(_tournament);
         this._leftPanelInfoView.HideJoinCostTextForInfoScreen();
         this._leftPanelInfoView.DisableBgButton();
         this._leftPanelTimer.start();
         this.setVisibility(true);
         this.onTabPress(param1);
         this.playIntro();
         _app.metaUI.highlight.showPopUp(this,true,true,0.75);
         this.x = Dimensions.PRELOADER_WIDTH / 2 - 200;
         this.y = Dimensions.PRELOADER_HEIGHT / 2 - 238;
      }
      
      public function playIntro() : void
      {
         this._widget.gotoAndPlay("intro");
      }
      
      public function setVisibility(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function closePress() : void
      {
         this._currentActiveTab = "";
         _tournament.removeEventListener(this);
         _tournament.removeEventListener(this._leaderboardView);
         this.resetJoinRetryButtonStatus();
         this.setVisibility(false);
         this._leaderboardView.setVisibility(false);
         this._leftPanelTimer.stop();
         if(this._leftPanelInfoView)
         {
            this._widget.TournamentbgClip.removeChild(this._leftPanelInfoView);
         }
         this._leftPanelInfoView = null;
         _app.metaUI.highlight.hidePopUp();
         this._currentParent = "";
      }
      
      public function clearRewardList() : void
      {
         this._currentTopBoxIndex = 0;
         this._maxTopBoxIndex = 0;
         this._rewardContainer.y = 0;
         this._minY = 0;
         if(this._listBoxArray != null)
         {
            this._listBoxArray.splice(0,this._listBoxArray.length);
         }
         while(this._rewardContainer.numChildren > 0)
         {
            this._rewardContainer.removeChildAt(0);
         }
         this._listBoxArray = new Vector.<TournamentInfoRewardListBox>();
      }
      
      private function setBoundaries() : void
      {
         if(this._listBoxArray.length > _MAX_ENTRIES)
         {
            this._minY = -(this._listBoxArray.length - _MAX_ENTRIES) * BOX_HEIGHT;
            this._maxTopBoxIndex = this._listBoxArray.length - _MAX_ENTRIES;
         }
         else
         {
            this._minY = 0;
            this._maxTopBoxIndex = 0;
         }
      }
      
      private function upPress() : void
      {
         this._currentTopBoxIndex -= _MAX_ENTRIES;
         if(this._currentTopBoxIndex < 0)
         {
            this._currentTopBoxIndex = 0;
         }
         this.update();
      }
      
      public function downPress() : void
      {
         this._currentTopBoxIndex += _MAX_ENTRIES;
         if(this._currentTopBoxIndex > this._maxTopBoxIndex)
         {
            this._currentTopBoxIndex = this._maxTopBoxIndex;
         }
         this.update();
      }
      
      private function update() : void
      {
         this.handleArrowButtons();
         this.updateScroll();
      }
      
      private function updateScroll() : void
      {
         Tweener.removeTweens(this._rewardContainer);
         Tweener.addTween(this._rewardContainer,{
            "y":-this._currentTopBoxIndex * BOX_HEIGHT,
            "time":0.5
         });
      }
      
      private function handleArrowButtons() : void
      {
         if(this._listBoxArray.length <= _MAX_ENTRIES)
         {
            this._currentTopBoxIndex = 0;
            this.btnEnableUp(false);
            this.btnEnableDown(false);
            return;
         }
         if(this._currentTopBoxIndex <= 0)
         {
            this._currentTopBoxIndex = 0;
            this.btnEnableUp(false);
         }
         else
         {
            this.btnEnableUp(true);
         }
         if(this._currentTopBoxIndex >= this._maxTopBoxIndex)
         {
            this._currentTopBoxIndex = this._maxTopBoxIndex;
            this.btnEnableDown(false);
         }
         else
         {
            this.btnEnableDown(true);
         }
      }
      
      private function btnEnableUp(param1:Boolean) : void
      {
         if(param1)
         {
            this._btnUp.clipListener.gotoAndStop("up");
            this._btnUp.activate();
         }
         else
         {
            this._btnUp.deactivate();
            this._btnUp.clipListener.gotoAndStop("disable");
         }
      }
      
      private function btnEnableDown(param1:Boolean) : void
      {
         if(param1)
         {
            this._btnDown.clipListener.gotoAndStop("up");
            this._btnDown.activate();
         }
         else
         {
            this._btnDown.deactivate();
            this._btnDown.clipListener.gotoAndStop("disable");
         }
      }
      
      private function updateLeftPanelInfo(param1:TimerEvent) : void
      {
         var _loc3_:Date = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(this._leftPanelInfoView.getData() != null)
         {
            this._leftPanelInfoView.update();
         }
         var _loc2_:Boolean = _app.sessionData.tournamentController.UserProgressManager && _app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(_tournament.Id);
         if(_loc2_ && _tournament.IsComputingResults())
         {
            _loc3_ = new Date();
            _loc4_ = _loc3_.getTime().valueOf() / 1000;
            _loc6_ = (_loc5_ = _tournament.getExpectedResultsAvailableTime()) - _loc4_;
            _loc7_ = Utils.getHourStringFromSeconds(_loc6_);
            _loc8_ = "Your results are loading.";
            if(_loc6_ > 0)
            {
               _loc8_ += "This should take " + _loc7_;
            }
            this._widget.InfoWidget.ChampionshipInfoView.Info.visible = true;
            this._widget.InfoWidget.ChampionshipInfoView.Info.text = _loc8_;
         }
         else
         {
            this._widget.InfoWidget.ChampionshipInfoView.Info.visible = false;
         }
      }
      
      public function hideJoinRetryButton() : void
      {
         this._showJoinRetryButton = false;
         this._widget.InfoWidget.JoinRetry.visible = this._showJoinRetryButton;
      }
      
      public function resetJoinRetryButtonStatus() : void
      {
         this._showJoinRetryButton = true;
         this._widget.InfoWidget.JoinRetry.visible = this._showJoinRetryButton;
      }
      
      public function get LeaderboardView() : TournamentLeaderboardWidget
      {
         return this._leaderboardView;
      }
      
      public function onStatusChanged(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         if(param2 != TournamentCommonInfo.TOUR_STATUS_RUNNING)
         {
            this.hideJoinRetryButton();
            _loc3_ = _app.sessionData.tournamentController.UserProgressManager && _app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(_tournament.Id);
            if(_loc3_ && param2 == TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
            {
               this._widget.InfoWidget.ChampionshipInfoView.Info.visible = true;
               this._widget.InfoWidget.ChampionshipInfoView.Info.text = "Your results are loading.";
            }
            else
            {
               this._widget.InfoWidget.ChampionshipInfoView.Info.visible = false;
            }
         }
      }
      
      public function onRankChanged(param1:int, param2:int) : void
      {
      }
      
      public function setStatusOfLeaderboardButton(param1:Boolean) : void
      {
         this._tLBTab.SetDisabled(!param1);
      }
   }
}
