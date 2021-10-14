package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.InGameLeaderboardViewWidget;
   
   public class InGameLeaderboardWidget extends LeaderboardWidget implements IFeatureManagerHandler, ILeaderboardUpdateEvents
   {
      
      private static const _MAX_SCREEN_BOXES:Number = 6;
      
      public static const BOX_HEIGHT:Number = 39;
      
      public static const PAGINATION_HEIGHT:Number = BOX_HEIGHT * _MAX_SCREEN_BOXES;
      
      public static const START_Y:Number = 206;
       
      
      private var _currentPageIndex:int = 0;
      
      private var _listBoxArray:Vector.<InGameLeaderboardListBox>;
      
      private var _minY:Number = 0;
      
      private var _currentTopBoxIndex:int = 0;
      
      private var _maxTopBoxIndex:int = 0;
      
      private var _isBtnUpActive:Boolean = false;
      
      private var _isBtnDownActive:Boolean = false;
      
      private var _btnRefreshTournament:GenericButtonClip;
      
      private var _btnRefreshWhoops:GenericButtonClip;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      private var _leaderboardviewWidget:InGameLeaderboardViewWidget;
      
      public function InGameLeaderboardWidget(param1:Blitz3Game)
      {
         super(param1);
         this._leaderboardviewWidget = new InGameLeaderboardViewWidget();
         this._listBoxArray = new Vector.<InGameLeaderboardListBox>();
         _stats = new LeaderboardStats(_app);
         this._leaderboardviewWidget.btnRefreshTournament.visible = false;
         this._btnRefreshTournament = new GenericButtonClip(_app,this._leaderboardviewWidget.btnRefreshTournament);
         this._btnRefreshTournament.setPress(this.refreshTournamentPress);
         this._leaderboardviewWidget.btnRefreshWhoops.visible = false;
         this._btnRefreshWhoops = new GenericButtonClip(_app,this._leaderboardviewWidget.btnRefreshWhoops);
         this._btnRefreshWhoops.setPress(this.refreshWhoopsPress);
         this._btnUp = new GenericButtonClip(_app,this._leaderboardviewWidget.btnUp,true);
         this._btnUp.setPress(this.upPress);
         this._btnUp.clipListener.gotoAndStop("disable");
         this._btnDown = new GenericButtonClip(_app,this._leaderboardviewWidget.btnDown,true);
         this._btnDown.setPress(this.downPress);
         this._btnDown.clipListener.gotoAndStop("disable");
         _boxContainer = this._leaderboardviewWidget.leaderboardContainer;
         _boxContainer.visible = false;
         updater = new DataUpdater(_app,this);
         pageInterface = new PageInterface(_app);
         pokeHandler = new PokeHandler(_app,this);
         rivalHandler = new RivalHandler(_app,this);
         addChild(this._leaderboardviewWidget);
         _app.AddLBDataHandler(this);
         this._leaderboardviewWidget.btnRefreshWhoops.visible = false;
         this._leaderboardviewWidget.btnRefreshTournament.visible = false;
         this._leaderboardviewWidget.loadingClip.visible = false;
      }
      
      override public function getLeaderBoardEntry(param1:PlayerData) : LeaderboardListBox
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._listBoxArray.length)
         {
            if(this._listBoxArray[_loc2_].playerData == param1)
            {
               return this._listBoxArray[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      override public function updatePokeAndRivalStatusForAllPlayers() : void
      {
         var _loc1_:int = this._listBoxArray.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._listBoxArray[_loc2_].validatePokeAndFlagButtons(getCurrentPlayerData().curTourneyData.score);
            _loc2_++;
         }
      }
      
      override public function GetCurrentRivalCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = this._listBoxArray.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._listBoxArray[_loc3_].playerData.isFlaggedByCurrentUser)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function refreshTournamentPress() : void
      {
         this._leaderboardviewWidget.loadingClip.visible = true;
         this._leaderboardviewWidget.btnRefreshTournament.visible = false;
         pageInterface.RefreshPage();
      }
      
      private function refreshWhoopsPress() : void
      {
         this._leaderboardviewWidget.loadingClip.visible = true;
         this._leaderboardviewWidget.btnRefreshWhoops.visible = false;
         updater.RequestBasicXML();
      }
      
      public function Init() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         currentPlayerFUID = _app.sessionData.userData.GetFUID();
         _app.sessionData.featureManager.AddHandler(this);
         if(!_app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_LEADERBOARD_BASIC))
         {
            this.Hide();
         }
         if(!_initialized)
         {
            _loc1_ = _app.network.ExternalCall(Blitz3Network.JS_GET_NON_APP_FRIENDS);
            _friendData = new Array();
            for each(_loc2_ in _loc1_)
            {
               _friendData.push(_loc2_);
            }
            _initialized = true;
         }
      }
      
      public function clearList() : void
      {
         this._currentTopBoxIndex = 0;
         this._maxTopBoxIndex = 0;
         _boxContainer.y = 0;
         this._minY = 0;
         this._listBoxArray.splice(0,this._listBoxArray.length);
         while(_boxContainer.numChildren > 0)
         {
            _boxContainer.removeChildAt(0);
         }
         this._listBoxArray = new Vector.<InGameLeaderboardListBox>();
      }
      
      public function showLeaderboardRefresh() : void
      {
         if(this._leaderboardviewWidget.btnRefreshTournament.visible)
         {
            this._leaderboardviewWidget.btnRefreshTournament.visible = false;
         }
         this._leaderboardviewWidget.loadingClip.visible = false;
         _boxContainer.visible = false;
         this._leaderboardviewWidget.btnRefreshWhoops.visible = true;
      }
      
      public function showTourneyRefresh() : void
      {
         if(this._leaderboardviewWidget.btnRefreshWhoops.visible)
         {
            this._leaderboardviewWidget.btnRefreshWhoops.visible = false;
         }
         this._leaderboardviewWidget.loadingClip.visible = false;
         _boxContainer.visible = false;
         this._leaderboardviewWidget.btnRefreshTournament.visible = true;
      }
      
      public function forceRefresh() : void
      {
         if(this._leaderboardviewWidget.btnRefreshWhoops.visible)
         {
            this.refreshWhoopsPress();
         }
      }
      
      public function Show() : void
      {
         if(_app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_LEADERBOARD_BASIC))
         {
            visible = true;
            mouseChildren = true;
         }
         if(_initialized)
         {
            handleInviteData(_friendData[Math.floor(Math.random() * _friendData.length - 1)]);
         }
      }
      
      public function Hide() : void
      {
         visible = false;
         mouseChildren = false;
      }
      
      public function HandleBasicLoadComplete() : void
      {
         if(_isLoaded)
         {
            return;
         }
         _isLoaded = true;
         var _loc1_:PlayerData = PlayersData.getPlayerData(currentPlayerFUID);
         if(_loc1_)
         {
            _currentPlayerHighScore = _loc1_.curTourneyData.score;
         }
         this.buildList();
         this._leaderboardviewWidget.loadingClip.visible = false;
         _boxContainer.visible = true;
      }
      
      public function HandleScoreUpdated(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         PlayersData.UpdateScore(currentPlayerFUID,param1);
         if(param1 > _currentPlayerHighScore)
         {
            _currentPlayerHighScore = param1;
            if(this._listBoxArray != null)
            {
               _loc2_ = this._listBoxArray.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  this._listBoxArray[_loc3_].update();
                  _loc3_++;
               }
            }
         }
         this.scrollToPlayer();
      }
      
      public function HandleFeatureEnabled(param1:String) : void
      {
         if(param1 == FeatureManager.FEATURE_LEADERBOARD_BASIC)
         {
            this.Show();
         }
         if(param1 == FeatureManager.FEATURE_LEADERBOARD_FULL)
         {
            PlayersData.addCachedFriends();
            this.buildList();
         }
      }
      
      private function buildList() : void
      {
         var _loc2_:PlayerData = null;
         var _loc3_:InGameLeaderboardListBox = null;
         this.clearList();
         var _loc1_:Vector.<String> = PlayersData.GetList();
         var _loc4_:Number = _boxContainer.templateClip.x;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = PlayersData.getPlayerData(_loc1_[_loc5_]);
            _loc3_ = new InGameLeaderboardListBox(_app,_loc2_);
            _loc3_.x = _loc4_;
            _loc3_.y = START_Y + _loc5_ * BOX_HEIGHT;
            this._listBoxArray.push(_loc3_);
            _boxContainer.addChild(_loc3_);
            _loc5_++;
         }
         _boxContainer.templateClip.visible = false;
         this.setBoundaries();
         this.scrollToPlayer();
      }
      
      private function setBoundaries() : void
      {
         if(this._listBoxArray.length > _MAX_SCREEN_BOXES)
         {
            this._minY = -(this._listBoxArray.length - _MAX_SCREEN_BOXES) * BOX_HEIGHT;
            this._maxTopBoxIndex = this._listBoxArray.length - _MAX_SCREEN_BOXES - 1;
         }
         else
         {
            this._minY = 0;
            this._maxTopBoxIndex = 0;
         }
      }
      
      private function upPress() : void
      {
         if(!this._isBtnUpActive)
         {
            return;
         }
         _stats.pagePress(false);
         this._currentTopBoxIndex -= _MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex < 0)
         {
            this._currentTopBoxIndex = 0;
         }
         this.update();
      }
      
      public function downPress() : void
      {
         if(!this._isBtnDownActive)
         {
            return;
         }
         _stats.pagePress(true);
         this._currentTopBoxIndex += _MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex > this._maxTopBoxIndex)
         {
            this._currentTopBoxIndex = this._maxTopBoxIndex;
         }
         this.update();
      }
      
      private function scrollToPlayer() : void
      {
         var _loc1_:int = PlayersData.GetList().indexOf(currentPlayerFUID);
         this._currentTopBoxIndex = _loc1_ - Math.floor(_MAX_SCREEN_BOXES / 2);
         this.update();
      }
      
      private function update() : void
      {
         this.updateTournamentCountdown();
         this.handleArrowButtons();
         this.updateScroll();
      }
      
      private function updateTournamentCountdown() : void
      {
         var _loc1_:String = Utils.getHourStringFromSeconds(tournamentRemainingTimeInSeconds);
         (_app.ui as MainWidgetGame).menu.updateLeaderboardTimerText(_loc1_);
         _loc1_ = "Scores Reset in " + _loc1_;
         this._leaderboardviewWidget.txtReset.htmlText = _loc1_;
      }
      
      private function updateScroll() : void
      {
         Tweener.removeTweens(_boxContainer);
         Tweener.addTween(_boxContainer,{
            "y":-this._currentTopBoxIndex * BOX_HEIGHT,
            "time":0.5
         });
      }
      
      private function handleArrowButtons() : void
      {
         if(this._listBoxArray.length <= _MAX_SCREEN_BOXES)
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
         this._isBtnUpActive = param1;
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
         this._isBtnDownActive = param1;
      }
      
      public function updatePokeAndRivalStatus() : void
      {
         this.updatePokeAndRivalStatusForAllPlayers();
      }
      
      public function validatePokeAndFlagButtonsForPlayer(param1:PlayerData) : void
      {
         var _loc2_:InGameLeaderboardListBox = this.getLeaderBoardEntry(param1) as InGameLeaderboardListBox;
         if(_loc2_ != null)
         {
            _loc2_.validatePokeAndFlagButtons(getCurrentPlayerData().curTourneyData.score);
         }
      }
      
      public function getStats() : LeaderboardStats
      {
         return _stats;
      }
   }
}
