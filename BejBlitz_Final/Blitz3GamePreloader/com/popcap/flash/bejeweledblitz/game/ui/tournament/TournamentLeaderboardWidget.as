package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentLeaderboardData;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.ITournamentEvent;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.games.blitz3.leaderboard.TournamentLeaderboardViewWidget;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TournamentLeaderboardWidget extends MovieClip implements ITournamentEvent
   {
      
      private static const MAX_SCREEN_BOXES:Number = 4;
       
      
      public var BOX_HEIGHT:Number;
      
      public var START_Y:Number = 5;
      
      public var END_Y:Number = 0;
      
      private var _app:Blitz3Game;
      
      private var _tournament:TournamentRuntimeEntity;
      
      private var _leaderboardView:TournamentLeaderboardViewWidget;
      
      private var _buttonUp:GenericButtonClip;
      
      private var _buttonDown:GenericButtonClip;
      
      private var _boxContainer:MovieClip;
      
      private var _currentTopBoxIndex:int = 0;
      
      private var _maxBottomBoxIndex:int = 0;
      
      private var _listBoxArray:Vector.<TournamentLeaderboardListBox>;
      
      private var _timer:Timer;
      
      private var _lastFetchTime:Number;
      
      private var _refreshTimeDuration:Number;
      
      private var _calibrationTimer:Timer;
      
      private var _tournamentTieBreakerAnim:TournamentTieBreakerAnimation = null;
      
      private var _leaderboardShowCalled:Boolean;
      
      private var _leaderboardFetchPending:Boolean;
      
      public function TournamentLeaderboardWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._buttonDown = null;
         this._buttonUp = null;
         this._boxContainer = null;
         this._listBoxArray = new Vector.<TournamentLeaderboardListBox>();
         this._tournament = null;
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.timerUpdate);
         this._calibrationTimer = new Timer(1000);
         this._calibrationTimer.addEventListener(TimerEvent.TIMER,this.calibrationTimerUpdate);
         this._lastFetchTime = 0;
         this._refreshTimeDuration = this._app.sessionData.tournamentController.UserProgressManager.refreshTimeDuration;
         this._leaderboardShowCalled = false;
         this._leaderboardFetchPending = false;
      }
      
      public function clear() : void
      {
         this._listBoxArray.splice(0,this._listBoxArray.length);
         Utils.removeAllChildrenFrom(this._boxContainer);
      }
      
      public function reset() : void
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.timerUpdate);
         this._tournament = null;
      }
      
      public function init(param1:TournamentLeaderboardViewWidget) : void
      {
         this._leaderboardView = param1;
         this._leaderboardView.TieBreakerAnimation.visible = false;
         if(this._buttonUp == null)
         {
            this._buttonUp = new GenericButtonClip(this._app,this._leaderboardView.btnUp,false);
            this._buttonUp.setRelease(this.upRelease);
            this._buttonUp.setRollOut(this.updateScrollButtonState);
            this._buttonUp.activate();
         }
         if(this._buttonDown == null)
         {
            this._buttonDown = new GenericButtonClip(this._app,this._leaderboardView.btnDown,false);
            this._buttonDown.setRelease(this.downRelease);
            this._buttonDown.setRollOut(this.updateScrollButtonState);
            this._buttonDown.activate();
         }
         if(this._tournamentTieBreakerAnim == null)
         {
            this._tournamentTieBreakerAnim = new TournamentTieBreakerAnimation(this._app,this._leaderboardView.TieBreakerAnimation);
            this._tournamentTieBreakerAnim.Init();
         }
         this._boxContainer = this._leaderboardView.TournamentLBItemContainer;
         this._boxContainer.visible = false;
         this._leaderboardView.Info.visible = false;
      }
      
      public function updateData(param1:TournamentRuntimeEntity) : void
      {
         this._tournament = param1;
         this._tournament.addEventListener(this);
         var _loc2_:Boolean = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(this._tournament.Id);
         if(_loc2_)
         {
            if(!this._tournament.IsComputingResults())
            {
               this.fetchLeaderboardData();
            }
            else
            {
               this.activateResultCalibratingState();
            }
         }
         else
         {
            this.showUserNotJoinedInfo();
         }
      }
      
      private function showUserNotJoinedInfo() : void
      {
         if(this._tournamentTieBreakerAnim != null)
         {
            this._tournamentTieBreakerAnim.resetTieBreaker();
         }
         if(this._tournament != null && this._tournament.Status >= TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
         {
            this._leaderboardView.Info.text = "You haven\'t generated a leaderboard in this contest.";
         }
         else
         {
            this._leaderboardView.Info.text = "You haven\'t generated a leaderboard in this contest yet.\nPlay a game in this contest to generate your score on the leaderboard.";
         }
         this._buttonUp.SetDisabled(true);
         this._buttonDown.SetDisabled(true);
         this._leaderboardView.Info.visible = true;
         this._boxContainer.visible = false;
         this._leaderboardView.loadingClip.visible = false;
      }
      
      private function fetchLeaderboardData(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc4_:Date = null;
         var _loc3_:Boolean = this._app.sessionData.tournamentController.LeaderboardController.getData(this._tournament.Id);
         if(!_loc3_ || param1)
         {
            this._timer.stop();
            _loc4_ = new Date();
            this._lastFetchTime = _loc4_.getTime().valueOf() / 1000;
            if(param2)
            {
               this._app.sessionData.tournamentController.LeaderboardController.setOnFinished(this.handleLBFetchAndSyncBoosts);
            }
            else
            {
               this._app.sessionData.tournamentController.LeaderboardController.setOnFinished(this.onLeaderboardFetched);
            }
            this._app.sessionData.tournamentController.LeaderboardController.fetchLeaderboard(this._tournament);
            this._leaderboardView.loadingClip.visible = true;
            this._leaderboardFetchPending = true;
         }
         else
         {
            this.onLeaderboardFetched(true);
         }
      }
      
      private function handleLBFetchAndSyncBoosts(param1:Boolean) : void
      {
         this.onLeaderboardFetched(false);
         this._app.network.syncBoostLevels();
      }
      
      private function onLeaderboardFetched(param1:Boolean) : void
      {
         if(this._leaderboardShowCalled)
         {
            this._boxContainer.visible = false;
         }
         if(this._app.network.isCookieExpired("tieBreaker") && this._leaderboardShowCalled)
         {
            this._leaderboardView.loadingClip.visible = false;
            this.setupTieBreakerInfo();
            this._leaderboardShowCalled = false;
         }
         else
         {
            this.buildLBList();
         }
         this._leaderboardFetchPending = false;
      }
      
      public function buildLBList(param1:Event = null) : void
      {
         this.buildList();
         this._leaderboardView.loadingClip.visible = false;
         this._timer.start();
         this._calibrationTimer.stop();
         if(param1 != null)
         {
            this._app.bjbEventDispatcher.removeEventListener(TournamentTieBreakerAnimation.TieBreakerAnimEnded,this.buildLBList);
         }
      }
      
      private function setupTieBreakerInfo() : void
      {
         if(this._tournament.Data.Objective.Type == TournamentCommonInfo.OBJECTIVE_SCORE)
         {
            if(this._tournamentTieBreakerAnim != null)
            {
               this._tournamentTieBreakerAnim.resetTieBreaker();
            }
            this.buildLBList();
            return;
         }
         if(this._tournamentTieBreakerAnim != null)
         {
            this._tournamentTieBreakerAnim.resetTieBreaker();
         }
         this._leaderboardView.Info.visible = false;
         var _loc1_:TournamentLeaderboardData = this._app.sessionData.tournamentController.LeaderboardController.getData(this._tournament.Data.Id);
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:PlayerData = _loc1_.CurrentUser;
         if(_loc1_.UserList.length <= 0)
         {
            return;
         }
         var _loc3_:PlayerData = _loc1_.getPlayerByRank(_loc2_.rank - 1);
         var _loc4_:PlayerData = _loc1_.getPlayerByRank(_loc2_.rank + 1);
         var _loc5_:PlayerData = _loc3_;
         var _loc6_:Boolean = false;
         if(_loc5_ != null && _loc5_.currentChampionshipData.isTie)
         {
            if(_loc2_.currentChampionshipData.score == _loc5_.currentChampionshipData.score)
            {
               _loc6_ = true;
            }
         }
         if(!_loc6_)
         {
            if((_loc5_ = _loc4_) != null && _loc5_.currentChampionshipData.isTie)
            {
               if(_loc2_.currentChampionshipData.score == _loc5_.currentChampionshipData.score)
               {
                  _loc6_ = true;
               }
            }
         }
         if(_loc6_ && this._tournamentTieBreakerAnim.canShow(_loc2_,_loc5_))
         {
            this._tournamentTieBreakerAnim.showAnimation();
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(true);
            this._app.bjbEventDispatcher.addEventListener(TournamentTieBreakerAnimation.TieBreakerAnimEnded,this.buildLBList);
         }
         else
         {
            this.buildLBList();
         }
      }
      
      public function buildList() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TournamentLeaderboardListBox = null;
         this.END_Y = this.START_Y;
         this._currentTopBoxIndex = 0;
         var _loc1_:String = this._app.sessionData.userData.GetFUID();
         var _loc2_:String = this._tournament.Data.Id;
         var _loc3_:TournamentLeaderboardData = this._app.sessionData.tournamentController.LeaderboardController.getData(_loc2_);
         var _loc4_:int = this._listBoxArray.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            this._listBoxArray[_loc5_].visible = false;
            _loc5_++;
         }
         if(_loc3_ != null)
         {
            _loc6_ = _loc3_.UserList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = null;
               if(_loc5_ < _loc4_)
               {
                  (_loc7_ = this._listBoxArray[_loc5_]).visible = true;
               }
               else
               {
                  _loc7_ = new TournamentLeaderboardListBox(this._app);
                  this._listBoxArray.push(_loc7_);
                  this._boxContainer.addChild(_loc7_);
               }
               _loc7_.setData(_loc3_.UserList[_loc5_],_loc5_ + 1,this._tournament);
               _loc7_.x = 3;
               _loc7_.y = this.END_Y;
               this.BOX_HEIGHT = _loc7_.ListBoxObject.height;
               this.END_Y += this.BOX_HEIGHT;
               _loc5_++;
            }
            if(_loc6_ == 0)
            {
               this._buttonUp.SetDisabled(true);
               this._buttonDown.SetDisabled(true);
               this._leaderboardView.Info.visible = true;
               this._boxContainer.visible = false;
            }
            else
            {
               this._leaderboardView.Info.visible = false;
               this._boxContainer.visible = true;
            }
            this._maxBottomBoxIndex = _loc6_ - MAX_SCREEN_BOXES;
            this._boxContainer.visible = true;
            this.scrollToPlayer();
         }
         else
         {
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(true);
            this._leaderboardView.Info.visible = true;
            this._boxContainer.visible = false;
         }
      }
      
      private function downRelease() : void
      {
         this._currentTopBoxIndex += MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex > this._maxBottomBoxIndex)
         {
            this._currentTopBoxIndex = this._maxBottomBoxIndex;
         }
         this.update();
      }
      
      private function upRelease() : void
      {
         this._currentTopBoxIndex -= MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex < 0)
         {
            this._currentTopBoxIndex = 0;
         }
         this.update();
      }
      
      public function setVisibility(param1:Boolean) : void
      {
         visible = param1;
         this._leaderboardShowCalled = param1;
      }
      
      public function update() : void
      {
         Tweener.removeTweens(this._boxContainer);
         var _loc1_:Number = -(this._currentTopBoxIndex * this.BOX_HEIGHT);
         Tweener.addTween(this._boxContainer,{
            "y":_loc1_,
            "time":0.5
         });
         this.updateScrollButtonState();
      }
      
      public function updateScrollButtonState() : void
      {
         if(this._listBoxArray.length <= MAX_SCREEN_BOXES)
         {
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(true);
            return;
         }
         if(this._currentTopBoxIndex == this._maxBottomBoxIndex)
         {
            this._buttonUp.SetDisabled(false);
            this._buttonDown.SetDisabled(true);
         }
         else if(this._currentTopBoxIndex == 0)
         {
            this._buttonUp.SetDisabled(true);
            this._buttonDown.SetDisabled(false);
         }
         else
         {
            this._buttonUp.SetDisabled(false);
            this._buttonDown.SetDisabled(false);
         }
      }
      
      public function timerUpdate(param1:TimerEvent) : void
      {
         var _loc2_:Date = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(visible)
         {
            _loc2_ = new Date();
            _loc3_ = _loc2_.getTime().valueOf() / 1000;
            _loc4_ = this._lastFetchTime + this._refreshTimeDuration;
            if(_loc3_ >= _loc4_)
            {
               this.fetchLeaderboardData(true);
            }
         }
      }
      
      public function calibrationTimerUpdate(param1:TimerEvent) : void
      {
         var _loc3_:Date = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc2_:Boolean = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(this._tournament.Id);
         if(_loc2_)
         {
            _loc3_ = new Date();
            _loc4_ = _loc3_.getTime().valueOf() / 1000;
            _loc6_ = (_loc5_ = this._tournament.getExpectedResultsAvailableTime()) - _loc4_;
            _loc7_ = Utils.getHourStringFromSeconds(_loc6_);
            _loc8_ = "Your results are loading.";
            if(_loc6_ > 0)
            {
               _loc8_ += "\nThis should take " + _loc7_;
            }
            this._leaderboardView.Info.text = _loc8_;
         }
         else
         {
            this.showUserNotJoinedInfo();
         }
      }
      
      public function onStatusChanged(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         if(param2 != TournamentCommonInfo.TOUR_STATUS_RUNNING)
         {
            _loc3_ = this._app.sessionData.tournamentController.UserProgressManager && this._app.sessionData.tournamentController.UserProgressManager.hasUserJoinedTournament(this._tournament.Id);
            if(_loc3_)
            {
               if(param2 == TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
               {
                  this.clear();
                  this.activateResultCalibratingState();
               }
               if(param2 == TournamentCommonInfo.TOUR_STATUS_ENDED && param1 == TournamentCommonInfo.TOUR_STATUS_COMPUTING_RESULTS)
               {
                  this._leaderboardView.Info.visible = false;
                  this.fetchLeaderboardData(true,true);
               }
            }
            else
            {
               this.showUserNotJoinedInfo();
            }
         }
      }
      
      public function onRankChanged(param1:int, param2:int) : void
      {
         if(!this._leaderboardFetchPending)
         {
            this.fetchLeaderboardData(true,true);
         }
      }
      
      private function scrollToPlayer() : void
      {
         var _loc1_:String = this._tournament.Data.Id;
         var _loc2_:TournamentLeaderboardData = this._app.sessionData.tournamentController.LeaderboardController.getData(_loc1_);
         var _loc3_:int = _loc2_.getCurrentPlayerIndex();
         if(_loc3_ >= MAX_SCREEN_BOXES)
         {
            this._currentTopBoxIndex = _loc3_ - Math.floor(MAX_SCREEN_BOXES / 2);
         }
         this.update();
      }
      
      private function activateResultCalibratingState() : void
      {
         this._calibrationTimer.start();
         this._leaderboardView.Info.visible = true;
         this._boxContainer.visible = false;
         this._leaderboardView.loadingClip.visible = false;
         this._leaderboardView.Info.text = "Your results are loading..";
         this.update();
      }
   }
}
