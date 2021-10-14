package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.FriendPopupServerIO;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.party.PartyServerIO;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GameOverState extends Sprite implements IAppState
   {
      
      public static const STATE_GAME_OVER_INFO:String = "State:Game:Over:Info";
      
      public static const SIGNAL_GAME_OVER_INFO_CONTINUE:String = "Signal:GameOverInfoContinue";
       
      
      protected var _app:Blitz3Game;
      
      protected var _stateMachine:IAppStateMachine;
      
      protected var _isActive:Boolean;
      
      public var info:GameOverInfoState;
      
      public var boost:PreGameMenuBoostState;
      
      public var postCheck:PreGameMenuCheckState;
      
      public function GameOverState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._stateMachine = new BaseAppStateMachine();
         this.info = new GameOverInfoState(param1);
         this.info.addEventListener(SIGNAL_GAME_OVER_INFO_CONTINUE,this.HandleInfoContinue);
         this._stateMachine.bindState(STATE_GAME_OVER_INFO,this.info);
      }
      
      public function Reset() : void
      {
      }
      
      public function update() : void
      {
         if(this._stateMachine.getCurrentState() != null)
         {
            this._stateMachine.getCurrentState().update();
         }
      }
      
      public function draw(param1:int) : void
      {
         if(this._stateMachine.getCurrentState() != null)
         {
            this._stateMachine.getCurrentState().draw(param1);
         }
      }
      
      public function onEnter() : void
      {
         this._isActive = true;
         if(this._app.isMultiplayerGame())
         {
            FriendPopupServerIO.showPopup(this._app,FriendPopupServerIO.INDEX_ON_PARTY_COMPLETE);
            PartyServerIO.reset();
            if(this._app.sessionData.configManager.GetInt(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL) > 0)
            {
               this._app.metaUI.highlight.showLoadingWheel();
               PartyServerIO.reset();
               PartyServerIO.setFinishPartyCallback(this.onMultiplayerFinish);
               PartyServerIO.sendFinishParty();
            }
            else
            {
               this.onMultiplayerFinish();
            }
         }
         else if(this._app.isDailyChallengeGame())
         {
            this._app.network.ShowDraperInterstitial();
            this._app.mainState.gotoDailyChallenges();
            (this._app.ui as MainWidgetGame).menu.enablePurchaseButtons(false);
         }
         else
         {
            this.showGameOver();
         }
      }
      
      private function onMultiplayerFinish() : void
      {
         this._app.metaUI.highlight.stopNetworkTimeoutDialog();
         this._app.metaUI.highlight.Hide(true);
         if(this._app.party.getPartyData().getOpponentPartyPlayerData().isFinalized)
         {
            this._app.party.setStatusDoneCallback(this._app.party.showResultsState);
         }
         else
         {
            this._app.party.setStatusDoneCallback(this.showGameOver);
         }
         this._app.party.showStatusState();
      }
      
      public function showGameOver() : void
      {
         this._stateMachine.switchState(STATE_GAME_OVER_INFO);
      }
      
      public function onExit() : void
      {
         this._app.sessionData.finisherManager.Reset();
         this._app.questManager.UpdateQuestCompletion("onGameOverExit");
         if(this._stateMachine.getCurrentState() != null)
         {
            this._stateMachine.getCurrentState().onExit();
         }
         this._isActive = false;
      }
      
      protected function HandleInfoContinue(param1:Event) : void
      {
         dispatchEvent(new Event(GameState.SIGNAL_GAME_OVER_CONTINUE));
      }
   }
}
