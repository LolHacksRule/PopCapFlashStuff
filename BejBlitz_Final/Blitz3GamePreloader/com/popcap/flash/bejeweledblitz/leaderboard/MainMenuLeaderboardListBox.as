package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.replay.ReplayDataManager;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.games.blitz3.leaderboard.LeaderboardViewListBox;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MainMenuLeaderboardListBox extends LeaderboardListBox
   {
       
      
      private var leaderboardListbox:LeaderboardViewListBox;
      
      public function MainMenuLeaderboardListBox(param1:Blitz3Game, param2:PlayerData)
      {
         super(param1,param2);
         isIngameList = false;
         this.leaderboardListbox = new LeaderboardViewListBox();
         addChild(this.leaderboardListbox);
         this.leaderboardListbox.imageContainer.addChild(_playerBitmap);
         this.leaderboardListbox.imageContainer.scrollRect = new Rectangle(0,0,36,36);
         this.leaderboardListbox.imageContainer.cacheAsBitmap = true;
         this.leaderboardListbox.addEventListener(Event.ENTER_FRAME,this.onAdded,false,0,true);
         this.leaderboardListbox.btnPoke.visible = false;
         this.leaderboardListbox.btnBrag.visible = false;
         this.leaderboardListbox.btnPoke_limit.visible = false;
         this.leaderboardListbox.btnRival.visible = false;
         this.leaderboardListbox.btnRival_press.visible = false;
         this.leaderboardListbox.btnRival_limit.visible = false;
         this.leaderboardListbox.Rival_flag.visible = false;
         this.leaderboardListbox.Rival_flag.buttonMode = false;
         this.leaderboardListbox.Rival_flag.mouseEnabled = false;
         this.validatePokeAndFlagButtons(_app.mainmenuLeaderboard.getCurrentPlayerData().curTourneyData.score);
         if(!_playerData.isFakePlayer)
         {
            this.validateRareGemAndBoostInfo();
         }
         else
         {
            this.hideBoostAndRareGemInfo();
         }
      }
      
      private function validateRareGemAndBoostInfo() : void
      {
         _app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_ASSET_DOWNLOAD_COMPLETE,function(param1:Event):void
         {
            showBoostAndRareGemInfo();
         });
      }
      
      private function showBoostAndRareGemInfo() : void
      {
         var _loc3_:int = 0;
         var _loc4_:RGLogic = null;
         var _loc5_:Number = NaN;
         var _loc6_:RareGemWidget = null;
         var _loc7_:MovieClip = null;
         var _loc8_:TextField = null;
         var _loc9_:BoostUIInfo = null;
         var _loc10_:* = null;
         this.leaderboardListbox.RareGembacker.visible = true;
         this.leaderboardListbox.Boostbacker1.visible = true;
         this.leaderboardListbox.Boostbacker2.visible = true;
         this.leaderboardListbox.Boostbacker3.visible = true;
         this.leaderboardListbox.Boostbacker1.txtLVL1.text = "";
         this.leaderboardListbox.Boostbacker2.txtLVL2.text = "";
         this.leaderboardListbox.Boostbacker3.txtLVL3.text = "";
         var _loc1_:String = _playerData.rareGemUsedForHighScore;
         var _loc2_:Object = _playerData.boostsUsedForHighScore;
         Utils.removeAllChildrenFrom(this.leaderboardListbox.RareGembacker.RaregemPlaceholder);
         if(_loc1_ != "" && _app.sessionData.rareGemManager.GetCatalog()[_loc1_] != null)
         {
            _loc4_ = _app.logic.rareGemsLogic.GetRareGemByStringID(_loc1_);
            _loc5_ = 1.25;
            if(_loc4_.isDynamicGem())
            {
               _loc5_ = 0.75;
            }
            (_loc6_ = new RareGemWidget(_app,new DynamicRareGemLoader(_app),"small",0,0,_loc5_,_loc5_,false)).reset(_loc4_);
            this.leaderboardListbox.RareGembacker.RaregemPlaceholder.addChild(_loc6_);
            this.leaderboardListbox.RareGembacker.RaregemPlaceholder.visible = true;
         }
         _loc3_ = 1;
         while(_loc3_ < 4)
         {
            _loc7_ = this.leaderboardListbox.getChildByName("Boostbacker" + _loc3_)["BoosterPlaceholder" + _loc3_] as MovieClip;
            Utils.removeAllChildrenFrom(_loc7_);
            (_loc8_ = this.leaderboardListbox.getChildByName("Boostbacker" + _loc3_)["txtLVL" + _loc3_] as TextField).text = "";
            _loc3_++;
         }
         if(_loc2_ != null)
         {
            _loc3_ = 1;
            _loc9_ = null;
            for(_loc10_ in _loc2_)
            {
               _loc7_ = this.leaderboardListbox.getChildByName("Boostbacker" + _loc3_)["BoosterPlaceholder" + _loc3_] as MovieClip;
               _loc8_ = this.leaderboardListbox.getChildByName("Boostbacker" + _loc3_)["txtLVL" + _loc3_] as TextField;
               if(_loc10_ != "" && _loc2_[_loc10_] > 0)
               {
                  if((_loc9_ = _app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(_loc10_)) != null)
                  {
                     _app.sessionData.boostV2Manager.boostV2Icons.getLBBoostIconMC(_loc10_,_loc7_);
                     _loc8_.text = !!_loc9_.IsLevelMaxLevel(_loc2_[_loc10_]) ? "MAX" : "LVL " + _loc2_[_loc10_];
                     _loc7_.x = -3.5;
                     _loc7_.y = -4.75;
                     (this.leaderboardListbox.getChildByName("Boostbacker" + _loc3_) as MovieClip).visible = true;
                     _loc3_++;
                  }
               }
            }
         }
      }
      
      private function onAdded(param1:Event) : void
      {
         if(this.leaderboardListbox.nameScoreContainer != null && this.leaderboardListbox.nameScoreContainer.txtScore != null && this.leaderboardListbox.bgClip != null && this.leaderboardListbox.bgClip.txtRankNormal != null)
         {
            this.leaderboardListbox.removeEventListener(Event.ENTER_FRAME,this.onAdded);
            this.init();
         }
      }
      
      private function init() : void
      {
         this.updateRank();
         this.leaderboardListbox.nameScoreContainer.txtName.htmlText = _playerData.playerName;
         this.updateScore();
         this.leaderboardListbox.logoPopCap.visible = _playerData.isFakePlayer;
         _playerData.copyBitmapDataTo(_playerBitmap);
         _playerBitmap.smoothing = true;
         this.SetUpMainButton();
         this.SetUpStatsButton();
         this.leaderboardListbox.logoPopCap.mouseEnabled = false;
         this.leaderboardListbox.logoPopCap.mouseChildren = false;
         this.leaderboardListbox.nameScoreContainer.mouseEnabled = false;
         this.leaderboardListbox.nameScoreContainer.mouseChildren = false;
      }
      
      public function validatePokeAndFlagButtons(param1:int) : void
      {
         param1 = param1;
         var _loc2_:Boolean = _app.mainmenuLeaderboard.getCurrentPlayerData().rank < _playerData.rank && playerData.pokeCountFromCurrentUser < _app.mainmenuLeaderboard.pokeLimit && param1 > 0;
         var _loc3_:Boolean = !_playerData.isFakePlayer && _playerData != _app.mainmenuLeaderboard.getCurrentPlayerData() && _app.mainmenuLeaderboard.flagLimit > _app.mainmenuLeaderboard.GetCurrentRivalCount() && !playerData.isFlaggedByCurrentUser;
         var _loc4_:Boolean = !_playerData.isFakePlayer && _playerData != _app.mainmenuLeaderboard.getCurrentPlayerData() && playerData.isFlaggedByCurrentUser;
         var _loc5_:Boolean;
         var _loc6_:Boolean = (_loc5_ = _app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_REPLAY)) && (_playerData.mReplayAssetDependency._score > 0 && _app.sessionData.replayManager.GetReplayDependencyStatusUsingAssetDependency(_playerData.mReplayAssetDependency) == ReplayDataManager.REPLAY_AVAILABLE);
         this.setAllowPoke(_loc2_);
         this.setAllowFlag(_loc3_,_loc4_);
      }
      
      private function GetAppropriatePokeClipToShow() : MovieClip
      {
         var _loc1_:Boolean = playerData.isCurrentPlayer();
         var _loc2_:Boolean = playerData.isFakePlayer;
         this.leaderboardListbox.btnPoke_limit.visible = !_allowPoke && !_loc1_ && !_loc2_;
         this.leaderboardListbox.btnPoke.visible = _allowPoke && !_loc1_ && !_loc2_;
         this.leaderboardListbox.btnBrag.visible = false;
         return !!_allowPoke ? this.leaderboardListbox.btnPoke : this.leaderboardListbox.btnPoke_limit;
      }
      
      private function ActivatePokeButtonClip(param1:MovieClip) : void
      {
         if(_buttonPoke == null)
         {
            _buttonPoke = new GenericButtonClip(_app,param1,true);
            _buttonPoke.setShowGraphics(false);
            _buttonPoke.setRelease(this.onPressPoke);
         }
         else
         {
            _buttonPoke.deactivate();
            _buttonPoke.clipListener = param1;
         }
         _buttonPoke.setRollOver(param1.gotoAndStop,"over");
         _buttonPoke.setRollOut(param1.gotoAndStop,"out");
         _buttonPoke.activate();
      }
      
      override public function setAllowPoke(param1:Boolean) : void
      {
         _allowPoke = param1;
         var _loc2_:MovieClip = this.GetAppropriatePokeClipToShow();
         this.ActivatePokeButtonClip(_loc2_);
      }
      
      private function onPressPoke() : void
      {
         _app.mainmenuLeaderboard.pokeHandler.OnPressPoke(this,_allowPoke);
      }
      
      private function onPressFlag() : void
      {
         _app.mainmenuLeaderboard.rivalHandler.OnPressFlag(this,_allowFlag,_allowUnflag);
      }
      
      public function GetAppropriateFlagClipToShow() : MovieClip
      {
         var _loc1_:* = false;
         var _loc3_:MovieClip = null;
         _loc1_ = !playerData.isCurrentPlayer();
         var _loc2_:Boolean = playerData.isFakePlayer;
         this.leaderboardListbox.btnRival.visible = _allowFlag && !_loc2_;
         this.leaderboardListbox.btnRival_press.visible = _allowUnflag && !_loc2_;
         this.leaderboardListbox.btnRival_limit.visible = _loc1_ && !(_allowFlag || _allowUnflag) && !_loc2_;
         this.leaderboardListbox.Rival_flag.visible = playerData.isFlaggedByCurrentUser;
         this.leaderboardListbox.Rival_flag.buttonMode = false;
         this.leaderboardListbox.Rival_flag.mouseEnabled = false;
         if(this.leaderboardListbox.btnRival.visible)
         {
            _loc3_ = this.leaderboardListbox.btnRival;
         }
         else if(this.leaderboardListbox.btnRival_press.visible)
         {
            _loc3_ = this.leaderboardListbox.btnRival_press;
         }
         else
         {
            _loc3_ = this.leaderboardListbox.btnRival_limit;
         }
         return _loc3_;
      }
      
      private function ActivateFlagButtonClip(param1:MovieClip) : void
      {
         if(_buttonFlag == null)
         {
            _buttonFlag = new GenericButtonClip(_app,param1,true);
            _buttonFlag.setShowGraphics(false);
            _buttonFlag.setRelease(this.onPressFlag);
         }
         else
         {
            _buttonFlag.deactivate();
            _buttonFlag.clipListener = param1;
         }
         _buttonFlag.setRollOver(param1.gotoAndStop,"over");
         _buttonFlag.setRollOut(param1.gotoAndStop,"out");
         _buttonFlag.activate();
      }
      
      override public function setAllowFlag(param1:Boolean, param2:Boolean) : void
      {
         _allowFlag = param1;
         _allowUnflag = param2;
         var _loc3_:MovieClip = this.GetAppropriateFlagClipToShow();
         this.ActivateFlagButtonClip(_loc3_);
      }
      
      private function SetUpMainButton() : void
      {
         _btnMain = new GenericButtonClip(_app,this.leaderboardListbox,false,true);
         _btnMain.setShowGraphics(false);
         _btnMain.setRollOver(this.btnRollOver);
         _btnMain.setRollOut(this.btnRollOut);
         _btnMain.setPress(this.btnPress);
         _btnMain.setRelease(this.btnRelease);
         _btnMain.activate();
      }
      
      private function SetUpStatsButton() : void
      {
         _btnStats = new GenericButtonClip(_app,this.leaderboardListbox.btnStats,true);
         _btnStats.setShowGraphics(false);
         _btnStats.setRollOver(this.leaderboardListbox.btnStats.gotoAndPlay,"over");
         _btnStats.setRollOut(this.leaderboardListbox.btnStats.gotoAndPlay,"out");
         _btnStats.setPress(this.statsPress);
         _btnStats.activate();
      }
      
      public function statsPress() : void
      {
         this.onUp();
         var _loc1_:Number = this.parent.y + this.y + this.leaderboardListbox.bgClip.height / 2;
         _app.mainmenuLeaderboard.showStats(_playerData,shouldForceReload(),_loc1_);
         _app.mainmenuLeaderboard.SendTrackingEvent("Stats","Button Clicked");
      }
      
      override public function update() : void
      {
         var _loc1_:int = this.updateRank();
         this.updateScore();
         if(_playerData.isCurrentPlayer())
         {
            this.showBoostAndRareGemInfo();
         }
         Tweener.removeTweens(this);
         Tweener.addTween(this,{
            "y":MainMenuLeaderboardWidget.START_Y + _loc1_ * MainMenuLeaderboardWidget.BOX_HEIGHT,
            "time":0.5
         });
      }
      
      private function updateRank() : int
      {
         var _loc1_:String = _playerData.rank.toString();
         var _loc2_:String = "";
         if(_playerData.isCurrentPlayer())
         {
            _loc2_ = "Self";
         }
         this.leaderboardListbox.bgClip.txtRankNormal.htmlText = "";
         if(_loc1_ == "1")
         {
            this.leaderboardListbox.bgClip.gotoAndStop("first" + _loc2_);
         }
         else if(_loc1_ == "2")
         {
            this.leaderboardListbox.bgClip.gotoAndStop("second" + _loc2_);
         }
         else if(_loc1_ == "3")
         {
            this.leaderboardListbox.bgClip.gotoAndStop("third" + _loc2_);
         }
         else
         {
            this.leaderboardListbox.bgClip.gotoAndStop("normal" + _loc2_);
            this.leaderboardListbox.bgClip.txtRankNormal.htmlText = _loc1_;
         }
         if(!_playerData.isFakePlayer)
         {
            this.validateRareGemAndBoostInfo();
         }
         else
         {
            this.hideBoostAndRareGemInfo();
         }
         return _playerData.rank - 1;
      }
      
      private function updateScore() : void
      {
         var _loc1_:TextFormat = null;
         if(!Boolean(_scoreStartY))
         {
            _scoreStartY = this.leaderboardListbox.nameScoreContainer.txtScore.y;
            _loc1_ = new TextFormat();
            _loc1_.size = 23;
            this.leaderboardListbox.nameScoreContainer.txtScore.defaultTextFormat = _loc1_;
         }
         this.leaderboardListbox.nameScoreContainer.txtScore.htmlText = Utils.commafy(_playerData.curTourneyData.score);
         this.leaderboardListbox.nameScoreContainer.txtScore.y = _scoreStartY;
         if(_playerData.curTourneyData.score <= 0)
         {
            this.leaderboardListbox.nameScoreContainer.txtScore.htmlText = "<font size=\'12\'>No score this week</font>";
            this.leaderboardListbox.nameScoreContainer.txtScore.y += 5;
         }
      }
      
      private function hideBoostAndRareGemInfo() : void
      {
         this.leaderboardListbox.RareGembacker.visible = false;
         this.leaderboardListbox.Boostbacker1.visible = false;
         this.leaderboardListbox.Boostbacker2.visible = false;
         this.leaderboardListbox.Boostbacker3.visible = false;
      }
      
      private function btnRollOver() : void
      {
         this.onOver();
      }
      
      private function btnRollOut() : void
      {
         this.onUp();
      }
      
      private function btnPress() : void
      {
      }
      
      private function btnRelease() : void
      {
      }
      
      private function onUp() : void
      {
         if(this.leaderboardListbox.currentFrame >= 2 && this.leaderboardListbox.currentFrame <= 12)
         {
            this.leaderboardListbox.gotoAndPlay("out");
         }
         else
         {
            this.leaderboardListbox.gotoAndStop("up");
         }
         if(!_playerData.isFakePlayer)
         {
            this.showBoostAndRareGemInfo();
         }
         else
         {
            this.hideBoostAndRareGemInfo();
         }
      }
      
      private function onOver() : void
      {
         this.leaderboardListbox.gotoAndPlay("over");
         this.hideBoostAndRareGemInfo();
      }
   }
}
