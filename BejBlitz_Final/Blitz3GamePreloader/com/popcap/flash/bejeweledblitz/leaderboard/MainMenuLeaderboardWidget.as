package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.adobe.images.JPGEncoder;
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.games.blitz3.leaderboard.LeaderboardViewWidget;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   
   public class MainMenuLeaderboardWidget extends LeaderboardWidget implements IFeatureManagerHandler, ILeaderboardUpdateEvents
   {
      
      private static const _MAX_SCREEN_BOXES:Number = 4;
      
      public static const BOX_HEIGHT:Number = 54;
      
      public static const PAGINATION_HEIGHT:Number = BOX_HEIGHT * _MAX_SCREEN_BOXES;
      
      public static const START_Y:Number = 90;
      
      public static const END_Y:Number = 347;
       
      
      private var _currentPageIndex:int = 0;
      
      private var _btnMysteryTreasure:GenericButtonClip;
      
      private var _btnSave:GenericButtonClip;
      
      private var _listBoxArray:Vector.<MainMenuLeaderboardListBox>;
      
      private var _minY:Number = 0;
      
      private var _currentTopBoxIndex:int = 0;
      
      private var _maxTopBoxIndex:int = 0;
      
      private var _isBtnUpActive:Boolean = false;
      
      private var _isBtnDownActive:Boolean = false;
      
      private var _btnRefreshTournament:GenericButtonClip;
      
      private var _btnRefreshWhoops:GenericButtonClip;
      
      private var _btnAddFriend:GenericButtonClip;
      
      private var _btnPlay:GenericButtonClip;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      private var _leaderboardviewWidget:LeaderboardViewWidget;
      
      private var _isFtueRunning:Boolean;
      
      public function MainMenuLeaderboardWidget(param1:Blitz3Game)
      {
         super(param1);
         this._leaderboardviewWidget = new LeaderboardViewWidget();
         this._listBoxArray = new Vector.<MainMenuLeaderboardListBox>();
         _stats = new LeaderboardStats(_app);
         this._leaderboardviewWidget.addChild(_stats);
         this._leaderboardviewWidget.btnRefreshTournament.visible = false;
         this._btnRefreshTournament = new GenericButtonClip(_app,this._leaderboardviewWidget.btnRefreshTournament);
         this._btnRefreshTournament.setPress(this.refreshTournamentPress);
         this._leaderboardviewWidget.btnRefreshWhoops.visible = false;
         this._btnRefreshWhoops = new GenericButtonClip(_app,this._leaderboardviewWidget.btnRefreshWhoops);
         this._btnRefreshWhoops.setPress(this.refreshWhoopsPress);
         this._btnUp = new GenericButtonClip(_app,this._leaderboardviewWidget.btnUp,true);
         this._btnUp.setPress(this.upPress);
         this._btnUp.clipListener.gotoAndStop("disabled");
         this._btnDown = new GenericButtonClip(_app,this._leaderboardviewWidget.btnDown,true);
         this._btnDown.setPress(this.downPress);
         this._btnDown.clipListener.gotoAndStop("disabled");
         this._btnMysteryTreasure = new GenericButtonClip(_app,this._leaderboardviewWidget.btnMysteryTreasure,true);
         this._btnMysteryTreasure.setPress(this.mysteryTreasurePress);
         this._btnMysteryTreasure.activate();
         this._btnAddFriend = new GenericButtonClip(_app,this._leaderboardviewWidget.btnAdd,true);
         this._btnAddFriend.setRelease(this.addFriendPress);
         this._btnPlay = new GenericButtonClip(_app,this._leaderboardviewWidget.mcBannerSolo,true);
         this._btnPlay.setPress(this.onPlayButtonPressed);
         _boxContainer = this._leaderboardviewWidget.leaderboardContainer;
         _boxContainer.visible = false;
         this._btnSave = new GenericButtonClip(_app,this._leaderboardviewWidget.btnSave);
         this._btnSave.setRelease(this.savePress);
         this._btnSave.clipListener.visible = false;
         this._btnSave.deactivate();
         updater = new DataUpdater(_app,this);
         pageInterface = new PageInterface(_app);
         pokeHandler = new PokeHandler(_app,this);
         rivalHandler = new RivalHandler(_app,this);
         addChild(this._leaderboardviewWidget);
         _app.AddLBDataHandler(this);
         _app.bjbEventDispatcher.addEventListener(FTUEEvents.FTUE_SETUP_MAINMENU_LB,this.setupPlayBtnForFTUE);
         this._isFtueRunning = false;
      }
      
      private function setupPlayBtnForFTUE(param1:BJBDataEvent) : void
      {
         this._isFtueRunning = true;
      }
      
      private function onPlayButtonPressed() : void
      {
         if(this._isFtueRunning)
         {
            _app.bjbEventDispatcher.SendEvent(FTUEEvents.FTUE_PLAY_BTN_CLICKED,null);
         }
         (_app.ui as MainWidgetGame).menu.leftPanel.showMainButton(true);
         _app.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         if(_app.isMultiplayerGame())
         {
            _app.setMultiplayerGame(false);
            _app.sessionData.rareGemManager.Init();
         }
         _app.quest.Show(true);
         _app.mainState.onLeaveMainMenu();
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
      
      private function addFriendPress() : void
      {
         _app.network.inviteFriends("leaderboard");
      }
      
      public function Init() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         currentPlayerFUID = _app.sessionData.userData.GetFUID();
         _app.sessionData.featureManager.AddHandler(this);
         updater.RequestBasicXML();
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
         this._listBoxArray = new Vector.<MainMenuLeaderboardListBox>();
      }
      
      public function showLeaderboardRefresh() : void
      {
         if(this._leaderboardviewWidget.btnRefreshTournament.visible)
         {
            this._leaderboardviewWidget.btnRefreshTournament.visible = false;
         }
         this._leaderboardviewWidget.loadingClip.visible = false;
         _boxContainer.visible = false;
         this._btnSave.clipListener.visible = false;
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
         this._btnSave.clipListener.visible = false;
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
         var _loc1_:MainWidgetGame = null;
         if(_app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_LEADERBOARD_BASIC))
         {
            visible = true;
            mouseChildren = true;
            _loc1_ = _app.ui as MainWidgetGame;
            if(!SpinBoardUIController.GetInstance().IsSpinBoardOpen())
            {
               _loc1_.menu.enablePurchaseButtons(true);
            }
            this._btnSave.clipListener.visible = true;
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
         this._btnSave.clipListener.visible = false;
         this._isFtueRunning = false;
      }
      
      public function HandleBasicLoadComplete() : void
      {
         if(_isLoaded)
         {
            return;
         }
         _isLoaded = true;
         updater.RequestExtendedData(currentPlayerFUID);
         var _loc1_:PlayerData = PlayersData.getPlayerData(currentPlayerFUID);
         if(_loc1_)
         {
            _currentPlayerHighScore = _loc1_.curTourneyData.score;
         }
         this.buildList();
         this._leaderboardviewWidget.loadingClip.visible = false;
         _boxContainer.visible = true;
         this._btnSave.clipListener.visible = true;
      }
      
      public function HandleScoreUpdated(param1:int) : void
      {
         var _loc2_:uint = 0;
         PlayersData.UpdateScore(currentPlayerFUID,param1);
         updater.RequestExtendedData(currentPlayerFUID,true);
         if(param1 > _currentPlayerHighScore)
         {
            _currentPlayerHighScore = param1;
            if(this._listBoxArray != null)
            {
               _loc2_ = 0;
               while(_loc2_ < this._listBoxArray.length)
               {
                  this._listBoxArray[_loc2_].update();
                  _loc2_++;
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
         var _loc3_:MainMenuLeaderboardListBox = null;
         this.clearList();
         var _loc1_:Vector.<String> = PlayersData.GetList();
         var _loc4_:Number = _boxContainer.templateClip.x;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = PlayersData.getPlayerData(_loc1_[_loc5_]);
            _loc3_ = new MainMenuLeaderboardListBox(_app,_loc2_);
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
            this._maxTopBoxIndex = this._listBoxArray.length - _MAX_SCREEN_BOXES;
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
      
      private function mysteryTreasurePress() : void
      {
         ServerIO.sendToServer("createMysteryTreasure");
      }
      
      private function savePress() : void
      {
         var _loc1_:BitmapData = new BitmapData(this._leaderboardviewWidget.printBoundaries.width,this._leaderboardviewWidget.printBoundaries.height,true);
         _loc1_.draw(this._leaderboardviewWidget,new Matrix(1,0,0,1,-this._leaderboardviewWidget.printBoundaries.x,-this._leaderboardviewWidget.printBoundaries.y));
         Utils.removeAllChildrenFrom(this._leaderboardviewWidget.printContainer.printBoundaries);
         this._leaderboardviewWidget.printContainer.printBoundaries.addChild(new Bitmap(_loc1_));
         var _loc2_:BitmapData = new BitmapData(this._leaderboardviewWidget.printContainer.width,this._leaderboardviewWidget.printContainer.height,true);
         _loc2_.draw(this._leaderboardviewWidget.printContainer);
         var _loc3_:JPGEncoder = new JPGEncoder(100);
         var _loc4_:ByteArray = _loc3_.encode(_loc2_);
         var _loc5_:FileReference = new FileReference();
         var _loc6_:Date = new Date();
         var _loc7_:String = String(_loc6_.fullYear) + Utils.getTwoDigitString(_loc6_.month + 1) + Utils.getTwoDigitString(_loc6_.date) + Utils.getTwoDigitString(_loc6_.hours) + Utils.getTwoDigitString(_loc6_.minutes) + Utils.getTwoDigitString(_loc6_.seconds);
         _loc5_.save(_loc4_,"BejeweledBlitz_" + _loc7_ + ".jpg");
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
            this._btnUp.clipListener.gotoAndStop("disabled");
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
            this._btnDown.clipListener.gotoAndStop("disabled");
         }
         this._isBtnDownActive = param1;
      }
      
      public function updatePokeAndRivalStatus() : void
      {
         this.updatePokeAndRivalStatusForAllPlayers();
      }
      
      public function validatePokeAndFlagButtonsForPlayer(param1:PlayerData) : void
      {
         var _loc2_:MainMenuLeaderboardListBox = this.getLeaderBoardEntry(param1) as MainMenuLeaderboardListBox;
         if(_loc2_ != null)
         {
            _loc2_.validatePokeAndFlagButtons(getCurrentPlayerData().curTourneyData.score);
         }
      }
   }
}
