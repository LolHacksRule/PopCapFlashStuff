package com.popcap.flash.bejeweledblitz.game.tutorial
{
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FTUEEvents;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.ClickHintState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.FlameGemSwapState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.HorizontalSwapState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.ITutorialState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.NSwapsState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.TimerInfoState;
   import com.popcap.flash.bejeweledblitz.game.tutorial.states.VerticalSwapState;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.options.IOptionMenuHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.quest.IQuestRewardWidgetHandler;
   import flash.events.MouseEvent;
   
   public class TutorialWatcher implements IBlitzLogicHandler, IOptionMenuHandler, IPauseMenuHandler, IQuestRewardWidgetHandler
   {
      
      private static const ONE_DAY:int = 24 * 60 * 60;
      
      private static const TWO_DAYS:int = 2 * 24 * 60 * 60;
      
      private static const SEVEN_DAYS:int = 7 * 24 * 60 * 60;
      
      private static const FIVE_WEEKS:int = 5 * 7 * 24 * 60 * 60;
      
      public static const TUTORIAL_INITIALIZED:String = "TutorialInitialized";
       
      
      private var _app:Blitz3Game;
      
      private var _states:Vector.<ITutorialState>;
      
      private var _curState:int;
      
      private var _isPaused:Boolean;
      
      private var _isActive:Boolean;
      
      public var imageLoader:TutorialBackgroundLoader;
      
      private var m_Handlers:Vector.<ITutorialWatcherHandler>;
      
      private var _shouldShowTutorial:Boolean;
      
      public function TutorialWatcher(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._curState = -1;
         this._states = new Vector.<ITutorialState>();
         this._isPaused = false;
         this._isActive = false;
         this._shouldShowTutorial = false;
         this.imageLoader = new TutorialBackgroundLoader(param1);
         this.m_Handlers = new Vector.<ITutorialWatcherHandler>();
      }
      
      public function Init() : void
      {
         this._app.bjbEventDispatcher.SendEvent(TutorialWatcher.TUTORIAL_INITIALIZED,null);
         this.CheckNeedToDisable();
         this._app.logic.AddHandler(this);
         this._states.push(new HorizontalSwapState(this._app));
         this._states.push(new VerticalSwapState(this._app));
         this._states.push(new FlameGemSwapState(this._app));
         this._states.push(new ClickHintState(this._app));
         this._states.push(new NSwapsState(this._app,10));
         this._states.push(new TimerInfoState(this._app));
         this._app.metaUI.tutorial.AddSkipButtonHandler(this.HandleSkipClicked);
         this._app.metaUI.tutorial.infoBox.progress.SetNumSteps(this._states.length);
         this._app.metaUI.tutorial.infoBox.progress.Reset();
         this._app.metaUI.tutorialWelcome.AddPlayButtonHandler(this.HandlePlayClicked);
         this._app.metaUI.tutorialWelcome.AddSkipButtonHandler(this.HandleSkipClicked);
         var _loc1_:MainWidgetGame = this._app.ui as MainWidgetGame;
         if(_loc1_ != null)
         {
            _loc1_.menu.options.AddHandler(this);
            _loc1_.pause.AddHandler(this);
         }
         this.HandleInitComplete();
      }
      
      public function Reset() : void
      {
         this._app.metaUI.tutorial.HideAll();
         this._curState = -1;
         this._isPaused = false;
         this._isActive = false;
         this._app.metaUI.tutorial.Reset();
         this.StopTutorial();
      }
      
      public function Update() : void
      {
         var _loc1_:ITutorialState = null;
         if(!this._isPaused && this.IsActive() && this._shouldShowTutorial)
         {
            if(this._curState < 0 || this._curState >= this._states.length)
            {
               this.AdvanceNextState();
            }
            _loc1_ = this._states[this._curState];
            _loc1_.Update();
            if(_loc1_.IsComplete())
            {
               this.AdvanceNextState();
            }
         }
         if(!this._shouldShowTutorial)
         {
            (this._app.ui as MainWidgetGame).networkWait.Update();
         }
      }
      
      public function IsComplete() : Boolean
      {
         return this._app.sessionData.configManager.GetFlagWithDefault(ConfigManager.FLAG_TUTORIAL_COMPLETE,false);
      }
      
      public function IsActive() : Boolean
      {
         return this._isActive || !this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE);
      }
      
      public function Pause() : void
      {
         this._isPaused = true;
      }
      
      public function Resume() : void
      {
         this._isPaused = false;
      }
      
      public function StartTutorial() : void
      {
         this._isActive = true;
         (this._app as Blitz3Game).ingameLeaderboard.Hide();
         this._app.logic.coinTokenLogic.isEnabled = false;
         this._app.logic.multiLogic.isEnabled = false;
         this._app.logic.lastHurrahLogic.isEnabled = false;
         this._app.logic.infiniteTimeLogic.isEnabled = true;
         (this._app.ui as MainWidgetGame).game.board.clock.visible = false;
      }
      
      public function StopTutorial() : void
      {
         this._app.logic.infiniteTimeLogic.isEnabled = false;
         this._app.logic.lastHurrahLogic.isEnabled = true;
         this._app.logic.multiLogic.isEnabled = true;
         this._app.metaUI.tutorial.RemoveSkipButtonHandler(this.HandleSkipClicked);
         this._app.logic.coinTokenLogic.isEnabled = true;
         if(!(this._app.isMultiplayerGame() || this._app.isDailyChallengeGame()))
         {
            if(this._app.sessionData.tournamentController.getCurrentTournament() != null)
            {
               (this._app as Blitz3Game).ingameTournamentLeaderboard.show();
            }
            else
            {
               (this._app as Blitz3Game).ingameLeaderboard.Show();
            }
         }
         this._app.metaUI.highlight.Hide(true);
         if(!this.IsComplete())
         {
            (this._app.ui as MainWidgetGame).game.reset();
         }
         (this._app.ui as MainWidgetGame).game.board.clock.visible = true;
         this._isActive = false;
         this._shouldShowTutorial = false;
      }
      
      public function SkipTutorialAndDispatchComplete() : void
      {
         this.SkipTutorial();
         this.DispatchTutorialComplete(true);
      }
      
      private function SkipTutorial() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = this._states.length;
         if(this._curState >= 0 && this._curState < _loc1_)
         {
            _loc2_ = this._curState;
            while(_loc2_ < _loc1_)
            {
               this._states[_loc2_].ForceComplete();
               _loc2_++;
            }
         }
         else
         {
            this._curState = _loc1_;
         }
         this._curState = _loc1_;
         this._app.metaUI.tutorialWelcome.Hide();
         this._app.questManager.UpdateQuestCompletion("EndTutorial");
         this._isActive = false;
      }
      
      public function AddHandler(param1:ITutorialWatcherHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this.ReportGameBeginMetrics();
         if(this._app.isMultiplayerGame())
         {
            return;
         }
         if(!this.IsComplete())
         {
            this.Resume();
            this.StartTutorial();
         }
         else
         {
            this.StopTutorial();
         }
      }
      
      public function HandleGameEnd() : void
      {
         this.DoGameOver(true);
      }
      
      public function HandleGameAbort() : void
      {
         if(!this._app.mIsReplay)
         {
            this.DoGameOver(false);
         }
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleOptionMenuCloseClicked() : void
      {
      }
      
      public function HandleOptionMenuHelpClicked() : void
      {
         this.RestartTutorial();
      }
      
      public function HandleOptionMenuResetClicked() : void
      {
      }
      
      public function HandlePauseMenuOpened() : void
      {
      }
      
      public function HandlePauseMenuCloseClicked() : void
      {
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         if(!this.IsComplete())
         {
            this.RestartTutorial();
         }
      }
      
      public function HandlePauseMenuMainClicked() : void
      {
      }
      
      public function CanShowQuestReward() : Boolean
      {
         return true;
      }
      
      public function HandleQuestRewardClosed(param1:String) : void
      {
      }
      
      public function HandleQuestRewardOpened() : void
      {
         (this._app.ui as MainWidgetGame).networkWait.Hide(this);
      }
      
      private function HandleInitComplete() : void
      {
         var _loc1_:int = new Date().time / 1000;
         if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FIRST_GAME_TIME) < 0)
         {
            this._app.sessionData.configManager.SetInt(ConfigManager.INT_FIRST_GAME_TIME,_loc1_);
         }
         var _loc2_:int = this._app.sessionData.configManager.GetInt(ConfigManager.INT_LAST_GAME_TIME);
         if(_loc2_ >= 0 && _loc1_ - _loc2_ >= FIVE_WEEKS)
         {
            this.ClearTips();
         }
         if(this.IsComplete())
         {
            return;
         }
         this.StartTutorial();
         this.imageLoader.BeginLoad();
         if(this._shouldShowTutorial)
         {
            this._app.metaUI.tutorialWelcome.Show();
         }
         else
         {
            this._isActive = false;
         }
      }
      
      private function DispatchTutorialComplete(param1:Boolean) : void
      {
         var _loc2_:ITutorialWatcherHandler = null;
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,true);
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandleTutorialComplete(param1);
         }
      }
      
      private function DispatchTutorialRestarted() : void
      {
         var _loc1_:ITutorialWatcherHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleTutorialRestarted();
         }
      }
      
      private function DoGameOver(param1:Boolean) : void
      {
         this.ReportGameEndMetrics();
         this.Reset();
         if(param1)
         {
            this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,true);
         }
      }
      
      private function EndTutorial() : void
      {
         this.Reset();
         this.Pause();
         this._app.questManager.UpdateQuestCompletion("EndTutorial");
         this.DispatchTutorialComplete(false);
      }
      
      private function AdvanceNextState() : void
      {
         var _loc1_:ITutorialState = null;
         if(this._curState >= 0 && this._curState < this._states.length)
         {
            this._app.metaUI.tutorial.infoBox.progress.SetStepActive(this._curState + 1);
            _loc1_ = this._states[this._curState];
            _loc1_.ExitState();
         }
         ++this._curState;
         if(this._curState < 0 || this._curState >= this._states.length)
         {
            this.EndTutorial();
         }
         else
         {
            _loc1_ = this._states[this._curState];
            _loc1_.EnterState();
         }
      }
      
      private function ReportGameBeginMetrics() : void
      {
         var _loc1_:ConfigManager = this._app.sessionData.configManager;
         if(!_loc1_.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE))
         {
            return;
         }
      }
      
      private function ReportGameEndMetrics() : void
      {
         var _loc1_:ConfigManager = this._app.sessionData.configManager;
         if(_loc1_.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE))
         {
            if(!_loc1_.GetFlag(ConfigManager.FLAG_FINISHED_FIRST_GAME))
            {
               _loc1_.SetFlag(ConfigManager.FLAG_FINISHED_FIRST_GAME,true);
            }
            else if(!_loc1_.GetFlag(ConfigManager.FLAG_FINISHED_SECOND_GAME))
            {
               _loc1_.SetFlag(ConfigManager.FLAG_FINISHED_SECOND_GAME,true);
            }
         }
      }
      
      private function ClearTips() : void
      {
         var _loc1_:ConfigManager = this._app.sessionData.configManager;
         _loc1_.SetFlag(ConfigManager.FLAG_ALLOW_DISABLE_TIPS,false);
         _loc1_.SetFlag(ConfigManager.FLAG_TIPS_ENABLED,false);
      }
      
      private function RestartTutorial() : void
      {
         if(this._curState >= 0 && this._curState < this._states.length)
         {
            this._states[this._curState].ForceComplete();
         }
         this.Reset();
         this._shouldShowTutorial = true;
         this._app.metaUI.tutorial.AddSkipButtonHandler(this.HandleSkipClicked);
         (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,false);
         this._isActive = true;
         this._curState = -1;
         this.DispatchTutorialRestarted();
         this.StartTutorial();
      }
      
      private function CheckNeedToDisable() : void
      {
         if(!this._app.sessionData.userData.IsNewUser() && !this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE) && this._app.sessionData.configManager.GetInt(ConfigManager.INT_FIRST_GAME_TIME) == -1)
         {
            this.ClearTips();
            this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_TIPS_ENABLED,false);
            this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,true);
            this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_FINISHED_FIRST_GAME,true);
            this._app.sessionData.configManager.SetFlag(ConfigManager.FLAG_FINISHED_SECOND_GAME,true);
         }
      }
      
      public function SetTutorialSkipForExistingUser(param1:Boolean) : void
      {
         if(param1)
         {
            this._shouldShowTutorial = false;
            this.SkipTutorial();
            this._app.metaUI.questReward.AddHandler(this);
            (this._app.ui as MainWidgetGame).networkWait.Show(this);
            this._app.bjbEventDispatcher.addEventListener(FTUEEvents.FTUE_ENTER_LANDING_PAGE,this.OnEnterLandingPage);
         }
         else
         {
            this._shouldShowTutorial = true;
         }
      }
      
      private function HandleSkipClicked(param1:MouseEvent) : void
      {
         this.SkipTutorialAndDispatchComplete();
      }
      
      private function HandlePlayClicked(param1:MouseEvent) : void
      {
         this._app.metaUI.tutorialWelcome.Hide();
      }
      
      private function OnEnterLandingPage(param1:BJBDataEvent) : void
      {
         this._app.bjbEventDispatcher.removeEventListener(FTUEEvents.FTUE_ENTER_LANDING_PAGE,this.OnEnterLandingPage);
         this.DispatchTutorialComplete(true);
      }
      
      public function get shouldShowTutorial() : Boolean
      {
         return this._shouldShowTutorial;
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
