package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.party.PartyServerIO;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_RESET:String = "State:Game:Reset";
      
      public static const STATE_GAME_PLAY:String = "State:Game:Play";
      
      public static const STATE_GAME_OVER:String = "State:Game:Over";
      
      public static const SIGNAL_GAME_RESET:String = "Signal:GameReset";
      
      public static const SIGNAL_GAME_START:String = "Signal:GameStart";
      
      public static const SIGNAL_GAME_END:String = "Signal:GameEnd";
      
      public static const SIGNAL_GAME_QUIT:String = "Signal:GameQuit";
      
      public static const SIGNAL_GAME_GOTO_MAIN:String = "Signal:GameGotoMain";
      
      public static const SIGNAL_GAME_OVER_CONTINUE:String = "Signal:GameOverContinue";
      
      public static const SIGNAL_TUTORIAL_END:String = "Signal:TutorialEnd";
       
      
      public var reset:GameResetState;
      
      public var play:GamePlayState;
      
      public var over:GameOverState;
      
      private var _app:Blitz3Game;
      
      private var mStateMachine:IAppStateMachine;
      
      private var mLastDisplayed:DisplayObject;
      
      private var _mainWidget:MainWidgetGame;
      
      public function GameState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this.mStateMachine = new BaseAppStateMachine();
         this._mainWidget = this._app.ui as MainWidgetGame;
         this.reset = new GameResetState(param1);
         this.play = new GamePlayState(param1);
         this.over = new GameOverState(param1);
         this.reset.addEventListener(SIGNAL_GAME_START,this.handleStart);
         this.play.addEventListener(SIGNAL_GAME_END,this.handleEnd);
         this.play.addEventListener(SIGNAL_GAME_RESET,this.handleReset);
         this.play.addEventListener(SIGNAL_GAME_QUIT,this.handleQuit);
         this.play.addEventListener(SIGNAL_GAME_GOTO_MAIN,this.handleAbortAndGotoMain);
         this.play.addEventListener(SIGNAL_TUTORIAL_END,this.handleTutorialEnd);
         this.over.addEventListener(SIGNAL_GAME_OVER_CONTINUE,this.HandleGameOverContinue);
         this.mStateMachine.bindState(STATE_GAME_RESET,this.reset);
         this.mStateMachine.bindState(STATE_GAME_PLAY,this.play);
         this.mStateMachine.bindState(STATE_GAME_OVER,this.over);
      }
      
      public function update() : void
      {
         this.mStateMachine.getCurrentState().update();
         if(!this._app.isLQMode)
         {
            this._mainWidget.game.board.compliments.Update();
            this._mainWidget.game.board.checkerboard.Update();
         }
         this._mainWidget.game.board.blipLayer.Update();
         this._mainWidget.game.blazingSpeedWidget.Update();
      }
      
      public function draw(param1:int) : void
      {
         this.mStateMachine.getCurrentState().draw(param1);
         if(this._app.isLQMode)
         {
         }
      }
      
      public function onEnter() : void
      {
         if(this._app.isMultiplayerGame() && this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) >= 1)
         {
            PartyServerIO.sendStartParty(this._app.party.getPartyData().partyID);
         }
         this._mainWidget.PlayMode(true);
         this._mainWidget.game.Show();
         this._app.network.PlayGame();
         this._mainWidget.game.reset();
         if(this._app.tutorial.IsComplete())
         {
            if(this._app.logic.IsDailyChallengeGame())
            {
               this._mainWidget.game.showDailyChallengeCover(true);
            }
            else
            {
               this._mainWidget.game.showDailyChallengeCover(false);
            }
         }
         this._app.ui.stage.focus = this._app.ui.stage;
         this._mainWidget.boostDialog.visible = false;
         this._mainWidget.rareGemDialog.visible = false;
         this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
      }
      
      public function onExit() : void
      {
         this.mStateMachine.getCurrentState().onExit();
         this._mainWidget.PlayMode(false);
      }
      
      private function switchAndDisplayState(param1:String, param2:DisplayObject) : void
      {
         if(this.mLastDisplayed != null)
         {
            removeChild(this.mLastDisplayed);
         }
         this.mLastDisplayed = param2;
         addChild(this.mLastDisplayed);
         this.mStateMachine.switchState(param1);
      }
      
      private function handleReset(param1:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
      }
      
      private function handleStart(param1:Event) : void
      {
         this._app.fpsMonitor.ResetStats();
         this._app.fpsMonitor.monitorGamePlayFPS = true;
         this.switchAndDisplayState(STATE_GAME_PLAY,this.play);
      }
      
      private function handleEnd(param1:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_OVER,this.over);
      }
      
      private function handleTutorialEnd(param1:Event) : void
      {
         this._app.logic.Quit();
         this._app.sessionData.AbortGame();
         dispatchEvent(new Event(MainState.SIGNAL_QUIT));
      }
      
      private function handleQuit(param1:Event) : void
      {
         this._app.logic.Quit();
         this._app.sessionData.AbortGame();
         this._app.network.AbortGame();
         this._app.questManager.resetDynamicQuests(true);
      }
      
      private function handleAbortAndGotoMain(param1:Event) : void
      {
         this.handleQuit(param1);
         this._app.network.GotoMainMenu();
      }
      
      private function HandleGameOverContinue(param1:Event) : void
      {
         dispatchEvent(new Event(MainState.SIGNAL_QUIT));
      }
      
      public function isCurrentStateGameOver() : Boolean
      {
         return this.mStateMachine.getCurrentStateID() == STATE_GAME_OVER;
      }
   }
}
