package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.tutorial.ITutorialWatcherHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.particles.ParticleUpdater;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class MainState extends Sprite implements IAppState, ITutorialWatcherHandler
   {
      
      public static const STATE_MENU:String = "State:Main";
      
      public static const STATE_GAME:String = "State:Game";
      
      public static const STATE_REPLAY:String = "State:Replay";
      
      public static const STATE_PRE_GAME_MENU:String = "State:PreGameMenu";
      
      public static const STATE_PARTY:String = "State:Party";
      
      public static const STATE_DAILY_CHALLENGES:String = "State:DailyChallenges";
      
      public static const STATE_TOURNAMENT:String = "State:Tournament";
      
      public static const SIGNAL_PLAY:String = "Event:Play";
      
      public static const SIGNAL_PLAY_TUTORIAL:String = "Event:PlayTutorial";
      
      public static const SIGNAL_QUIT:String = "Event:Quit";
       
      
      private var _stateMachine:IAppStateMachine;
      
      public var menu:MenuState;
      
      public var game:GameState;
      
      public var replay:ReplayState;
      
      public var preGameMenu:PreGameMenuState;
      
      public var party:PartyState;
      
      public var dailyChallengeState:DailyChallengesState;
      
      public var tournamentState:TournamentState;
      
      private var _app:Blitz3Game;
      
      private var _mainWidgetGame:MainWidgetGame;
      
      public function MainState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._mainWidgetGame = this._app.ui as MainWidgetGame;
         this._stateMachine = new BaseAppStateMachine();
         this.menu = new MenuState(param1);
         this.game = new GameState(param1);
         this.preGameMenu = new PreGameMenuState(param1);
         this.party = new PartyState(param1);
         this.dailyChallengeState = new DailyChallengesState(param1);
         this.replay = new ReplayState(param1);
         this.tournamentState = new TournamentState(param1);
         this.menu.addEventListener(SIGNAL_PLAY_TUTORIAL,this.HandlePlayTutorial);
         this.game.addEventListener(SIGNAL_QUIT,this.HandleQuit);
         this.preGameMenu.addEventListener(SIGNAL_PLAY,this.HandlePlay);
         this._stateMachine.bindState(STATE_MENU,this.menu);
         this._stateMachine.bindState(STATE_GAME,this.game);
         this._stateMachine.bindState(STATE_PRE_GAME_MENU,this.preGameMenu);
         this._stateMachine.bindState(STATE_PARTY,this.party);
         this._stateMachine.bindState(STATE_DAILY_CHALLENGES,this.dailyChallengeState);
         this._stateMachine.bindState(STATE_REPLAY,this.replay);
         this._stateMachine.bindState(STATE_TOURNAMENT,this.tournamentState);
         addChild(this.game);
         this._app.tutorial.AddHandler(this);
      }
      
      public function showGameOver() : void
      {
         this.game.over.showGameOver();
      }
      
      public function StartPreGameMenu() : void
      {
         this._app.logic.CleanUpPostGameplay();
         this._stateMachine.switchState(STATE_PRE_GAME_MENU);
      }
      
      public function GotoMainMenu() : void
      {
         this._app.sessionData.tournamentController.RevertJoinRetryCost();
         this.GotoMainMenuCleanup();
         this._stateMachine.switchState(STATE_MENU);
      }
      
      public function GotoMainMenuCleanup() : void
      {
         (this._app.ui as MainWidgetGame).menu.leftPanel.ensureStandardBoostManager();
         (this._app.ui as MainWidgetGame).menu.leftPanel.showAll(true,false);
         this._app.logic.isActive = false;
         this._app.logic.CleanUpPostGameplay();
         this._app.eventsNextLaunchUrl = "";
         if(this._app.eventsView != null)
         {
            this._app.eventsView.eventlaunchURL = "";
         }
         this._app.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         if(this._app.isMultiplayerGame())
         {
            this._app.party.reAlignSideGame();
            this._app.setMultiplayerGame(false);
         }
         (this._app.ui as MainWidgetGame).game.showDailyChallengeCover(false);
         if(!this._app.whatsNewWidget.isWhatsNewShown())
         {
            this._app.metaUI.highlight.Hide(true);
         }
         this._app.metaUI.tutorial.HideArrow();
         this._app.quest.Hide();
         this._app.sessionData.tournamentController.setCurrentTournamentId("");
         ServerIO.sendToServer("forceCloseInventory");
      }
      
      public function GotoMainMenuFromReplay(param1:Boolean = false) : void
      {
         this._app.logic.Quit();
         this._app.sessionData.AbortGame();
         this._app.logic.CleanUpPostGameplay();
         (this._app.ui as MainWidgetGame).game.ResetReplayEncoreData();
         this._app.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         this._app.mIsReplay = false;
         this._app.sessionData.finisherManager.SetReplayFinisherId("");
         this._app.sessionData.finisherManager.onReplayAborted();
         (this._app.ui as MainWidgetGame).game.RemoveGameElements();
         (this._app.ui as MainWidgetGame).menu.leftPanel.showAll(true,false);
         this._app.logic.isActive = false;
         this._app.eventsNextLaunchUrl = "";
         if(this._app.eventsView != null)
         {
            this._app.eventsView.eventlaunchURL = "";
         }
         this._app.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         if(!this._app.whatsNewWidget.isWhatsNewShown())
         {
            this._app.metaUI.highlight.Hide(true);
         }
         this._app.quest.Hide();
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         this._app.ui.ClearMessages();
         this._stateMachine.switchState(STATE_MENU);
         if(param1)
         {
            (this._app.ui as MainWidgetGame).menu.setCurrentMode(MenuWidget.MODE_TOURNAMENT);
            this.gotoTournamentScreen();
         }
      }
      
      public function StartGame() : void
      {
         this._stateMachine.switchState(STATE_GAME);
      }
      
      public function isMenuState() : Boolean
      {
         return this._stateMachine.getCurrentStateID() == STATE_MENU;
      }
      
      public function isTournamentState() : Boolean
      {
         return this._stateMachine.getCurrentStateID() == STATE_TOURNAMENT;
      }
      
      public function isCurrentStateGame() : Boolean
      {
         return this._stateMachine.getCurrentStateID() == STATE_GAME;
      }
      
      public function isCurrentStateGameOver() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.isCurrentStateGame())
         {
            _loc1_ = (this._stateMachine.getCurrentState() as GameState).isCurrentStateGameOver();
         }
         return _loc1_;
      }
      
      public function update() : void
      {
         this._stateMachine.getCurrentState().update();
         this._app.topHUD.Update();
         this._app.quest.Update();
      }
      
      public function draw(param1:int) : void
      {
         this._stateMachine.getCurrentState().draw(param1);
         ParticleUpdater.GetInstance().UpdateParticles();
      }
      
      public function onEnter() : void
      {
         this._stateMachine.switchState(STATE_MENU);
      }
      
      public function onExit() : void
      {
      }
      
      public function HandleTutorialComplete(param1:Boolean) : void
      {
      }
      
      public function HandleTutorialRestarted() : void
      {
         this._stateMachine.switchState(STATE_GAME);
      }
      
      private function HandlePlay(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_GAME);
      }
      
      private function HandlePlayTutorial(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_GAME);
      }
      
      public function OnGemHarvest() : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._stateMachine.switchState(STATE_PRE_GAME_MENU);
         }
         else
         {
            this._app.party.hideMe();
            this._stateMachine.switchState(STATE_PRE_GAME_MENU);
            this._app.quest.Show(true);
         }
      }
      
      public function HandleQuit(param1:Event = null) : void
      {
         if(this._app.isMultiplayerGame())
         {
            this._stateMachine.switchState(STATE_PARTY);
         }
         else
         {
            this._app.party.hideMe();
            this._stateMachine.switchState(STATE_PRE_GAME_MENU);
         }
      }
      
      public function onLeaveMainMenu() : void
      {
         this._stateMachine.switchState(STATE_PRE_GAME_MENU);
      }
      
      public function GotoReplay() : void
      {
         this._stateMachine.switchState(STATE_REPLAY);
      }
      
      public function showParty(param1:String = "") : void
      {
         this.GotoMainMenuCleanup();
         this._app.logic.SetConfig(BlitzLogic.DEFAULT_CONFIG);
         if(!this._app.isMultiplayerGame())
         {
            this._app.setMultiplayerGame(true);
            this._app.sessionData.rareGemManager.Init();
         }
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         this.party.setShowPartyID(param1);
         this._stateMachine.switchState(STATE_PARTY);
         this._app.quest.Show(true);
      }
      
      public function gotoDailyChallenges() : void
      {
         this.GotoMainMenuCleanup();
         this._app.setMultiplayerGame(false);
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         this._stateMachine.switchState(STATE_DAILY_CHALLENGES);
      }
      
      public function gotoTournamentScreen() : void
      {
         this.GotoMainMenuCleanup();
         (this._app.ui as MainWidgetGame).menu.setCurrentMode(MenuWidget.MODE_TOURNAMENT);
         (this._app.ui as MainWidgetGame).menu.leftPanel.showKeyStoneButton(true,false,true);
         this._stateMachine.switchState(STATE_TOURNAMENT);
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_TOUR_MODE);
      }
   }
}
