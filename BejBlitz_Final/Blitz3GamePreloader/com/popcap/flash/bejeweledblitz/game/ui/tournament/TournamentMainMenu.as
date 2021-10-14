package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.TournamentRuntimeEntityManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.UserTournamentProgressManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.TournamentViewWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TournamentMainMenu extends TournamentMainMenuMovieClip implements IFeatureManagerHandler
   {
      
      private static const MAX_SCREEN_BOXES:Number = 3;
       
      
      public var BOX_WIDTH:Number;
      
      public var START_X:Number = -44;
      
      public var END_X:Number = 0;
      
      private var _tournamentListView:TournamentViewWidget;
      
      private var _tournamentInfoView:TournamentInfoWidget;
      
      private var _tournamentRewardScreen:TournamentRewardWidget;
      
      private var _aboutTournamentView:AboutTournamentWidget;
      
      private var _buttonLeft:GenericButtonClip;
      
      private var _buttonRight:GenericButtonClip;
      
      private var _buttonHistory:GenericButtonClip;
      
      private var _buttonAbout:GenericButtonClip;
      
      private var _buttonRefresh:GenericButtonClip;
      
      private var _listBoxArray:Vector.<TournamentMainMenuListBox>;
      
      private var _currentLeftBoxIndex:int = 0;
      
      private var _maxRightBoxIndex:int = 0;
      
      private var _direction:int;
      
      private var _tournamnetHistoryWidget:TournamnetHistoryWidget;
      
      private var _checkForAvailability:Boolean;
      
      public function TournamentMainMenu(param1:Blitz3Game)
      {
         super(param1);
         this._listBoxArray = new Vector.<TournamentMainMenuListBox>();
         this._checkForAvailability = false;
         var _loc2_:Timer = new Timer(1000);
         _loc2_.addEventListener(TimerEvent.TIMER,this.timerUpdate);
         _loc2_.start();
      }
      
      public function HandleFeatureEnabled(param1:String) : void
      {
      }
      
      public function clear() : void
      {
         var _loc1_:int = this._listBoxArray.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._listBoxArray[_loc2_].reset();
            _loc2_++;
         }
         this._listBoxArray.splice(0,_loc1_);
         Utils.removeAllChildrenFrom(_boxContainer);
      }
      
      public function reset() : void
      {
         removeChild(this._tournamentListView);
         this._tournamentListView = null;
         this._tournamnetHistoryWidget = null;
         removeChild(this._tournamentInfoView);
         this._tournamentInfoView = null;
         removeChild(this._aboutTournamentView);
         this._aboutTournamentView = null;
         removeChild(this._tournamentRewardScreen);
         this._tournamentRewardScreen = null;
      }
      
      public function init() : void
      {
         this._tournamentListView = new TournamentViewWidget();
         addChild(this._tournamentListView);
         this._tournamnetHistoryWidget = new TournamnetHistoryWidget(_app);
         this._tournamnetHistoryWidget.init();
         this._tournamnetHistoryWidget.setOnClose(this.onHistoryClose);
         this._tournamnetHistoryWidget.setVisibility(false);
         this._tournamentRewardScreen = new TournamentRewardWidget(_app);
         addChild(this._tournamentRewardScreen);
         this._tournamentRewardScreen.hide();
         this._tournamentRewardScreen.x = -220;
         this._tournamentRewardScreen.y = -40;
         this._aboutTournamentView = new AboutTournamentWidget(_app);
         addChild(this._aboutTournamentView);
         this._aboutTournamentView.setVisible(false);
         _boxContainer = this._tournamentListView.TournamentContainer;
         _boxContainer.visible = false;
         _loadingClip = this._tournamentListView.loadingClip;
         _loadingClip.visible = true;
         this._buttonLeft = new GenericButtonClip(_app,this._tournamentListView.btnLeft,true);
         this._buttonLeft.setPress(this.leftPress);
         this._buttonLeft.setRollOut(this.updateAllButtonState);
         this._buttonLeft.clipListener.gotoAndStop("up");
         this._buttonRight = new GenericButtonClip(_app,this._tournamentListView.btnRight,true);
         this._buttonRight.setPress(this.rightPress);
         this._buttonRight.setRollOut(this.updateAllButtonState);
         this._buttonRight.clipListener.gotoAndStop("up");
         this._buttonHistory = new GenericButtonClip(_app,this._tournamentListView.ButtonHistory,true);
         this._buttonHistory.setRelease(this.historyPress);
         this._buttonHistory.setRollOut(this.updateAllButtonState);
         this._buttonHistory.clipListener.gotoAndStop("up");
         this._buttonAbout = new GenericButtonClip(_app,this._tournamentListView.Btn_WhatsNew,true);
         this._buttonAbout.setRelease(this.whatsNewPress);
         this._buttonAbout.setRollOut(this.updateAllButtonState);
         this._buttonHistory.clipListener.gotoAndStop("up");
         this._buttonRefresh = new GenericButtonClip(_app,this._tournamentListView.refresh_btn,true);
         this._buttonRefresh.setRelease(this.refreshButtonPressed);
         this._tournamentListView.refresh_btn.visible = false;
         this._direction = 0;
         this.update();
      }
      
      public function setupInfoView() : void
      {
         this._tournamentInfoView = _app.tournamentInfoView;
         this._tournamentInfoView.setVisibility(false);
         this._tournamnetHistoryWidget.setupInfoView();
      }
      
      public function buildList() : void
      {
         if(_app.sessionData.tournamentController.IsAvailable())
         {
            this.createList();
         }
         else if(_app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT))
         {
            _loadingClip.visible = true;
            this._checkForAvailability = true;
         }
         else
         {
            this.createList();
         }
      }
      
      private function createList() : void
      {
         var _loc4_:int = 0;
         var _loc5_:TournamentRuntimeEntity = null;
         var _loc6_:UserTournamentProgress = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc10_:TournamentMainMenuListBox = null;
         this._checkForAvailability = false;
         this.clear();
         this.END_X = this.START_X;
         this._currentLeftBoxIndex = 0;
         var _loc1_:TournamentRuntimeEntityManager = _app.sessionData.tournamentController.RuntimeEntityManger;
         var _loc2_:int = _loc1_.getAllEntities().length;
         var _loc3_:Vector.<String> = new Vector.<String>();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _loc1_.getTournamentByIndex(_loc4_);
            _loc6_ = _app.sessionData.tournamentController.UserProgressManager.getUserProgress(_loc5_.Data.Id);
            if(_loc5_.IsRunning())
            {
               _loc3_.push(_loc5_.Id);
            }
            else
            {
               _loc7_ = true;
               if(_loc5_.IsComputingResults())
               {
                  _loc7_ = false;
                  if(_loc6_ != null)
                  {
                     _loc3_.push(_loc5_.Id);
                  }
                  else
                  {
                     ErrorReporting.sendError(ErrorReporting.ERROR_LEVEL_INFO,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"state is computing results but there\'s no entry in user progress. Tournament Id: " + _loc5_.Id);
                  }
               }
               if(_loc5_.HasEnded())
               {
                  _loc7_ = false;
                  if(_loc6_ != null && _loc5_.IsUserEligibleForReward() && !_loc6_.hasClaimed)
                  {
                     _loc3_.push(_loc5_.Id);
                  }
               }
               if(_loc7_)
               {
                  ErrorReporting.sendError(ErrorReporting.ERROR_LEVEL_INFO,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"tournament is not running, not in computing state and has not ended. Tournament Id: " + _loc5_.Id);
               }
            }
            _loc4_++;
         }
         if(_loc3_.length == 0)
         {
            this._tournamentListView.txtNotAvailable.visible = true;
            _loc9_ = !!(_loc8_ = _app.sessionData.tournamentController.NetworkStatus == TournamentCommonInfo.NETWORK_ERROR_SERVER_ERROR) ? "Couldn\'t retrieve championship" : "There are no Contests running right now. Please check back soon.";
            this._tournamentListView.txtNotAvailable.visible = true;
            this._tournamentListView.txtNotAvailable.text = _loc9_;
            if(_loc8_)
            {
               this._tournamentListView.refresh_btn.visible = true;
            }
            this._buttonLeft.SetDisabled(true);
            this._buttonRight.SetDisabled(true);
            if(!_app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT))
            {
               this._buttonHistory.SetDisabled(true);
               this._buttonAbout.SetDisabled(true);
               this._tournamentListView.txtNotAvailable.text = "There are no Contests running right now. Please check back soon.";
            }
         }
         else
         {
            this._tournamentListView.txtNotAvailable.visible = false;
            this.setSortKeysForTournaments(_loc3_);
            _loc3_.sort(this.SortTournaments);
            _loc4_ = _loc3_.length - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = _loc1_.getTournamentById(_loc3_[_loc4_]);
               (_loc10_ = new TournamentMainMenuListBox(_app,false)).setData(_loc5_);
               _loc10_.setOnBgPressed(this.showInfoOrRewardScreen);
               _loc10_.x = this.END_X;
               _loc10_.y = 0;
               _boxContainer.addChild(_loc10_);
               this.BOX_WIDTH = _loc10_.TournamentListBoxObject.TournamentbgClip.Background.width + 7;
               this.END_X += this.BOX_WIDTH;
               this._listBoxArray.push(_loc10_);
               _loc4_--;
            }
            this._maxRightBoxIndex = _loc3_.length - MAX_SCREEN_BOXES;
         }
         _boxContainer.visible = true;
         _loc3_ = null;
         _loadingClip.visible = false;
         this.update();
      }
      
      private function setSortKeysForTournaments(param1:Vector.<String>) : void
      {
         var _loc2_:UserTournamentProgress = null;
         var _loc3_:TournamentRuntimeEntity = null;
         var _loc4_:TournamentRuntimeEntityManager = null;
         var _loc5_:UserTournamentProgressManager = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         if(param1 != null)
         {
            _loc2_ = null;
            _loc3_ = null;
            _loc4_ = _app.sessionData.tournamentController.RuntimeEntityManger;
            _loc5_ = _app.sessionData.tournamentController.UserProgressManager;
            if(_loc4_ != null)
            {
               _loc6_ = param1.length;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  _loc8_ = param1[_loc7_];
                  _loc3_ = _loc4_.getTournamentById(_loc8_);
                  _loc2_ = _loc5_.getUserProgress(_loc8_);
                  if(_loc3_.Status == TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
                  {
                     _loc3_.sortKey = TournamentCommonInfo.COMPUTING_RESULTS_STATE_KEY;
                  }
                  else if(_loc3_.Status == TournamentCommonInfo.TOUR_STATUS_NOT_STARTED)
                  {
                     _loc3_.sortKey = TournamentCommonInfo.NOT_PARTICIPATED_STATE_KEY;
                  }
                  else if(_loc3_.Status == TournamentCommonInfo.TOUR_STATUS_ENDED)
                  {
                     if(_loc2_ != null && !_loc2_.hasClaimed)
                     {
                        _loc3_.sortKey = TournamentCommonInfo.CLAIM_REWARD_STATE_KEY;
                     }
                  }
                  else if(_loc3_.Status == TournamentCommonInfo.TOUR_STATUS_RUNNING)
                  {
                     if(_app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(_loc8_))
                     {
                        _loc3_.sortKey = TournamentCommonInfo.PARTICIPATED_STATE_KEY;
                     }
                     else
                     {
                        _loc3_.sortKey = TournamentCommonInfo.NOT_PARTICIPATED_STATE_KEY;
                     }
                  }
                  _loc3_.sortKey += _loc3_.Data.Category;
                  _loc7_++;
               }
            }
         }
      }
      
      private function rightPress() : void
      {
         this._direction = 1;
         this._currentLeftBoxIndex += MAX_SCREEN_BOXES;
         if(this._currentLeftBoxIndex > this._maxRightBoxIndex)
         {
            this._currentLeftBoxIndex = this._maxRightBoxIndex;
         }
         this.update();
      }
      
      private function leftPress() : void
      {
         this._direction = -1;
         this._currentLeftBoxIndex -= MAX_SCREEN_BOXES;
         if(this._currentLeftBoxIndex < 0)
         {
            this._currentLeftBoxIndex = 0;
         }
         this.update();
      }
      
      private function historyPress() : void
      {
         this._tournamentListView.visible = false;
         this._tournamnetHistoryWidget.buildList();
         this._tournamnetHistoryWidget.setVisibility(true);
         _app.network.SendUIMetrics("Tournaments History","TournamentsLobby","");
      }
      
      public function forceCloseHistory() : void
      {
         this._tournamnetHistoryWidget.setVisibility(false);
      }
      
      private function whatsNewPress() : void
      {
         this._aboutTournamentView.setVisible(true);
         this._aboutTournamentView.setVisiblityOfGetStartedButton(false);
         this._aboutTournamentView.setVisiblityOfCloseButton(true);
         _app.network.SendUIMetrics("Tournaments Help","MainMenu","");
      }
      
      private function refreshButtonPressed() : void
      {
         this._tournamentListView.refresh_btn.visible = false;
         this._checkForAvailability = true;
         this._tournamentListView.txtNotAvailable.visible = false;
         _app.sessionData.tournamentController.fetchConfig();
         _loadingClip.visible = true;
      }
      
      public function showWhatsNewScreenForFTUE() : void
      {
         this._aboutTournamentView.setVisible(true);
         this._aboutTournamentView.setVisiblityOfGetStartedButton(true);
         this._aboutTournamentView.setVisiblityOfCloseButton(false);
      }
      
      private function onHistoryClose() : void
      {
         this._tournamentListView.visible = true;
      }
      
      public function setVisibility(param1:Boolean) : void
      {
         visible = param1;
         this._tournamentListView.visible = visible;
      }
      
      public function update() : void
      {
         Tweener.removeTweens(_boxContainer);
         var _loc1_:Number = -(this._currentLeftBoxIndex * this.BOX_WIDTH);
         Tweener.addTween(_boxContainer,{
            "x":_loc1_,
            "time":0.5
         });
         this.updateAllButtonState();
      }
      
      public function updateAllButtonState() : void
      {
         if(this._listBoxArray.length <= MAX_SCREEN_BOXES)
         {
            this._buttonLeft.SetDisabled(true);
            this._buttonRight.SetDisabled(true);
            if(!_app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_TOURNAMENT))
            {
               this._buttonHistory.SetDisabled(true);
               this._buttonAbout.SetDisabled(true);
            }
            return;
         }
         this._buttonLeft.SetDisabled(false);
         this._buttonRight.SetDisabled(false);
         this._buttonHistory.SetDisabled(false);
         this._buttonAbout.SetDisabled(false);
         if(this._currentLeftBoxIndex == 0)
         {
            this._buttonLeft.SetDisabled(true);
            this._buttonRight.SetDisabled(false);
         }
         else if(this._currentLeftBoxIndex == this._maxRightBoxIndex)
         {
            this._buttonLeft.SetDisabled(false);
            this._buttonRight.SetDisabled(true);
         }
         else
         {
            this._buttonLeft.SetDisabled(false);
            this._buttonRight.SetDisabled(false);
         }
         this._buttonHistory.SetDisabled(false);
         this._buttonAbout.SetDisabled(false);
      }
      
      public function timerUpdate(param1:TimerEvent) : void
      {
         var _loc2_:* = false;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(this._checkForAvailability)
         {
            if(_app.sessionData.tournamentController.IsAvailable())
            {
               this.createList();
               _loadingClip.visible = false;
            }
            else if(_app.sessionData.tournamentController.FetchStatus == TournamentCommonInfo.TOUR_CATALOGUE_FETCH_FAILED)
            {
               this._tournamentListView.txtNotAvailable.visible = true;
               _loc2_ = _app.sessionData.tournamentController.NetworkStatus == TournamentCommonInfo.NETWORK_ERROR_SERVER_ERROR;
               _loc3_ = !!_loc2_ ? "Couldn\'t retrieve championship" : "There are no Contests running right now. Please check back soon.";
               this._tournamentListView.txtNotAvailable.visible = true;
               this._tournamentListView.txtNotAvailable.text = _loc3_;
               if(_loc2_)
               {
                  this._tournamentListView.refresh_btn.visible = true;
               }
               this._tournamentListView.txtNotAvailable.text = _loc3_;
               this._buttonLeft.SetDisabled(true);
               this._buttonRight.SetDisabled(true);
               _loadingClip.visible = false;
            }
         }
         if(_boxContainer.visible)
         {
            _loc4_ = 0;
            while(_loc4_ < this._listBoxArray.length)
            {
               this._listBoxArray[_loc4_].update();
               _loc4_++;
            }
         }
      }
      
      public function showInfoOrRewardScreen(param1:String) : void
      {
         var _loc3_:UserTournamentProgress = null;
         var _loc2_:TournamentRuntimeEntity = _app.sessionData.tournamentController.RuntimeEntityManger.getTournamentById(param1);
         if(_loc2_.IsUserEligibleForReward())
         {
            this._tournamentInfoView.setData(_loc2_);
            this._tournamentRewardScreen.show(_loc2_,this.onRewardAnimationFinished);
            _app.network.SendUIMetrics("Reward Claim","TournamentsLobby",param1);
         }
         else
         {
            this._tournamentInfoView.visible = true;
            this._tournamentInfoView.setData(_loc2_);
            _loc3_ = _app.sessionData.tournamentController.UserProgressManager.getUserProgress(param1);
            if(_loc3_ == null)
            {
               this._tournamentInfoView.Show(TournamentInfoWidget.DETAILS_TAB,TournamentCommonInfo.FROM_LOBBY);
               _app.network.SendUIMetrics("Tournament Select","TournamentsLobby",param1);
            }
            else
            {
               this._tournamentInfoView.Show(TournamentInfoWidget.LEADERBOARD_TAB,TournamentCommonInfo.FROM_LOBBY);
               _app.network.SendUIMetrics("Tournaments Leaderboard","TournamentsLobby",param1);
            }
         }
      }
      
      public function onRewardAnimationFinished(param1:Boolean) : void
      {
         if(param1)
         {
            this.buildList();
            this._tournamentInfoView.Show(TournamentInfoWidget.LEADERBOARD_TAB,TournamentCommonInfo.FROM_LOBBY);
         }
         else
         {
            this._tournamentListView.visible = true;
            this._tournamentInfoView.setVisibility(false);
            this._tournamentRewardScreen.hide();
         }
      }
      
      public function get tournamentInfoScreen() : TournamentInfoWidget
      {
         return this._tournamentInfoView;
      }
      
      public function SortTournaments(param1:String, param2:String) : int
      {
         if(param1 == null || param2 == null)
         {
            return 1;
         }
         if(param1.length == 0 && param2.length == 0)
         {
            return 1;
         }
         var _loc3_:TournamentRuntimeEntityManager = _app.sessionData.tournamentController.RuntimeEntityManger;
         var _loc4_:TournamentRuntimeEntity = _loc3_.getTournamentById(param1);
         var _loc5_:TournamentRuntimeEntity = _loc3_.getTournamentById(param2);
         if(_loc4_ == null && _loc5_ == null)
         {
            return 1;
         }
         if(_loc5_ == null)
         {
            return 1;
         }
         if(_loc4_ == null)
         {
            return 0;
         }
         if(_loc4_.sortKey > _loc5_.sortKey)
         {
            return 1;
         }
         if(_loc4_.sortKey < _loc5_.sortKey)
         {
            return -1;
         }
         if(_loc4_.sortKey == _loc5_.sortKey)
         {
            if(_loc4_.Data.ExpiryTime < _loc5_.Data.ExpiryTime)
            {
               return 1;
            }
            return -1;
         }
         return 0;
      }
   }
}
