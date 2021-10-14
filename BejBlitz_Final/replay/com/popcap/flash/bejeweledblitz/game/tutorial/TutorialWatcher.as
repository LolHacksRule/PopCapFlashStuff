package com.popcap.flash.bejeweledblitz.game.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
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
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import flash.events.MouseEvent;
   
   public class TutorialWatcher implements IBlitzLogicHandler, IOptionMenuHandler
   {
      
      private static const ONE_DAY:int = 24 * 60 * 60;
      
      private static const TWO_DAYS:int = 2 * 24 * 60 * 60;
      
      private static const SEVEN_DAYS:int = 7 * 24 * 60 * 60;
      
      private static const FIVE_WEEKS:int = 5 * 7 * 24 * 60 * 60;
       
      
      private var m_App:Blitz3Game;
      
      private var m_States:Vector.<ITutorialState>;
      
      private var m_CurState:int;
      
      private var m_IsPaused:Boolean;
      
      public var imageLoader:TutorialBackgroundLoader;
      
      public var tipManager:TipManager;
      
      private var m_Handlers:Vector.<ITutorialWatcherHandler>;
      
      public function TutorialWatcher(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_CurState = -1;
         this.m_States = new Vector.<ITutorialState>();
         this.m_IsPaused = false;
         this.imageLoader = new TutorialBackgroundLoader(app);
         this.tipManager = new TipManager(app);
         this.m_Handlers = new Vector.<ITutorialWatcherHandler>();
      }
      
      public function Init() : void
      {
         this.tipManager.Init();
         this.CheckNeedToDisable();
         this.m_App.logic.AddHandler(this);
         this.m_States.push(new HorizontalSwapState(this.m_App));
         this.m_States.push(new VerticalSwapState(this.m_App));
         this.m_States.push(new FlameGemSwapState(this.m_App));
         this.m_States.push(new ClickHintState(this.m_App));
         this.m_States.push(new NSwapsState(this.m_App,10));
         this.m_States.push(new TimerInfoState(this.m_App));
         this.m_App.metaUI.tutorial.banner.AddSkipButtonHandler(this.HandleSkipClicked);
         this.m_App.metaUI.tutorial.infoBox.progress.SetNumSteps(this.m_States.length);
         this.m_App.metaUI.tutorial.infoBox.progress.Reset();
         this.m_App.metaUI.tutorialWelcome.AddPlayButtonHandler(this.HandlePlayClicked);
         this.m_App.metaUI.tutorialWelcome.AddSkipButtonHandler(this.HandleSkipClicked);
         this.m_App.metaUI.tutorialComplete.AddButtonHandlers(this.HandleContinueToGameClicked,this.HandleReplayClicked);
         var mainGameWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         if(mainGameWidget != null)
         {
            mainGameWidget.options.AddHandler(this);
         }
         this.HandleInitComplete();
      }
      
      public function Reset() : void
      {
         this.m_App.metaUI.tutorial.HideAll();
         this.m_CurState = -1;
         this.m_IsPaused = false;
         this.m_App.metaUI.tutorial.Reset();
         this.StopTutorial();
      }
      
      public function Update() : void
      {
         var state:ITutorialState = null;
         if(!this.m_IsPaused && this.IsEnabled())
         {
            if(this.m_CurState < 0 || this.m_CurState >= this.m_States.length)
            {
               this.AdvanceNextState();
            }
            state = this.m_States[this.m_CurState];
            state.Update();
            if(state.IsComplete())
            {
               this.AdvanceNextState();
            }
         }
      }
      
      public function IsEnabled() : Boolean
      {
         return this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_TUTORIAL) && !this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE);
      }
      
      public function Pause() : void
      {
         this.m_IsPaused = true;
      }
      
      public function Resume() : void
      {
         this.m_IsPaused = false;
      }
      
      public function StartTutorial() : void
      {
         this.m_App.metaUI.tutorial.ShowBanner();
         this.m_App.leaderboard.Hide();
         this.m_App.friendscore.Hide();
         this.m_App.logic.coinTokenLogic.isEnabled = false;
         this.m_App.logic.multiLogic.isEnabled = false;
         this.m_App.logic.lastHurrahLogic.isEnabled = false;
         this.m_App.logic.infiniteTimeLogic.isEnabled = true;
         this.m_App.ui.game.board.clock.visible = false;
      }
      
      public function StopTutorial() : void
      {
         this.m_App.logic.infiniteTimeLogic.isEnabled = false;
         this.m_App.logic.lastHurrahLogic.isEnabled = true;
         this.m_App.logic.multiLogic.isEnabled = true;
         this.m_App.logic.coinTokenLogic.isEnabled = true;
         this.m_App.leaderboard.Show();
         this.m_App.friendscore.Show();
         this.m_App.metaUI.highlight.Hide(true);
         this.m_App.metaUI.tutorial.HideBanner();
         if(this.IsEnabled())
         {
            this.m_App.ui.background.Reset();
            this.m_App.ui.game.Reset();
         }
         this.m_App.ui.game.board.clock.visible = true;
         this.m_App.ui.game.sidebar.buttons.menuButton.SetEnabled(true);
      }
      
      public function AddHandler(handler:ITutorialWatcherHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleGameBegin() : void
      {
         this.ReportGameBeginMetrics();
         if(this.IsEnabled())
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
         this.DoGameOver();
      }
      
      public function HandleGameAbort() : void
      {
         this.DoGameOver();
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
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
      
      private function HandleInitComplete() : void
      {
         var now:int = new Date().time / 1000;
         if(this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_FIRST_GAME_TIME) < 0)
         {
            this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_FIRST_GAME_TIME,now);
         }
         var lastGame:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_LAST_GAME_TIME);
         if(lastGame >= 0 && now - lastGame >= FIVE_WEEKS)
         {
            this.ClearTips();
         }
         this.m_App.sessionData.configManager.CommitChanges();
         if(!this.IsEnabled())
         {
            return;
         }
         this.StartTutorial();
         this.imageLoader.BeginLoad();
         this.m_App.metaUI.tutorialWelcome.Show();
      }
      
      private function DispatchTutorialComplete(wasSkipped:Boolean) : void
      {
         var handler:ITutorialWatcherHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleTutorialComplete(wasSkipped);
         }
      }
      
      private function DispatchTutorialRestarted() : void
      {
         var handler:ITutorialWatcherHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleTutorialRestarted();
         }
      }
      
      private function DoGameOver() : void
      {
         this.ReportGameEndMetrics();
         this.Reset();
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,true);
         this.m_App.sessionData.configManager.CommitChanges();
      }
      
      private function EndTutorial() : void
      {
         this.m_App.sessionData.configManager.CommitChanges();
         this.m_App.metaUI.tutorialComplete.Show();
         this.Reset();
         this.Pause();
      }
      
      private function AdvanceNextState() : void
      {
         var state:ITutorialState = null;
         if(this.m_CurState >= 0 && this.m_CurState < this.m_States.length)
         {
            this.m_App.metaUI.tutorial.infoBox.progress.SetStepActive(this.m_CurState + 1);
            state = this.m_States[this.m_CurState];
            state.ExitState();
         }
         ++this.m_CurState;
         if(this.m_CurState < 0 || this.m_CurState >= this.m_States.length)
         {
            this.EndTutorial();
            return;
         }
         state = this.m_States[this.m_CurState];
         state.EnterState();
      }
      
      private function ReportGameBeginMetrics() : void
      {
         var firstGame:int = 0;
         var lastGame:int = 0;
         var now:int = 0;
         var config:ConfigManager = this.m_App.sessionData.configManager;
         if(!config.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE))
         {
            return;
         }
         if(!config.GetFlag(ConfigManager.FLAG_FINISHED_FIRST_GAME))
         {
            this.m_App.network.ReportKontagentEvent("FirstGameStarted","NewUser");
         }
         else if(!config.GetFlag(ConfigManager.FLAG_FINISHED_SECOND_GAME))
         {
            this.m_App.network.ReportKontagentEvent("SecondGameStarted","NewUser");
         }
         else
         {
            firstGame = config.GetInt(ConfigManager.INT_FIRST_GAME_TIME);
            lastGame = config.GetInt(ConfigManager.INT_LAST_GAME_TIME);
            now = new Date().time / 1000;
            if(now - firstGame >= ONE_DAY && lastGame < firstGame + ONE_DAY)
            {
               this.m_App.network.ReportKontagentEvent("Post1DayGame","NewUser");
            }
            else if(now - firstGame >= TWO_DAYS && lastGame < firstGame + TWO_DAYS)
            {
               this.m_App.network.ReportKontagentEvent("Post2DaysGame","NewUser");
            }
            else if(now - firstGame >= SEVEN_DAYS && lastGame < firstGame + SEVEN_DAYS)
            {
               this.m_App.network.ReportKontagentEvent("Post7DaysGame","NewUser");
            }
         }
      }
      
      private function ReportGameEndMetrics() : void
      {
         var config:ConfigManager = this.m_App.sessionData.configManager;
         var now:int = new Date().time / 1000;
         config.SetInt(ConfigManager.INT_LAST_GAME_TIME,now);
         if(!config.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE))
         {
            if(this.m_CurState >= this.m_States.length)
            {
               this.m_App.network.ReportKontagentEvent("TutorialFinished","NewUser");
            }
            else
            {
               this.m_App.network.ReportKontagentEvent("TutorialSkipped","NewUser");
            }
         }
         else if(!config.GetFlag(ConfigManager.FLAG_FINISHED_FIRST_GAME))
         {
            this.m_App.network.ReportKontagentEvent("FirstGameFinished","NewUser");
            config.SetFlag(ConfigManager.FLAG_FINISHED_FIRST_GAME,true);
         }
         else if(!config.GetFlag(ConfigManager.FLAG_FINISHED_SECOND_GAME))
         {
            this.m_App.network.ReportKontagentEvent("SecondGameFinished","NewUser");
            config.SetFlag(ConfigManager.FLAG_FINISHED_SECOND_GAME,true);
         }
      }
      
      private function ClearTips() : void
      {
         var config:ConfigManager = this.m_App.sessionData.configManager;
         config.SetFlag(ConfigManager.FLAG_ALLOW_DISABLE_TIPS,true);
         config.SetFlag(ConfigManager.FLAG_TIPS_ENABLED,true);
         config.SetFlag(ConfigManager.FLAG_TIP_BOOST_BONUS_TIME_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_BOOST_DETONATOR_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_BOOST_MULTIPLIER_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_BOOST_MYSTERY_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_BOOST_SCRAMBLER_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_CATSEYE_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_COIN_APPEARS,false);
         config.SetFlag(ConfigManager.FLAG_TIP_FLAME_GEM_CREATED,false);
         config.SetFlag(ConfigManager.FLAG_TIP_HYPERCUBE_CREATED,false);
         config.SetFlag(ConfigManager.FLAG_TIP_MOONSTONE_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_MULTIPLIER_APPEARS,false);
         config.SetFlag(ConfigManager.FLAG_TIP_PHOENIX_PRISM_BEGIN,false);
         config.SetFlag(ConfigManager.FLAG_TIP_STAR_GEM_CREATED,false);
         config.CommitChanges();
      }
      
      private function RestartTutorial() : void
      {
         this.Reset();
         this.m_App.sessionData.featureManager.SetEnabled(FeatureManager.FEATURE_TUTORIAL,true);
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,false);
         this.m_App.metaUI.tutorialComplete.Hide();
         this.DispatchTutorialRestarted();
         this.StartTutorial();
      }
      
      private function CheckNeedToDisable() : void
      {
         if(this.m_App.sessionData.userData.GetXP() > 0 && !this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE) && this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_FIRST_GAME_TIME) == -1)
         {
            this.ClearTips();
            this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_TIPS_ENABLED,false);
            this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE,true);
            this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_FINISHED_FIRST_GAME,true);
            this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_FINISHED_SECOND_GAME,true);
         }
      }
      
      private function HandleSkipClicked(event:MouseEvent) : void
      {
         var i:int = 0;
         var numStates:int = this.m_States.length;
         if(this.m_CurState >= 0 && this.m_CurState < numStates)
         {
            for(i = this.m_CurState; i < numStates; i++)
            {
               this.m_States[i].ForceComplete();
            }
         }
         else
         {
            this.m_CurState = numStates;
         }
         this.m_CurState = numStates;
         this.m_App.tutorial.tipManager.CloseCurrentTip();
         this.m_App.metaUI.tutorialWelcome.Hide();
         this.DispatchTutorialComplete(true);
      }
      
      private function HandleContinueToGameClicked(event:MouseEvent) : void
      {
         this.m_App.metaUI.tutorialComplete.Hide();
         this.DispatchTutorialComplete(false);
      }
      
      private function HandlePlayClicked(event:MouseEvent) : void
      {
         this.m_App.metaUI.tutorialWelcome.Hide();
      }
      
      private function HandleReplayClicked(event:MouseEvent) : void
      {
         this.RestartTutorial();
      }
   }
}
