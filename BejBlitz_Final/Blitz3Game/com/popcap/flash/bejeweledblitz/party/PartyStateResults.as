package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBox;
   import com.popcap.flash.bejeweledblitz.game.ui.factories.FlameBorderlessFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.blazingsteed.Horse;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat.Laser;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism.JackpotExplosion;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3.challenge.ChallengeViewResults;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PartyStateResults extends ChallengeViewResults implements IPartyState
   {
       
      
      private var _app:Blitz3Game;
      
      private var _onDoneCallback:Function;
      
      private var _txtComboHelp:TextField;
      
      private var _btnContinue:MovieClip;
      
      private var _resultsFill:Bitmap;
      
      private var _totalIcon:Sprite;
      
      private var _playerBitmap:Bitmap;
      
      private var _opponentBitmap:Bitmap;
      
      private var _txtTotal:TextField;
      
      private var _goalIcon:Sprite;
      
      private var _txtGoal:TextField;
      
      private var _comboWidget:PartyComboWidget;
      
      private var _sparklesFromSprite:Sprite;
      
      private var _sparkleAnimation:PartySparkleAnimation;
      
      private var _horseArray:Vector.<Horse>;
      
      private var _laserArray:Vector.<Laser>;
      
      private var _frameTicker:int;
      
      private var _snackersImg:Bitmap;
      
      private var _moonImg:Bitmap;
      
      private var _phoenixImg:Bitmap;
      
      private var _babyPhoenixImg:Bitmap;
      
      private var _flameBordersFactory:FlameBorderlessFactory;
      
      private var _bottomFlamingAnimation:ImageInst;
      
      private var _bottomFlamingBitmap:Bitmap;
      
      private var _flameFrameNum:Number;
      
      private var _flamesOn:Boolean = false;
      
      private var _coinsExploding:Boolean = false;
      
      private var _jackpotExplosion:JackpotExplosion;
      
      private var _shareCB:CheckBox;
      
      private var _winTextContainer:Sprite;
      
      private var _levelOfSuccess:uint;
      
      private var _scoreThreshold:Number;
      
      private var _cleanUpList:Array;
      
      public function PartyStateResults(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._snackersImg = new Bitmap(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_HEAD));
         this._moonImg = new Bitmap(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_MOONSTONE));
         this._phoenixImg = new Bitmap(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX));
         this._babyPhoenixImg = new Bitmap(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX_BABY));
      }
      
      public function getClip() : MovieClip
      {
         return this;
      }
      
      public function enterState() : void
      {
         this._app.quest.Hide();
         Utils.log(this,"enterState called. Collecting from party: " + this._app.party.getPartyData().partyID);
         this._app.party.removeListBox(this._app.party.getPartyData().partyID);
         this.cleanUp();
         this._flameBordersFactory = new FlameBorderlessFactory(this._app,this);
         this._bottomFlamingAnimation = this._flameBordersFactory.bottomFrameAnimation;
         this._jackpotExplosion = new JackpotExplosion(this._app);
         this._bottomFlamingBitmap = new Bitmap();
         gotoAndPlay(2);
         this._app.fpsMonitor.setDynamicFPS(false);
         this._cleanUpList = new Array();
         this._levelOfSuccess = this._app.party.getPartyData().getTierIndex();
         this._scoreThreshold = this._app.party.getPartyData().getBothPlayersScorePercent();
         this._btnContinue = this.fadeTextMC.btnOk;
         this._btnContinue.mouseChildren = false;
         this._btnContinue.buttonMode = true;
         this._btnContinue.mouseEnabled = true;
         this._btnContinue.addEventListener(MouseEvent.CLICK,this.collectPress,false,0,true);
         this.showWinText();
         this.readyAnimations();
         this.addFrameEffectsToMC();
         this.swapInArtAssetsFromLibrary();
         this.swapInUserImages();
         this.addSuccessKeyframes();
         addEventListener(Event.ENTER_FRAME,this.updateAnimation,false,0,true);
         (this._app.ui as MainWidgetGame).menu.leftPanel.onPartyResults();
         PartyServerIO.sendCollectPayment(this._app.party.getPartyData().partyID);
      }
      
      private function readyAnimations() : void
      {
         this._frameTicker = 0;
         addChild(this._bottomFlamingBitmap);
         this._cleanUpList.push(this._bottomFlamingBitmap);
         this._jackpotExplosion.Init();
         this._jackpotExplosion.x = 420;
         this._jackpotExplosion.y = 410;
         addChild(this._jackpotExplosion);
         this._cleanUpList.push(this._jackpotExplosion);
         this._laserArray = new Vector.<Laser>();
         this.babyPhoenixMC.MC.gotoAndPlay(2);
      }
      
      private function addFrameEffectsToMC() : void
      {
         this.addFrameScript(44,this.fireLaser);
         this.addFrameScript(46,this.fireLaser);
         this.addFrameScript(49,this.fireLaser);
         this.addFrameScript(54,this.fireLaser);
         this.addFrameScript(56,this.fireLaser);
         this.addFrameScript(59,this.fireLaser);
         this.addFrameScript(61,this.fireLaser);
         this.addFrameScript(64,this.fireLaser);
         this.addFrameScript(66,this.fireLaser);
         this.addFrameScript(66,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_RG_APPEAR_MOONSTONE));
         this.addFrameScript(125,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_RG_APPEAR_PHOENIXPRISM));
         this.addFrameScript(136,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_LASER_CAT_MEOW));
         this.addFrameScript(166,this.startSparkles);
         this.addFrameScript(213,this.explodeCoinsFromBaby);
         this.addFrameScript(240,this.stopSparkles);
         this.addFrameScript(278,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_RG_APPEAR_BLAZINGSTEED));
         this.addFrameScript(308,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_BLAZING_LOOP,2));
         this.addFrameScript(310,this.startFireFrame);
         this.addFrameScript(355,this.explodeCoinsFromBaby);
      }
      
      private function swapInArtAssetsFromLibrary() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc5_:MovieClip = null;
         _loc1_ = this.snackersMC.blockMC;
         this._sparklesFromSprite = this.snackersMC;
         snackersMC.gotoAndPlay(2);
         MovieClip(_loc1_["block"]).visible = false;
         _loc1_.addChild(this._snackersImg);
         _loc2_ = this.moonMC.blockMC;
         if(_loc2_)
         {
            MovieClip(_loc2_["block"]).visible = false;
            _loc2_.addChild(this._moonImg);
         }
         _loc3_ = this.phoenixMC.blockMC;
         MovieClip(_loc3_["block"]).visible = false;
         _loc3_.addChild(this._phoenixImg);
         var _loc4_:MovieClip = this.babyPhoenixMC.MC.blockMC;
         MovieClip(_loc4_["block"]).visible = false;
         _loc4_.addChild(this._babyPhoenixImg);
         _loc5_ = this.horsesM.blockMC;
         MovieClip(_loc5_["block"]).visible = false;
         this._horseArray = new Vector.<Horse>();
         var _loc6_:Horse = new Horse(this._app,0,0,1);
         _loc5_.addChild(_loc6_);
         this._horseArray.push(_loc6_);
      }
      
      private function swapInUserImages() : void
      {
         this._playerBitmap = new Bitmap();
         this._opponentBitmap = new Bitmap();
         this._playerBitmap.bitmapData = new BitmapData(40,40,false,3435973632);
         this.getCurrentPlayerData().copyBitmapDataTo(this._playerBitmap);
         this._playerBitmap.width = 40;
         this._playerBitmap.height = 40;
         var _loc1_:MovieClip = this.profile_pic1;
         var _loc2_:MovieClip = this.profile_pic2;
         if(_loc1_)
         {
            _loc1_.addChild(this._playerBitmap);
         }
         this._opponentBitmap.bitmapData = new BitmapData(40,40,false,3435973632);
         this.getOpponentPlayerData().copyBitmapDataTo(this._opponentBitmap);
         this._opponentBitmap.width = 40;
         this._opponentBitmap.height = 40;
         if(_loc2_)
         {
            _loc2_.addChild(this._opponentBitmap);
         }
         var _loc3_:MovieClip = this.pedestal_1;
         var _loc4_:MovieClip = this.pedestal_2;
         Utils.log(this,"current player isTimedOut: " + this._app.party.getPartyData().getCurrentPartyPlayerData().isTimedOut);
         if(this._app.party.getPartyData().getCurrentPartyPlayerData().isTimedOut)
         {
            _loc3_.theT.text = "No Score";
         }
         else
         {
            _loc3_.theT.text = Utils.commafy(this._app.party.getPartyData().getCurrentPartyPlayerData().playerScore);
         }
         Utils.log(this,"opponent isTimedOut: " + this._app.party.getPartyData().getOpponentPartyPlayerData().isTimedOut);
         if(this._app.party.getPartyData().getOpponentPartyPlayerData().isTimedOut)
         {
            _loc4_.theT.text = "No Score";
         }
         else
         {
            _loc4_.theT.text = Utils.commafy(this._app.party.getPartyData().getOpponentPartyPlayerData().playerScore);
         }
      }
      
      private function addSuccessKeyframes() : void
      {
         this.babyPhoenixMC.gotoAndStop(1);
         if(this._levelOfSuccess > 0)
         {
            this.addFrameScript(30,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_BLITZ_PARTY_SNACKERS));
         }
         this.snackersMC.visible = true;
         if(this._levelOfSuccess == 0)
         {
            this.addFrameScript(25,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_BLITZ_PARTY_COUGH));
            this.addFrameScript(40,this.stopPlayBack);
            this.snackersMC.visible = false;
         }
         else if(this._levelOfSuccess == 1)
         {
            this.addFrameScript(77,this.stopPlayBack);
         }
         else if(this._levelOfSuccess == 2)
         {
            this.addFrameScript(73,this.explodeCoinsFromBaby);
            this.addFrameScript(100,this.stopPlayBack);
         }
         else if(this._levelOfSuccess == 3)
         {
            this.addFrameScript(53,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_BLITZ_PARTY_MUSIC_PART1));
            this.addFrameScript(260,this.stopPlayBack);
         }
         else if(this._levelOfSuccess == 4)
         {
            this.addFrameScript(53,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_BLITZ_PARTY_MUSIC_PART1));
            this.addFrameScript(358,Delegate.create(this.playSound,Blitz3GameSounds.SOUND_BLITZ_PARTY_MUSIC_PART2));
            this.addFrameScript(402,this.stopPlayBack);
         }
      }
      
      private function startFireFrame() : void
      {
         this._flameFrameNum = 0;
         this._flamesOn = true;
      }
      
      private function startSparkles() : void
      {
         this._sparkleAnimation = new PartySparkleAnimation(this._app,this._sparklesFromSprite);
         this.addChild(this._sparkleAnimation);
      }
      
      private function stopSparkles() : void
      {
         this._sparkleAnimation.addSparkles = false;
      }
      
      private function stopWinky() : void
      {
         this.babyPhoenixMC.stop();
         this.babyPhoenixMC.MC.stop();
      }
      
      private function stopPlayBack() : void
      {
         this.stop();
         this.snackersMC.stop();
         this.phoenixMC.stop();
         this.stopWinky();
         if(this.currentFrame == 24)
         {
            this.playSound(Blitz3GameSounds.SOUND_WARNING);
         }
      }
      
      private function showWinText() : void
      {
         var _loc1_:String = Utils.commafy(this._app.party.getPartyData().payoutCoinsTotal);
         if(this._winTextContainer != null)
         {
            while(this._winTextContainer.numChildren > 0)
            {
               this._winTextContainer.removeChildAt(0);
            }
            if(this.contains(this._winTextContainer))
            {
               removeChild(this._winTextContainer);
            }
         }
         this._winTextContainer = new Sprite();
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         _loc2_.size = 26;
         _loc2_.color = 16767036;
         _loc2_.leading = -3;
         _loc2_.align = TextFormatAlign.CENTER;
         var _loc3_:TextField = this.fadeTextMC.youWonText;
         if(this._levelOfSuccess == 0)
         {
            if(this._scoreThreshold < 0.25)
            {
               _loc3_.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_WIN_ANIM_NICE_TRY);
            }
            else
            {
               _loc3_.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_WIN_ANIM_CONSOLATION);
            }
         }
         else if(this._levelOfSuccess == 4)
         {
            _loc3_.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_WIN_ANIM_EPIC_SCORE);
         }
         else if(this._levelOfSuccess == 3)
         {
            _loc3_.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_WIN_ANIM_MAX_SCORE);
         }
         else
         {
            _loc3_.htmlText = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_WIN_ANIM_YOU_WON);
         }
         this.updateCoinTotal();
         this._shareCB = new CheckBox(this._app);
         this._shareCB.addLabel(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PHOENIX_PRISM_BONUS_SHARE_CONFIRM));
         this._shareCB.x = this._btnContinue.x - this._shareCB.width * 0.5;
         this._shareCB.y = this._btnContinue.y - 50;
         this._shareCB.SetChecked(this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_SHARE_BLITZ_PARTY));
         this.fadeTextMC.addChild(this._shareCB);
      }
      
      private function playSound(param1:String, param2:int = 1) : void
      {
         if(param1 == Blitz3GameSounds.SOUND_BLITZ_PARTY_COUGH && this._app.party.getPartyData().payoutCoinsTotal > 0)
         {
            return;
         }
         this._app.SoundManager.playSound(param1,param2);
      }
      
      private function explodeCoinsFromBaby() : void
      {
         if(this.babyPhoenixMC.currentFrame == 1)
         {
            this.babyPhoenixMC.gotoAndPlay(2);
         }
         this.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_BABY);
         this._jackpotExplosion.Reset();
         this._coinsExploding = true;
      }
      
      private function fireLaser() : void
      {
         var _loc1_:Laser = new Laser(this._app);
         _loc1_.Init();
         if(this.currentFrame <= 50)
         {
            _loc1_.CreateAnim(this._sparklesFromSprite.x,this._sparklesFromSprite.y + 90,245,125,10);
         }
         else
         {
            _loc1_.CreateAnim(this._sparklesFromSprite.x + 80,this._sparklesFromSprite.y + 120,245,125,10);
         }
         this._laserArray.push(_loc1_);
         addChild(_loc1_);
         this._cleanUpList.push(_loc1_);
         this.playSound(Blitz3GameSounds.SOUND_LASER_FIRE);
      }
      
      private function updateCoinTotal() : void
      {
         var _loc1_:String = Utils.commafy(this._app.party.getPartyData().payoutCoinsTotal);
         var _loc2_:TextField = this.fadeCoinTextMC.rewardText;
         if(_loc1_ == "0")
         {
            _loc2_.htmlText = "";
         }
         else
         {
            _loc2_.htmlText = _loc1_ + " Coins";
         }
      }
      
      private function updateAnimation(param1:Event) : void
      {
         var _loc2_:Horse = null;
         var _loc3_:Laser = null;
         this.updateCoinTotal();
         if(this.currentFrame == 2)
         {
            play();
         }
         ++this._frameTicker;
         if(this._sparkleAnimation)
         {
            this._sparkleAnimation.updateAnimation(param1);
         }
         for each(_loc2_ in this._horseArray)
         {
            _loc2_.SetHorseFrame(this._frameTicker);
         }
         for each(_loc3_ in this._laserArray)
         {
            _loc3_.Update();
            _loc3_.Update();
            _loc3_.Update();
         }
         if(this._flamesOn)
         {
            this._bottomFlamingBitmap.visible = true;
            this._bottomFlamingBitmap.alpha = Math.min(this._flameFrameNum * 0.1,1);
            this._bottomFlamingAnimation.mFrame = this._flameFrameNum % this._bottomFlamingAnimation.mSource.mNumFrames;
            this._bottomFlamingBitmap.bitmapData = this._bottomFlamingAnimation.pixels;
            this._flameFrameNum += 1;
         }
         if(this._coinsExploding)
         {
            this._jackpotExplosion.Update();
            this._jackpotExplosion.Update();
         }
      }
      
      public function exitState() : void
      {
         this.cleanUp();
         (this._app.ui as MainWidgetGame).menu.leftPanel.showAll(true,true);
      }
      
      private function cleanUp() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         gotoAndStop(1);
         this._coinsExploding = false;
         this._flamesOn = false;
         bannerMC.gotoAndStop(1);
         bannerMC.addFrameScript(25,null);
         if(this._sparkleAnimation)
         {
            if(this.contains(this._sparkleAnimation))
            {
               this.removeChild(this._sparkleAnimation);
            }
         }
         if(this._winTextContainer)
         {
            if(this.bannerMC.contains(this._winTextContainer))
            {
               this.bannerMC.removeChild(this._winTextContainer);
            }
         }
         if(this._shareCB)
         {
            if(this.fadeTextMC.contains(this._shareCB))
            {
               this.fadeTextMC.removeChild(this._shareCB);
            }
         }
         for each(_loc1_ in this._cleanUpList)
         {
            if(this.contains(_loc1_))
            {
               removeChild(_loc1_);
            }
            _loc1_ = null;
         }
         this._cleanUpList = null;
         this._app.fpsMonitor.setDynamicFPS(true);
         _loc3_ = this.totalFrames - 1;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.addFrameScript(_loc2_,null);
            _loc2_++;
         }
         try
         {
            _loc4_ = this.babyPhoenixMC.MC.totalFrames - 1;
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               this.babyPhoenixMC.MC.addFrameScript(_loc2_,null);
               _loc2_++;
            }
         }
         catch(e:Error)
         {
         }
         while(this.horsesM.blockMC.numChildren > 0)
         {
            this.horsesM.blockMC.removeChildAt(0);
         }
         if(this._btnContinue)
         {
            this._btnContinue.removeEventListener(MouseEvent.CLICK,this.collectPress);
         }
         removeEventListener(Event.ENTER_FRAME,this.updateAnimation);
      }
      
      public function setDoneCallback(param1:Function = null) : void
      {
         this._onDoneCallback = param1;
      }
      
      private function onRematchCallback() : void
      {
         if(PartyServerIO.currentPartyData.isValid)
         {
            this._app.party.showGameState(PartyServerIO.currentPartyData);
         }
         else
         {
            PartyServerIO.sendBuyTokens();
         }
      }
      
      private function collectPress(param1:MouseEvent) : void
      {
         if(this._shareCB.IsChecked())
         {
            this.sharePress();
         }
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_SHARE_BLITZ_PARTY,this._shareCB.IsChecked());
         this._app.sessionData.configManager.CommitChanges(true);
         Utils.log(this,"collectPress opponent is Finalized: " + this._app.party.getPartyData().getOpponentPartyPlayerData().isFinalized + " and id is: " + this._app.party.getPartyData().partyID);
         var _loc2_:int = int(this._app.party.getPartyData().payoutCoinsTotal);
         this._app.sessionData.userData.currencyManager.AddCurrencyByType(_loc2_,CurrencyManager.TYPE_COINS);
         visible = false;
         this.cleanUp();
         this.onCollectCallback();
      }
      
      private function onCollectCallback() : void
      {
         Utils.log(this,"onCollectCallback called. isPlayerSender is: " + this._app.party.getPartyData().isPlayerSender() + " and isLastStateStatus is: " + this._app.party.isLastStateStatus());
         if(this._app.party.isLastStateStatus())
         {
            this._app.mainState.showGameOver();
         }
         else
         {
            this._app.party.showWelcomeState();
         }
      }
      
      private function sharePress() : void
      {
         var _loc1_:PartyData = this._app.party.getPartyData();
         PartyServerIO.sendWallPost(_loc1_.getOpponentPartyPlayerData().getPlayerData().playerName,_loc1_.getOpponentPartyPlayerData().getPlayerData().playerFuid,_loc1_.getCurrentPartyPlayerData().playerScore,_loc1_.getOpponentPartyPlayerData().playerScore,_loc1_.getTotalScore(),_loc1_.payoutCoinsTotal,false,_loc1_.isHighStakes(),_loc1_.getTierIndex());
      }
      
      protected function getCurrentPlayerData() : PlayerData
      {
         return this.getCurrentPartyPlayerData().getPlayerData();
      }
      
      protected function getCurrentPartyPlayerData() : PartyPlayerData
      {
         return this._app.party.getPartyData().getCurrentPartyPlayerData();
      }
      
      protected function getOpponentPlayerData() : PlayerData
      {
         return this.getOpponentPartyPlayerData().getPlayerData();
      }
      
      protected function getOpponentPartyPlayerData() : PartyPlayerData
      {
         return this._app.party.getPartyData().getOpponentPartyPlayerData();
      }
   }
}

class Delegate
{
    
   
   function Delegate()
   {
      super();
   }
   
   public static function create(param1:Function, ... rest) : Function
   {
      var handler:Function = param1;
      var args:Array = rest;
      return function(... rest):void
      {
         handler.apply(this,rest.concat(args));
      };
   }
}
