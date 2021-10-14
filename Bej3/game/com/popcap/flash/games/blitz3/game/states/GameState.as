package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_HELP:String = "State:Game:Help";
      
      public static const STATE_GAME_RESET:String = "State:Game:Reset";
      
      public static const STATE_GAME_PLAY:String = "State:Game:Play";
      
      public static const STATE_GAME_OVER:String = "State:Game:Over";
      
      public static const SIGNAL_GAME_RESET:String = "Signal:GameReset";
      
      public static const SIGNAL_GAME_START:String = "Signal:GameStart";
      
      public static const SIGNAL_GAME_END:String = "Signal:GameEnd";
      
      public static const SIGNAL_GAME_QUIT:String = "Signal:GameQuit";
      
      public static const SIGNAL_GAME_OVER_CONTINUE:String = "Signal:GameOverContinue";
       
      
      public var help:GameHelpState;
      
      public var reset:GameResetState;
      
      public var play:GamePlayState;
      
      public var over:GameOverState;
      
      private var mApp:Blitz3Game;
      
      private var mStateMachine:IAppStateMachine;
      
      private var mLastDisplayed:DisplayObject;
      
      public function GameState(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.mStateMachine = new BaseAppStateMachine();
         this.help = new GameHelpState(app);
         this.reset = new GameResetState(app);
         this.play = new GamePlayState(app);
         this.over = new GameOverState(app);
         this.help.addEventListener(SIGNAL_GAME_RESET,this.handleReset);
         this.help.addEventListener(SIGNAL_GAME_START,this.handleStart);
         this.reset.addEventListener(SIGNAL_GAME_START,this.handleStart);
         this.play.addEventListener(SIGNAL_GAME_END,this.handleEnd);
         this.play.addEventListener(SIGNAL_GAME_RESET,this.handleReset);
         this.play.addEventListener(SIGNAL_GAME_QUIT,this.handleQuit);
         this.over.addEventListener(SIGNAL_GAME_OVER_CONTINUE,this.HandleGameOverContinue);
         this.mStateMachine.bindState(STATE_GAME_HELP,this.help);
         this.mStateMachine.bindState(STATE_GAME_RESET,this.reset);
         this.mStateMachine.bindState(STATE_GAME_PLAY,this.play);
         this.mStateMachine.bindState(STATE_GAME_OVER,this.over);
      }
      
      public function update() : void
      {
         this.mStateMachine.getCurrentState().update();
         this.mApp.ui.game.background.Update();
         this.mApp.ui.game.board.checkerboard.Update();
         this.mApp.ui.game.board.blipLayer.Update();
         this.mApp.ui.game.board.clock.Update();
         this.mApp.ui.game.board.compliments.Update();
         this.mApp.ui.game.board.broadcast.Update();
         this.mApp.ui.game.sidebar.speed.Update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.mStateMachine.getCurrentState().draw(elapsed);
         this.mApp.ui.game.sidebar.buttons.menuButton.Draw();
         this.mApp.ui.game.sidebar.buttons.hintButton.Draw();
         this.mApp.ui.game.background.Draw();
         this.mApp.ui.game.board.checkerboard.Draw();
         this.mApp.ui.game.board.blipLayer.Draw();
         this.mApp.ui.game.board.clock.Draw();
         this.mApp.ui.game.board.compliments.Draw();
         this.mApp.ui.game.sidebar.speed.Draw();
      }
      
      public function onEnter() : void
      {
         this.mApp.ui.game.background.resetBackgrounds();
         this.mApp.network.PlayGame();
         this.mApp.ui.game.Reset();
         this.mApp.ui.game.sidebar.boostIcons.Clear();
         this.mApp.ui.game.sidebar.rareGem.Clear();
         this.mApp.ui.menu.playButton.mouseEnabled = false;
         this.mApp.ui.menu.playButton.useHandCursor = false;
         this.mApp.ui.stage.focus = this.mApp.ui.stage;
         this.mApp.ui.game.board.visible = true;
         this.mApp.ui.game.sidebar.visible = true;
         this.help.ForceHelp(true);
         this.switchAndDisplayState(STATE_GAME_HELP,this.help);
      }
      
      public function onExit() : void
      {
         this.mStateMachine.getCurrentState().onExit();
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
         this.mStateMachine.getCurrentState().onMouseUp(x,y);
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
         this.mStateMachine.getCurrentState().onMouseDown(x,y);
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
         this.mStateMachine.getCurrentState().onMouseMove(x,y);
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
         addChild(state);
         this.mStateMachine.switchState(id);
      }
      
      private function SubmitStats() : void
      {
         var move:MoveData = null;
         var logic:BlitzLogic = null;
         var stats:Object = null;
         var movesMade:int = 0;
         var goodMovesMade:int = 0;
         var moves:Vector.<MoveData> = this.mApp.logic.moves;
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
         logic = this.mApp.logic;
         stats = new Object();
         stats["isGameOver"] = logic.IsGameOver();
         stats["gameTimePlayed"] = logic.timerLogic.GetTimeElapsed();
         stats["score"] = logic.GetScore();
         stats["numGemsCleared"] = logic.board.GetNumGemsCleared();
         stats["flameGemsCreated"] = logic.flameGemLogic.numCreated;
         stats["starGemsCreated"] = logic.starGemLogic.numCreated;
         stats["hypercubesCreated"] = logic.hypercubeLogic.numCreated;
         stats["blazingExplosions"] = logic.blazingSpeedBonus.GetNumExplosions();
         stats["numMoves"] = movesMade;
         stats["numGoodMoves"] = goodMovesMade;
         stats["numMatches"] = logic.numMatches;
         stats["timeUpMultiplier"] = logic.multiLogic.multiplier;
         stats["multiplier"] = logic.multiLogic.numSpawned + 1;
         stats["speedPoints"] = logic.scoreKeeper.GetSpeedPoints();
         stats["speedLevel"] = logic.speedBonus.GetHighestLevel();
         stats["lastHurrahPoints"] = logic.scoreKeeper.GetLastHurrahPoints();
         stats["coinsEarned"] = logic.coinTokenLogic.collected.length;
         stats["fpsAvg"] = this.mApp.fpsMonitor.GetAverageFPS();
         stats["fpsLow"] = this.mApp.fpsMonitor.GetFPSLow();
         stats["fpsHigh"] = this.mApp.fpsMonitor.GetFPSHigh();
         this.mApp.network.SubmitStats(stats);
      }
      
      private function handleReset(e:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_RESET,this.reset);
      }
      
      private function handleStart(e:Event) : void
      {
         this.mApp.fpsMonitor.ResetStats();
         this.switchAndDisplayState(STATE_GAME_PLAY,this.play);
      }
      
      private function handleEnd(e:Event) : void
      {
         this.switchAndDisplayState(STATE_GAME_OVER,this.over);
      }
      
      private function handleQuit(e:Event) : void
      {
         this.mApp.network.AbortGame(0);
         dispatchEvent(new Event(MainState.SIGNAL_QUIT));
      }
      
      private function HandleGameOverContinue(e:Event) : void
      {
         dispatchEvent(new Event(MainState.SIGNAL_QUIT));
      }
   }
}
