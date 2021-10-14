package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.Version;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class GameState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_RESET:String = "State:Game:Reset";
      
      public static const STATE_GAME_PLAY:String = "State:Game:Play";
      
      public static const STATE_GAME_OVER:String = "State:Game:Over";
      
      public static const SIGNAL_GAME_RESET:String = "Signal:GameReset";
      
      public static const SIGNAL_GAME_START:String = "Signal:GameStart";
      
      public static const SIGNAL_GAME_END:String = "Signal:GameEnd";
      
      public static const SIGNAL_GAME_QUIT:String = "Signal:GameQuit";
      
      public static const SIGNAL_GAME_OVER_CONTINUE:String = "Signal:GameOverContinue";
      
      public static const SIGNAL_TUTORIAL_END:String = "Signal:TutorialEnd";
       
      
      public var reset:GameResetState;
      
      public var play:GamePlayState;
      
      public var over:GameOverState;
      
      private var m_App:Blitz3Game;
      
      private var mStateMachine:IAppStateMachine;
      
      private var mLastDisplayed:DisplayObject;
      
      public function GameState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.mStateMachine = new BaseAppStateMachine();
         this.reset = new GameResetState(app);
         this.play = new GamePlayState(app);
         this.over = new GameOverState(app);
         this.reset.addEventListener(SIGNAL_GAME_START,this.handleStart);
         this.play.addEventListener(SIGNAL_GAME_END,this.handleEnd);
         this.play.addEventListener(SIGNAL_GAME_RESET,this.handleReset);
         this.play.addEventListener(SIGNAL_GAME_QUIT,this.handleQuit);
         this.play.addEventListener(SIGNAL_TUTORIAL_END,this.handleTutorialEnd);
         this.over.addEventListener(SIGNAL_GAME_OVER_CONTINUE,this.HandleGameOverContinue);
         this.mStateMachine.bindState(STATE_GAME_RESET,this.reset);
         this.mStateMachine.bindState(STATE_GAME_PLAY,this.play);
         this.mStateMachine.bindState(STATE_GAME_OVER,this.over);
      }
      
      public function update() : void
      {
         this.mStateMachine.getCurrentState().update();
         this.m_App.ui.background.Update();
         this.m_App.ui.game.board.checkerboard.Update();
         this.m_App.ui.game.board.blipLayer.Update();
         this.m_App.ui.game.board.clock.Update();
         this.m_App.ui.game.board.compliments.Update();
         this.m_App.ui.game.board.broadcast.Update();
         this.m_App.ui.game.sidebar.speed.Update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.mStateMachine.getCurrentState().draw(elapsed);
         this.m_App.ui.background.Draw();
         this.m_App.ui.game.sidebar.speed.Draw();
      }
      
      public function onEnter() : void
      {
         var mainWidget:MainWidgetGame = null;
         this.m_App.ui.game.board.visible = true;
         this.m_App.ui.game.sidebar.visible = true;
         this.m_App.network.PlayGame();
         this.m_App.ui.background.Reset();
         this.m_App.ui.game.Reset();
         this.m_App.ui.game.sidebar.boostIcons.Clear();
         this.m_App.ui.game.sidebar.rareGem.Clear();
         mainWidget = this.m_App.ui as MainWidgetGame;
         mainWidget.menu.playButton.mouseEnabled = false;
         mainWidget.menu.playButton.useHandCursor = false;
         this.m_App.ui.stage.focus = this.m_App.ui.stage;
         mainWidget.optionsButton.visible = false;
         mainWidget.boostDialog.visible = false;
         mainWidget.rareGemDialog.visible = false;
         this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
      }
      
      public function onExit() : void
      {
         var mainWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         mainWidget.optionsButton.visible = true;
         this.mStateMachine.getCurrentState().onExit();
      }
      
      public function onKeyUp(keyCode:int) : void
      {
         this.mStateMachine.getCurrentState().onKeyUp(keyCode);
      }
      
      public function onKeyDown(keyCode:int) : void
      {
         this.mStateMachine.getCurrentState().onKeyDown(keyCode);
      }
      
      private function switchAndDisplayState(id:String, state:DisplayObject) : void
      {
         if(this.mLastDisplayed != null)
         {
            removeChild(this.mLastDisplayed);
         }
         this.mLastDisplayed = state;
         addChild(this.mLastDisplayed);
         this.mStateMachine.switchState(id);
      }
      
      private function SubmitStats() : void
      {
         var move:MoveData = null;
         var logic:BlitzLogic = null;
         var stats:Dictionary = null;
         var movesMade:int = 0;
         var goodMovesMade:int = 0;
         var moves:Vector.<MoveData> = this.m_App.logic.moves;
         for each(move in moves)
         {
            if(move.isSwap)
            {
               movesMade++;
               if(move.isSuccessful)
               {
                  goodMovesMade++;
               }
            }
         }
         logic = this.m_App.logic;
         stats = new Dictionary();
         stats["version"] = Version.version;
         stats["isGameOver"] = logic.IsGameOver();
         stats["gameTimePlayed"] = logic.timerLogic.GetTimeElapsed();
         stats["score"] = logic.scoreKeeper.GetScore();
         stats["numGemsCleared"] = logic.board.GetNumGemsCleared();
         stats["flameGemsCreated"] = logic.flameGemLogic.GetNumCreated();
         stats["starGemsCreated"] = logic.starGemLogic.GetNumCreated();
         stats["hypercubesCreated"] = logic.hypercubeLogic.GetNumCreated();
         stats["blazingExplosions"] = logic.blazingSpeedLogic.GetNumExplosions();
         stats["numMoves"] = movesMade;
         stats["numGoodMoves"] = goodMovesMade;
         stats["numMatches"] = logic.GetNumMatches();
         stats["timeUpMultiplier"] = logic.multiLogic.multiplier;
         stats["multiplier"] = logic.multiLogic.numSpawned + 1;
         stats["speedPoints"] = logic.scoreKeeper.GetSpeedPoints();
         stats["speedLevel"] = logic.speedBonus.GetHighestLevel();
         stats["lastHurrahPoints"] = logic.scoreKeeper.GetLastHurrahPoints();
         stats["coinsEarned"] = logic.coinTokenLogic.collected.length;
         stats["fpsAvg"] = this.m_App.fpsMonitor.GetAverageFPS();
         stats["fpsLow"] = this.m_App.fpsMonitor.GetFPSLow();
         stats["fpsHigh"] = this.m_App.fpsMonitor.GetFPSHigh();
         this.m_App.network.SubmitStats(stats);
      }
      
      private function handleReset(e:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
      }
      
      private function handleStart(e:Event) : void
      {
         this.m_App.fpsMonitor.ResetStats();
         this.switchAndDisplayState(STATE_GAME_PLAY,this.play);
      }
      
      private function handleEnd(e:Event) : void
      {
         this.SubmitStats();
         if(Blitz3Game.AUTOPLAY)
         {
            this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
            return;
         }
         this.switchAndDisplayState(STATE_GAME_OVER,this.over);
      }
      
      private function handleTutorialEnd(e:Event) : void
      {
         this.m_App.logic.Quit();
         dispatchEvent(new Event(MainState.SIGNAL_QUIT));
      }
      
      private function handleQuit(e:Event) : void
      {
         this.SubmitStats();
         this.m_App.logic.Quit();
         this.m_App.ui.game.parent.removeChild(this.m_App.ui.game);
         this.m_App.network.AbortGame();
      }
      
      private function HandleGameOverContinue(e:Event) : void
      {
         dispatchEvent(new Event(MainState.SIGNAL_QUIT));
      }
   }
}
