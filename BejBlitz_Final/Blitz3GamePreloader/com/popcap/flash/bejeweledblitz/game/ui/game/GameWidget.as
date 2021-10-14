package com.popcap.flash.bejeweledblitz.game.ui.game
{
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.BoostAssetLoaderInterface;
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailychallenge.DailyChallengeLeaderboardQuestsCoverView;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2Manager;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.replay.BoostReplayData;
   import com.popcap.flash.bejeweledblitz.game.replay.ReplayAssetDependency;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentCommonInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.ClickHintState;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.BoardWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.ScoreWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.SpeedBonusWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.LeftMenuPanel;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.blazingsteed.BlazingSteedWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.kangaruby.KangaRubyWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat.LaserCatWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism.PhoenixPrismWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.sound.SoundEffectDirector;
   import com.popcap.flash.bejeweledblitz.game.ui.tournament.InGameTournamentLeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.InGameLeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.MoveFinder;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.IBoostV2Handler;
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlazingSpeedLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzReplayHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.navigation.INavigationBadgeCounter;
   import com.popcap.flash.bejeweledblitz.particles.BlazingSpeedParticle;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3.BejeweledViewGameV2;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class GameWidget extends BejeweledViewGameV2 implements IPauseMenuHandler, IBlazingSpeedLogicHandler, IBoostV2Handler, ITimerLogicTimeChangeHandler, IBlitzReplayHandler, INavigationBadgeCounter
   {
       
      
      public var board:BoardWidget;
      
      public var laserCat:LaserCatWidget;
      
      public var phoenixPrism:PhoenixPrismWidget;
      
      public var blazingSteed:BlazingSteedWidget;
      
      public var kangaRuby:KangaRubyWidget;
      
      public var dynamicGem:DynamicRareGemWidget;
      
      public var soundDirector:SoundEffectDirector;
      
      public var ingameLeaderboard:InGameLeaderboardWidget;
      
      public var ingameTournamentLeaderboard:InGameTournamentLeaderboardWidget;
      
      public var scoreWidget:ScoreWidget;
      
      public var multiplierWidget:MultiplierWidget;
      
      public var blazingSpeedWidget:SpeedBonusWidget;
      
      private var _app:Blitz3App;
      
      private var _equippedBoosts:Vector.<BoostV2>;
      
      private var _hintButton:GenericButtonClip;
      
      private var _pauseButton:GenericButtonClip;
      
      public var mBlazingSpeedPct:Number = 0;
      
      public var dailyChallengeLeaderboardAndQuestsCoverView:DailyChallengeLeaderboardQuestsCoverView;
      
      private var _isFtueRunning:Boolean = false;
      
      private var _replayPlayButton:GenericButtonClip;
      
      private var _replayPauseButton:GenericButtonClip;
      
      private var _replayCloseButton:GenericButtonClip;
      
      public var encoreForReplay:String;
      
      public var encoreForReplayConsumed:Boolean;
      
      private var _replayStopDialog:TwoButtonDialog;
      
      private var _replayErrorDialog:SingleButtonDialog;
      
      private var _ingameLeftPanel:LeftMenuPanel;
      
      private var _blazingSpeedGlow:MovieClip = null;
      
      private var BlazingSpeedGlowIdleLastFrame:int = -1;
      
      private var BlazingSpeedGlowIntroLastFrame:int = -1;
      
      private var BlazingSpeedGlowOutroLastFrame:int = -1;
      
      private var _rainbowLayer:MovieClip = null;
      
      private var RainbowGlowIntroLastFrame:int = -1;
      
      private var _crossCollectorLayer:MovieClip = null;
      
      private var CrossCollectorFeedbackIntroLastFrame:int = -1;
      
      public function GameWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this.blazingSpeedWidget = new SpeedBonusWidget(param1,this.speedBar);
         this.board = new BoardWidget(this._app);
         this.laserCat = new LaserCatWidget(this._app);
         this.phoenixPrism = new PhoenixPrismWidget(this._app);
         this.blazingSteed = new BlazingSteedWidget(this._app);
         this.kangaRuby = new KangaRubyWidget(this._app,this.ProgressBar);
         this.dynamicGem = new DynamicRareGemWidget(this._app,this.ProgressBar);
         this.soundDirector = new SoundEffectDirector(this._app);
         this._hintButton = new GenericButtonClip(this._app,this.hint);
         this._hintButton.setRelease(this.onHintButtonPressed);
         this._pauseButton = new GenericButtonClip(this._app,this.PauseButton);
         this._pauseButton.setRelease(this.onPauseButtonPressed);
         this._pauseButton.SetDisabled(true);
         this._replayPlayButton = new GenericButtonClip(this._app,Replaymc.Replaybutton);
         this._replayPlayButton.setRelease(this.onReplayButtonPressed);
         this._replayPlayButton.clipListener.visible = false;
         this._replayPlayButton.SetDisabled(true);
         this._replayPauseButton = new GenericButtonClip(this._app,Replaymc.ReplaypauseButton);
         this._replayPauseButton.setRelease(this.onReplayPauseButtonPressed);
         this._replayPauseButton.clipListener.visible = false;
         this._replayPauseButton.SetDisabled(true);
         this._replayCloseButton = new GenericButtonClip(this._app,Replaymc.ReplayCloseButton);
         this._replayCloseButton.setRelease(this.onReplayCloseButtonPressed);
         this._replayCloseButton.clipListener.visible = false;
         this._replayCloseButton.SetDisabled(true);
         this.scoreWidget = new ScoreWidget(this._app,this.TxtMCScore);
         this.multiplierWidget = new MultiplierWidget(this._app,this.multiplier);
         this.ingameLeaderboard = new InGameLeaderboardWidget(this._app as Blitz3Game);
         this.ingameTournamentLeaderboard = new InGameTournamentLeaderboardWidget(this._app);
         this.dailyChallengeLeaderboardAndQuestsCoverView = new DailyChallengeLeaderboardQuestsCoverView();
         this.Replaymc.visible = false;
         this.visible = false;
         this._app.bjbEventDispatcher.addEventListener(FTUEEvents.FTUE_BOOST_CONSOLE_BTN_CLICKED,this.onFTUEBoostConsoleClicked);
         this._app.logic.blazingSpeedLogic.AddHandler(this);
         this._app.logic.timerLogic.AddTimeChangeHandler(this);
         this._app.logic.SetReplayHandler(this);
         this._replayStopDialog = new TwoButtonDialog(param1);
         this._replayStopDialog.visible = false;
         this._replayStopDialog.AddAcceptButtonHandler(this.handleGotoMainMenu);
         this._replayStopDialog.AddDeclineButtonHandler(this.handleResumeReplay);
         this._replayStopDialog.Init();
         this._replayStopDialog.SetDimensions(320,200);
         this._replayErrorDialog = new SingleButtonDialog(param1);
         this._replayErrorDialog.visible = false;
         this._replayErrorDialog.AddContinueButtonHandler(this.handleGotoMainMenu);
         this._replayErrorDialog.Init();
         this._replayErrorDialog.SetDimensions(320,250);
         addChild(this._replayErrorDialog);
         addChild(this._replayStopDialog);
         this.ResetReplayEncoreData();
      }
      
      public function initLeftPanel() : void
      {
         this._ingameLeftPanel = new LeftMenuPanel(this._app as Blitz3Game);
         this._ingameLeftPanel.Init();
         this._ingameLeftPanel.x = -38.95;
         this._ingameLeftPanel.y = 186.95;
         addChild(this._ingameLeftPanel);
         this._ingameLeftPanel.hideLeftPanel();
         this._app.network.AddNavigationBagdeCounterHandler(this);
      }
      
      public function updateBadgeCounter(param1:Object) : void
      {
         if(this._ingameLeftPanel != null)
         {
            this._ingameLeftPanel.handleSetCounter(param1);
         }
      }
      
      private function handleGotoMainMenu(param1:MouseEvent) : void
      {
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-Close_CloseReplay",false);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         this.onReplayPauseButtonPressed();
         (this._app as Blitz3Game).mainState.GotoMainMenuFromReplay(this._app.sessionData.replayManager.tournamentId != "");
      }
      
      private function handleResumeReplay(param1:MouseEvent) : void
      {
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-Resume_CloseReplay",false);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         this.onReplayButtonPressed();
      }
      
      public function ResetReplayEncoreData() : void
      {
         this.encoreForReplay = "";
         this.encoreForReplayConsumed = false;
      }
      
      private function onPauseButtonPressed() : void
      {
         if(!(this._app as Blitz3Game).metaUI.tutorial.isVisible())
         {
            (this._app as Blitz3Game).mainState.game.play.forcePause();
         }
         else
         {
            (this._app as Blitz3Game).mainState.game.play.Pause();
         }
      }
      
      public function HandlePauseMenuCloseClicked() : void
      {
      }
      
      public function getCoinTrailStartPosition() : Point
      {
         return new Point(this.multiplier.x,this.multiplier.y);
      }
      
      private function onHintButtonPressed() : void
      {
         var _loc1_:Vector.<MoveData> = null;
         var _loc4_:int = 0;
         _loc1_ = new Vector.<MoveData>();
         if(this._app.logic.timerLogic.GetTimeRemaining() <= 0)
         {
            return;
         }
         var _loc2_:Board = this._app.logic.board;
         var _loc3_:MoveFinder = _loc2_.moveFinder;
         _loc3_.FindAllMoves(_loc2_,_loc1_);
         if(_loc1_.length <= 0)
         {
            return;
         }
         if(Constants.SHOW_ALL_HINTS)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               _loc1_[_loc4_].sourceGem.isHinted = true;
               _loc4_++;
            }
         }
         else if(Constants.HINT_FROM_BOTTOM)
         {
            _loc1_[_loc1_.length - 1].sourceGem.isHinted = true;
         }
         else
         {
            _loc1_[0].sourceGem.isHinted = true;
         }
         this._app.logic.movePool.FreeMoves(_loc1_);
         this._app.bjbEventDispatcher.SendEvent(ClickHintState.TUTORIAL_HINT_CLICKED,null);
      }
      
      public function getHintButton() : GenericButtonClip
      {
         return this._hintButton;
      }
      
      public function init() : void
      {
         this.board.init();
         Gameboardplaceholder.addChild(this.board);
         this.addChild(this.ingameLeaderboard);
         this.addChild(this.ingameTournamentLeaderboard);
         this.blazingSpeedWidget.Init();
         this.laserCat.init();
         this.phoenixPrism.init();
         this.blazingSteed.init();
         this.kangaRuby.init();
         this.dynamicGem.init();
         this.soundDirector.init();
         this.scoreWidget.init();
         this.multiplierWidget.init();
         this.dailyChallengeLeaderboardAndQuestsCoverView.init();
         addChild(this.dailyChallengeLeaderboardAndQuestsCoverView);
         this._app.topLayer.addChild(this.laserCat);
         this._app.topLayer.addChild(this.phoenixPrism);
         this.AlignmentAnchor.addChild(this.kangaRuby);
         this._app.topLayer.addChild(this.blazingSteed);
         addChild(this.dynamicGem);
         addChild(this.blazingSpeedWidget);
         this.dynamicGem.x = PrestigeAlignment.x;
         this.dynamicGem.y = PrestigeAlignment.y;
      }
      
      public function showDailyChallengeCover(param1:Boolean) : void
      {
         if(param1)
         {
            this.dailyChallengeLeaderboardAndQuestsCoverView.show(this._app.logic.configDailyChallenge);
            ((this._app as Blitz3Game).ui as MainWidgetGame).menu.leftPanel.hideLeftPanel();
            (this._app as Blitz3Game).quest.Hide();
         }
         else
         {
            this.dailyChallengeLeaderboardAndQuestsCoverView.hide();
            ((this._app as Blitz3Game).ui as MainWidgetGame).menu.leftPanel.showLeftPanel();
            (this._app as Blitz3Game).quest.Show();
         }
      }
      
      public function ActivateBoostConsole() : void
      {
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            param1.ActivateBoost();
         });
      }
      
      public function Update() : void
      {
         if(this._app.logic.timerLogic.IsPaused())
         {
            return;
         }
         this.scoreWidget.Update();
         this.multiplierWidget.Update();
         this.laserCat.Update();
         this.phoenixPrism.Update();
         this.blazingSteed.Update();
         this.kangaRuby.Update();
         this.dynamicGem.Update();
         this.blazingSpeedWidget.Update();
         this.dailyChallengeLeaderboardAndQuestsCoverView.UpdateScore(this._app.logic.GetScoreKeeper().GetScore());
      }
      
      public function Show() : void
      {
         var _loc2_:BoostV2 = null;
         var _loc3_:BoostV2GameButton = null;
         this._pauseButton.SetDisabled(true);
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         if((this._app as Blitz3Game).isTournamentScreenOrMode())
         {
            this._ingameLeftPanel.showLeftPanel();
            this._ingameLeftPanel.showAll(false,false);
         }
         else
         {
            this._ingameLeftPanel.hideLeftPanel();
         }
         this.visible = true;
         if(!(this._app as Blitz3Game).tutorial.IsActive() && !(this._app.isMultiplayerGame() || this._app.isDailyChallengeGame()))
         {
            this.ingameLeaderboard.Show();
         }
         this.setBoardVisibility(true);
         this._equippedBoosts = this._app.sessionData.boostV2Manager.getEquippedBoosts();
         if((this._app as Blitz3Game).tutorial.IsActive())
         {
            this._equippedBoosts = null;
         }
         var _loc1_:int = 0;
         while(_loc1_ < BoostV2Manager.TOTAL_EQUIPPED_BOOSTS)
         {
            Utils.removeAllChildrenFrom(this["Boostplaceholder" + (_loc1_ + 1)] as MovieClip);
            _loc2_ = _loc1_ < (this._equippedBoosts != null && this._equippedBoosts.length) ? this._equippedBoosts[_loc1_] : null;
            _loc3_ = new BoostV2GameButton(this._app,_loc2_);
            (this["Boostplaceholder" + (_loc1_ + 1)] as MovieClip).addChild(_loc3_);
            _loc1_++;
         }
         if(this._equippedBoosts != null)
         {
            this._app.sessionData.boostV2Manager.startGameWithEquippedBoosts();
         }
         (this._app.ui as MainWidgetGame).pause.AddHandler(this);
         this._app.logic.boostLogicV2.AddHandler(this);
         this.showTournamentObjective();
      }
      
      public function Hide() : void
      {
         this._ingameLeftPanel.hideLeftPanel();
         this.ingameLeaderboard.Hide();
         this.ingameTournamentLeaderboard.hide();
         this.setBoardVisibility(false);
         this.visible = false;
      }
      
      public function ShowInReplayMode() : void
      {
         var _loc2_:BoostV2 = null;
         var _loc3_:BoostV2GameButton = null;
         this._pauseButton.SetDisabled(true);
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         this.visible = true;
         this.ingameLeaderboard.Hide();
         this.ingameTournamentLeaderboard.hide();
         this.setBoardVisibility(true);
         this.SetEquippedBoostsFromReplayData();
         this._equippedBoosts = this._app.sessionData.boostV2Manager.getEquippedBoosts();
         if((this._app as Blitz3Game).tutorial.IsActive())
         {
            this._equippedBoosts = null;
         }
         var _loc1_:int = 0;
         while(_loc1_ < BoostV2Manager.TOTAL_EQUIPPED_BOOSTS)
         {
            Utils.removeAllChildrenFrom(this["Boostplaceholder" + (_loc1_ + 1)] as MovieClip);
            _loc2_ = _loc1_ < (this._equippedBoosts != null && this._equippedBoosts.length) ? this._equippedBoosts[_loc1_] : null;
            _loc3_ = new BoostV2GameButton(this._app,_loc2_);
            (this["Boostplaceholder" + (_loc1_ + 1)] as MovieClip).addChild(_loc3_);
            _loc1_++;
         }
         if(this._equippedBoosts != null)
         {
            this._app.sessionData.boostV2Manager.startGameWithEquippedBoosts();
         }
         this._app.logic.boostLogicV2.AddHandler(this);
      }
      
      private function SetEquippedBoostsFromReplayData() : void
      {
         var _loc3_:BoostReplayData = null;
         var _loc4_:BoostV2 = null;
         var _loc1_:ReplayAssetDependency = this._app.sessionData.replayManager.GetReplayAssetDependency();
         var _loc2_:Vector.<BoostV2> = new Vector.<BoostV2>();
         for each(_loc3_ in _loc1_._boostsData)
         {
            (_loc4_ = this._app.sessionData.boostV2Manager.getBoostV2FromBoostId(_loc3_._name,true)).InitWithLevel(_loc3_._level);
            _loc2_.push(_loc4_);
         }
         this._app.sessionData.boostV2Manager.setEquippedBoosts(_loc2_);
         _loc2_ = null;
         _loc1_ = null;
      }
      
      public function CleanUp() : void
      {
         this.RemoveAllBoostsFromSlots();
         this._app.logic.boostLogicV2.CleanUp();
         this._app.logic.boostLogicV2.RemoveHandler(this);
      }
      
      public function reset() : void
      {
         this.blazingSpeedWidget.Reset();
         this.board.reset();
         this.laserCat.reset();
         this.phoenixPrism.reset();
         this.blazingSteed.reset();
         this.kangaRuby.reset();
         this.dynamicGem.reset();
         this.scoreWidget.reset();
         this.multiplierWidget.reset();
         this.HandleBlazingSpeedEnd();
      }
      
      public function HandlePauseMenuOpened() : void
      {
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         this.RemoveGameElements();
      }
      
      public function RemoveGameElements() : void
      {
         this.CleanUp();
         this.ProgressBar.visible = false;
         this.kangaRuby.destroy();
         if(this._app.logic.rareGemsLogic.currentRareGem != null)
         {
            this._app.logic.rareGemsLogic.currentRareGem.DisableCharacter();
         }
         this.PermanentlyDisableAllBoostsFromSlots();
         this._app.sessionData.finisherManager.Reset();
      }
      
      public function PermanentlyDisableAllBoostsFromSlots() : void
      {
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            param1.SetDisabledState();
            param1.Cleanup(null);
         });
      }
      
      public function DisableAllBoostsFromSlots() : void
      {
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            param1.SetDisabledState();
         });
      }
      
      public function RemoveAllBoostsFromSlots() : void
      {
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            param1.Cleanup(null);
            Utils.removeAllChildrenFrom(param1.parent as MovieClip);
         });
      }
      
      public function RunFunctionForEachBoost(param1:Function) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:BoostV2GameButton = null;
         var _loc2_:int = 0;
         while(_loc2_ < BoostV2Manager.TOTAL_EQUIPPED_BOOSTS)
         {
            _loc3_ = this["Boostplaceholder" + (_loc2_ + 1)] as MovieClip;
            if(_loc3_.numChildren != 0)
            {
               if((_loc5_ = (_loc4_ = _loc3_.getChildAt(0)) as BoostV2GameButton) != null)
               {
                  param1(_loc5_);
               }
            }
            _loc2_++;
         }
      }
      
      public function HandlePauseMenuMainClicked() : void
      {
         this.RemoveGameElements();
      }
      
      public function setBoardVisibility(param1:Boolean) : void
      {
         this.board.visible = param1;
      }
      
      public function HandleBlazingSpeedBegin() : void
      {
         if(this._app.isLQMode)
         {
            return;
         }
         var _loc1_:BlazingSpeedParticle = new BlazingSpeedParticle();
         var _loc2_:BlazingSpeedParticle = new BlazingSpeedParticle();
         ParticleBlazingSpeed1.addChild(_loc1_);
         ParticleBlazingSpeed2.addChild(_loc2_);
      }
      
      public function HandleBlazingSpeedEnd() : void
      {
         if(this._app.isLQMode)
         {
            return;
         }
         ParticleBlazingSpeed1.removeChildren();
         ParticleBlazingSpeed2.removeChildren();
         this.ShowBlazingSpeedGlowFeedback(false,"");
      }
      
      public function HandleBlazingSpeedReset() : void
      {
      }
      
      public function HandleBlazingSpeedPercentChanged(param1:Number) : void
      {
         this.mBlazingSpeedPct = param1;
      }
      
      private function onFTUEBoostConsoleClicked(param1:BJBDataEvent) : void
      {
         ((this["Boostplaceholder" + 1] as MovieClip).getChildAt(0) as BoostV2GameButton).onFtueBoostIconClicked();
      }
      
      public function HandleBoostFeedback(param1:String, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleBoostFeedbackQueue(param1:Vector.<ActionQueue>) : void
      {
      }
      
      public function HandleBoostFeedbackComplete(param1:ActionQueue) : void
      {
      }
      
      public function HandleBoostActivated(param1:String) : void
      {
      }
      
      public function HandleBoostActivationFailed(param1:String) : void
      {
      }
      
      public function HandleMoveSuccessful(param1:String, param2:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlastUpdate(param1:String) : void
      {
      }
      
      public function HandleBoostGameTimeChange(param1:String, param2:int) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleMultiplierBonus(param1:int) : void
      {
         var multiplierBonus:int = param1;
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            param1.HandleMultiplierBonus(multiplierBonus);
         });
      }
      
      public function BoardCellsActivate(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var boostId:String = param1;
         var col:int = param2;
         var row:int = param3;
         var score:int = param4;
         var mult:int = param5;
         var deltaMult:int = param6;
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            if(param1.getId() == boostId)
            {
               board.SetGemFrameLayoutPosition(col,row,score,mult,deltaMult);
            }
         });
      }
      
      public function BoardCellsDeactivate(param1:String, param2:Boolean) : void
      {
         var boostId:String = param1;
         var success:Boolean = param2;
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            if(param1.getId() == boostId)
            {
               board.HideGemFrameLayoutPosition(success);
            }
         });
      }
      
      public function RainbowGlowActivate(param1:Boolean, param2:String) : void
      {
         var enable:Boolean = param1;
         var boostId:String = param2;
         if(enable)
         {
            if(this._rainbowLayer != null)
            {
               return;
            }
            BoostAssetLoaderInterface.getMovieClip(boostId,"RainbowGlow",function(param1:MovieClip):void
            {
               _rainbowLayer = param1;
               RainbowGlowIntroLastFrame = Utils.GetAnimationLastFrame(_rainbowLayer,"animation_Intro");
               _rainbowLayer.addEventListener(Event.ENTER_FRAME,RainbowGlowEachFrame);
               RainbowBoost_placeholder.addChild(_rainbowLayer);
               _rainbowLayer.gotoAndPlay("animation_Intro");
            });
         }
         else
         {
            this.DestroyAndResetRainbowLayoutValues();
         }
      }
      
      private function RainbowGlowEachFrame(param1:Event) : void
      {
         if(this._rainbowLayer == null)
         {
            return;
         }
         if(this._rainbowLayer.currentFrame == this.RainbowGlowIntroLastFrame)
         {
            this.DestroyAndResetRainbowLayoutValues();
         }
      }
      
      private function DestroyAndResetRainbowLayoutValues() : void
      {
         if(this._rainbowLayer == null || this._rainbowLayer.visible == false)
         {
            return;
         }
         this._rainbowLayer.removeEventListener(Event.ENTER_FRAME,this.RainbowGlowEachFrame);
         RainbowBoost_placeholder.removeChild(this._rainbowLayer);
         this._rainbowLayer = null;
         this.RainbowGlowIntroLastFrame = -1;
      }
      
      public function ShowBlazingSpeedGlowFeedback(param1:Boolean, param2:String) : void
      {
         var show:Boolean = param1;
         var boostId:String = param2;
         if(show)
         {
            if(this._blazingSpeedGlow != null)
            {
               return;
            }
            BoostAssetLoaderInterface.getMovieClip(boostId,"Blazeglow",function(param1:MovieClip):*
            {
               _blazingSpeedGlow = param1;
               BlazingSpeedGlowIntroLastFrame = Utils.GetAnimationLastFrame(_blazingSpeedGlow,"intro");
               BlazingSpeedGlowIdleLastFrame = Utils.GetAnimationLastFrame(_blazingSpeedGlow,"idle");
               BlazingSpeedGlowOutroLastFrame = Utils.GetAnimationLastFrame(_blazingSpeedGlow,"outro");
               _blazingSpeedGlow.addEventListener(Event.ENTER_FRAME,BlazingSpeedGlowEachFrame);
               blazingSpeedWidget._blazingSpeedAsset.QuickFirePlaceholder.addChild(_blazingSpeedGlow);
               _blazingSpeedGlow.gotoAndPlay("intro");
            });
         }
         else
         {
            if(this._blazingSpeedGlow == null || this._blazingSpeedGlow.visible == false)
            {
               return;
            }
            this._blazingSpeedGlow.gotoAndPlay("outro");
         }
      }
      
      private function BlazingSpeedGlowEachFrame(param1:Event) : void
      {
         if(this._blazingSpeedGlow == null)
         {
            return;
         }
         if(this._blazingSpeedGlow.currentFrame == this.BlazingSpeedGlowIdleLastFrame || this._blazingSpeedGlow.currentFrame == this.BlazingSpeedGlowIntroLastFrame)
         {
            this._blazingSpeedGlow.gotoAndPlay("idle");
         }
         else if(this._blazingSpeedGlow.currentFrame == this.BlazingSpeedGlowOutroLastFrame)
         {
            this.DestroyAndResetBlazingSpeedGlowValues();
         }
      }
      
      private function DestroyAndResetBlazingSpeedGlowValues() : void
      {
         if(this._blazingSpeedGlow == null)
         {
            return;
         }
         this._blazingSpeedGlow.removeEventListener(Event.ENTER_FRAME,this.BlazingSpeedGlowEachFrame);
         this.blazingSpeedWidget._blazingSpeedAsset.QuickFirePlaceholder.removeChild(this._blazingSpeedGlow);
         this._blazingSpeedGlow = null;
         this.BlazingSpeedGlowIntroLastFrame = -1;
         this.BlazingSpeedGlowIdleLastFrame = -1;
         this.BlazingSpeedGlowOutroLastFrame = -1;
      }
      
      public function ShowCrossCollectorFeedback(param1:String) : void
      {
         var boostId:String = param1;
         if(this._crossCollectorLayer != null)
         {
            return;
         }
         BoostAssetLoaderInterface.getMovieClip(boostId,"CrossCollectorMultiplierFx",function(param1:MovieClip):void
         {
            _crossCollectorLayer = param1;
            CrossCollectorFeedbackIntroLastFrame = Utils.GetAnimationLastFrame(_crossCollectorLayer,"animation_Intro");
            _crossCollectorLayer.addEventListener(Event.ENTER_FRAME,CrossCollectorFeedbackEachFrame);
            multiplier.MultiplierPlaceholder.addChild(_crossCollectorLayer);
            _crossCollectorLayer.gotoAndPlay("animation_Intro");
         });
      }
      
      private function CrossCollectorFeedbackEachFrame(param1:Event) : void
      {
         if(this._crossCollectorLayer == null)
         {
            return;
         }
         if(this._crossCollectorLayer.currentFrame == this.CrossCollectorFeedbackIntroLastFrame)
         {
            this.DestroyAndResetCrossCollectorFeedbackValues();
         }
      }
      
      private function DestroyAndResetCrossCollectorFeedbackValues() : void
      {
         if(this._crossCollectorLayer == null || this._crossCollectorLayer.visible == false)
         {
            return;
         }
         this._crossCollectorLayer.removeEventListener(Event.ENTER_FRAME,this.CrossCollectorFeedbackEachFrame);
         multiplier.MultiplierPlaceholder.removeChild(this._crossCollectorLayer);
         this._crossCollectorLayer = null;
         this.CrossCollectorFeedbackIntroLastFrame = -1;
      }
      
      public function ForceStateChange(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:Number, param7:Number) : void
      {
         var boostId:String = param1;
         var overrideProp:Boolean = param2;
         var newState:String = param3;
         var infoType:String = param4;
         var progressType:String = param5;
         var progressUpdate:Number = param6;
         var usageCount:Number = param7;
         this.RunFunctionForEachBoost(function(param1:BoostV2GameButton):void
         {
            param1.ForceStateChange(boostId,overrideProp,newState,infoType,progressType,progressUpdate,usageCount);
         });
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(this._pauseButton != null && !this._isFtueRunning)
         {
            if(param1 == 0 || this._app.logic.timerLogic.GetTimeRemaining() > this._app.logic.config.timerLogicBaseGameDuration)
            {
               this._pauseButton.SetDisabled(true);
            }
            else
            {
               this._pauseButton.SetDisabled(false);
            }
         }
         if(this._app.mIsReplay && this._replayPauseButton != null)
         {
            if(param1 == 0)
            {
               this._replayPauseButton.SetDisabled(true);
               this._replayCloseButton.SetDisabled(true);
            }
            else
            {
               this._replayPauseButton.SetDisabled(false);
               this._replayCloseButton.SetDisabled(false);
            }
         }
      }
      
      public function DisablePauseButton(param1:Boolean) : void
      {
         if(this._pauseButton != null)
         {
            this._isFtueRunning = param1;
            this._pauseButton.SetDisabled(param1);
         }
      }
      
      public function OnReplayEnter() : void
      {
         Replaymc.visible = true;
         this.enableReplayPauseButton();
         this.disableReplayPlayButton();
         this.enableReplayCloseButton();
      }
      
      public function OnReplayExit() : void
      {
         Replaymc.visible = false;
      }
      
      private function onReplayButtonPressed() : void
      {
         this.disableReplayPlayButton();
         this.enableReplayPauseButton();
         (this._app as Blitz3Game).mainState.replay.play.Resume();
      }
      
      private function onReplayPauseButtonPressed() : void
      {
         this.disableReplayPauseButton();
         this.enableReplayPlayButton();
         (this._app as Blitz3Game).mainState.replay.play.Pause();
      }
      
      private function onReplayCloseButtonPressed() : void
      {
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-Close",false);
         this.onReplayPauseButtonPressed();
         this._replayStopDialog.SetContent("CLOSE REPLAY","Are you sure you want to close the replay?","CLOSE","RESUME");
         this._replayStopDialog.visible = true;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this._replayStopDialog,true,true,0.55);
      }
      
      private function enableReplayPauseButton() : void
      {
         this._replayPauseButton.SetDisabled(false);
         this._replayPauseButton.clipListener.visible = true;
      }
      
      private function disableReplayPauseButton() : void
      {
         this._replayPauseButton.SetDisabled(true);
         this._replayPauseButton.clipListener.visible = false;
      }
      
      private function enableReplayPlayButton() : void
      {
         this._replayPlayButton.SetDisabled(false);
         this._replayPlayButton.clipListener.visible = true;
      }
      
      private function disableReplayPlayButton() : void
      {
         this._replayPlayButton.SetDisabled(true);
         this._replayPlayButton.clipListener.visible = false;
      }
      
      private function enableReplayCloseButton() : void
      {
         this._replayCloseButton.SetDisabled(false);
         this._replayCloseButton.clipListener.visible = true;
      }
      
      private function disableReplayCloseButton() : void
      {
         this._replayCloseButton.SetDisabled(true);
         this._replayCloseButton.clipListener.visible = false;
      }
      
      public function SetEncoreForReplay(param1:String, param2:Boolean) : void
      {
         this.encoreForReplayConsumed = param2;
         this.encoreForReplay = param1;
         Blitz3App.app.sessionData.finisherManager.SetReplayFinisherId(param1);
      }
      
      public function ShowCharacterForReplay() : void
      {
         Blitz3App.app.logic.rareGemsLogic.currentRareGem.getLinkedCharacter().ShowCharacter();
      }
      
      public function ReplayHasErrors() : void
      {
         this.onReplayPauseButtonPressed();
         this._replayErrorDialog.SetContent("REPLAY ERROR","There was an unexpected problem with replay. Please try again later.","OK");
         this._replayErrorDialog.visible = true;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this._replayErrorDialog,true,true,0.55);
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-ReplayError",false);
      }
      
      public function showTournamentObjective() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:RGLogic = null;
         var _loc5_:Number = NaN;
         var _loc6_:RareGemWidget = null;
         var _loc7_:int = 0;
         var _loc8_:ImageInst = null;
         var _loc9_:Bitmap = null;
         var _loc1_:TournamentRuntimeEntity = this._app.sessionData.tournamentController.getCurrentTournament();
         this.GemcounterIcon.gotoAndStop("placeholder");
         Utils.removeAllChildrenFrom(this.GemcounterIcon.Placeholder);
         if(_loc1_ != null)
         {
            this.ingameTournamentLeaderboard.init(_loc1_);
            this.ingameTournamentLeaderboard.show();
            this.ingameLeaderboard.Hide();
            GemCounter_Bkr.visible = true;
            _loc2_ = _loc1_.Data.Objective.Type;
            if(_loc2_ == TournamentCommonInfo.OBJECTIVE_RARE_GEMS_DESTROYED)
            {
               this.GemcounterIcon.gotoAndStop("placeholder");
               _loc3_ = this._app.sessionData.rareGemManager.GetCurrentOffer().GetID();
               _loc4_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc3_);
               _loc5_ = 0.7;
               (_loc6_ = new RareGemWidget(this._app,new DynamicRareGemLoader(this._app),"small",0,0,_loc5_,_loc5_,false)).reset(_loc4_);
               this.GemcounterIcon.Placeholder.addChild(_loc6_);
            }
            else if(_loc2_ == TournamentCommonInfo.OBJECTIVE_COLORED_GEMS_DESTROYED)
            {
               this.GemcounterIcon.gotoAndStop("placeholder");
               _loc7_ = _loc1_.Data.Objective.ColorIndex;
               _loc8_ = null;
               if(_loc7_ == 1)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_RED);
               }
               else if(_loc7_ == 2)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_ORANGE);
               }
               else if(_loc7_ == 3)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_YELLOW);
               }
               else if(_loc7_ == 4)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_GREEN);
               }
               else if(_loc7_ == 5)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_BLUE);
               }
               else if(_loc7_ == 6)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_PURPLE);
               }
               else if(_loc7_ == 7)
               {
                  _loc8_ = this._app.ImageManager.getImageInst(Blitz3GameImages.IMAGE_GEM_WHITE);
               }
               if(_loc8_ != null)
               {
                  (_loc9_ = new Bitmap()).scaleX = 32 / _loc8_.width;
                  _loc9_.scaleY = 32 / _loc8_.height;
                  _loc9_.bitmapData = _loc8_.pixels.clone();
                  _loc9_.smoothing = true;
                  this.GemcounterIcon.Placeholder.scrollRect = new Rectangle(0,0,32,32);
                  this.GemcounterIcon.Placeholder.cacheAsBitmap = true;
                  this.GemcounterIcon.Placeholder.addChild(_loc9_);
               }
            }
            else if(_loc2_ == TournamentCommonInfo.OBJECTIVE_GEMS_DESTROYED)
            {
               this.GemcounterIcon.gotoAndStop("AllGems");
            }
            else if(_loc2_ == TournamentCommonInfo.OBJECTIVE_SPECIAL_GEMS_DESTROYED)
            {
               this.GemcounterIcon.gotoAndStop("AllSpecialGems");
            }
            else
            {
               GemCounter_Bkr.visible = false;
            }
         }
         else
         {
            GemCounter_Bkr.visible = false;
         }
      }
   }
}
