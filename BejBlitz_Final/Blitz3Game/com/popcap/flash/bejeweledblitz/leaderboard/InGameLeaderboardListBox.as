package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.leaderboard.InGameLeaderboardViewListBox;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   
   public class InGameLeaderboardListBox extends LeaderboardListBox
   {
       
      
      private var leaderboardListbox:InGameLeaderboardViewListBox;
      
      public function InGameLeaderboardListBox(param1:Blitz3Game, param2:PlayerData)
      {
         super(param1,param2);
         isIngameList = true;
         this.leaderboardListbox = new InGameLeaderboardViewListBox();
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
         this.validatePokeAndFlagButtons(_app.ingameLeaderboard.getCurrentPlayerData().curTourneyData.score);
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
         this.leaderboardListbox.logoPopCap.mouseEnabled = false;
         this.leaderboardListbox.logoPopCap.mouseChildren = false;
         this.leaderboardListbox.nameScoreContainer.mouseEnabled = false;
         this.leaderboardListbox.nameScoreContainer.mouseChildren = false;
      }
      
      public function validatePokeAndFlagButtons(param1:int) : void
      {
         param1 = param1;
         var _loc2_:Boolean = _app.ingameLeaderboard.getCurrentPlayerData().rank < _playerData.rank && playerData.pokeCountFromCurrentUser < _app.ingameLeaderboard.pokeLimit && param1 > 0;
         var _loc3_:Boolean = !_playerData.isFakePlayer && _playerData != _app.ingameLeaderboard.getCurrentPlayerData() && _app.ingameLeaderboard.flagLimit > _app.ingameLeaderboard.GetCurrentRivalCount() && !playerData.isFlaggedByCurrentUser;
         var _loc4_:Boolean = !_playerData.isFakePlayer && _playerData != _app.ingameLeaderboard.getCurrentPlayerData() && playerData.isFlaggedByCurrentUser;
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
      }
      
      private function onPressFlag() : void
      {
      }
      
      public function GetAppropriateFlagClipToShow() : MovieClip
      {
         var _loc2_:Boolean = false;
         var _loc3_:MovieClip = null;
         var _loc1_:* = !playerData.isCurrentPlayer();
         _loc2_ = playerData.isFakePlayer;
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
      
      override public function update() : void
      {
         var _loc1_:int = this.updateRank();
         this.updateScore();
         Tweener.removeTweens(this);
         Tweener.addTween(this,{
            "y":InGameLeaderboardWidget.START_Y + _loc1_ * InGameLeaderboardWidget.BOX_HEIGHT,
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
         if(this.leaderboardListbox.bgClip.txtRankNormal != null)
         {
            this.leaderboardListbox.bgClip.txtRankNormal.htmlText = "";
         }
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
         }
         if(this.leaderboardListbox.bgClip.txtRankNormal != null)
         {
            this.leaderboardListbox.bgClip.txtRankNormal.htmlText = _loc1_;
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
   }
}
