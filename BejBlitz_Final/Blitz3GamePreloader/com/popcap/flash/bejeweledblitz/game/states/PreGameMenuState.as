package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.IGotoBoostScreenHandler;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuState extends Sprite implements IAppState, IGotoBoostScreenHandler
   {
      
      public static const STATE_PREGAME_QUEST:String = "State:PreGame:Quest";
      
      public static const STATE_PREGAME_RARE_GEM:String = "State:PreGame:RareGem";
      
      public static const STATE_PREGAME_PREBOOST_CHECK:String = "State:PreGame:PreBoostCheck";
      
      public static const STATE_PREGAME_BOOST:String = "State:PreGame:Boost";
      
      public static const STATE_PREGAME_CHECK:String = "State:PreGame:Check";
      
      public static const SIGNAL_PREGAME_GOTO_BOOSTS_SCREEN:String = "Signal:PreGame:GotoBoostsScreen";
      
      public static const SIGNAL_PREGAME_QUEST_CONTINUE:String = "Signal:PreGameQuestContinue";
      
      public static const SIGNAL_PREGAME_RARE_GEM_CONTINUE:String = "Signal:PreGameRareGemContinue";
      
      public static const SIGNAL_PREGAME_PREBOOST_CHECK_SUCCESS:String = "Signal:PreGamePreBoostCheckSuccess";
      
      public static const SIGNAL_PREGAME_PREBOOST_CHECK_FAILURE:String = "Signal:PreGamePreBoostCheckFailure";
      
      public static const SIGNAL_PREGAME_BOOST_CONTINUE:String = "Signal:PreGameBoostContinue";
      
      public static const SIGNAL_PREGAME_CHECK_SUCCESS:String = "Signal:PreGameCheckSuccess";
      
      public static const SIGNAL_PREGAME_CHECK_FAILURE:String = "Signal:PreGameCheckFailure";
       
      
      private var _app:Blitz3Game;
      
      private var _stateMachine:IAppStateMachine;
      
      private var _isActive:Boolean;
      
      private var _isSessionDataAvailable:Boolean;
      
      private var _isBoostDataValidated:Boolean;
      
      private var _hasPreGameCheckSucceeded:Boolean;
      
      private var _isStartGameSignalSent:Boolean;
      
      private var _shouldGotoBoostsScreen:Boolean;
      
      public var quest:PreGameMenuQuestState;
      
      public var rareGem:PreGameMenuRareGemState;
      
      public var preBoostCheck:PreGameMenuPreBoostCheckState;
      
      public var boost:PreGameMenuBoostState;
      
      public var check:PreGameMenuCheckState;
      
      public var gotoBoostState:PreGameGotoBoostState;
      
      public function PreGameMenuState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._stateMachine = new BaseAppStateMachine();
         this.quest = new PreGameMenuQuestState(param1);
         this.rareGem = new PreGameMenuRareGemState(param1);
         this.preBoostCheck = new PreGameMenuPreBoostCheckState(param1);
         this.boost = new PreGameMenuBoostState(param1);
         this.check = new PreGameMenuCheckState(param1);
         this.gotoBoostState = new PreGameGotoBoostState(param1);
         this.quest.addEventListener(SIGNAL_PREGAME_QUEST_CONTINUE,this.HandleQuestContinue);
         this.rareGem.addEventListener(SIGNAL_PREGAME_RARE_GEM_CONTINUE,this.HandleRareGemContinue);
         this.preBoostCheck.addEventListener(SIGNAL_PREGAME_PREBOOST_CHECK_SUCCESS,this.HandlePreGamePreBoostCheckSuccess);
         this.preBoostCheck.addEventListener(SIGNAL_PREGAME_PREBOOST_CHECK_FAILURE,this.HandlePreGamePreBoostCheckFailure);
         this.boost.addEventListener(SIGNAL_PREGAME_BOOST_CONTINUE,this.HandleBoostContinue);
         this.check.addEventListener(SIGNAL_PREGAME_CHECK_SUCCESS,this.HandlePreGameCheckSuccess);
         this.check.addEventListener(SIGNAL_PREGAME_CHECK_FAILURE,this.HandlePreGameCheckFailue);
         this.gotoBoostState.addEventListener(SIGNAL_PREGAME_BOOST_CONTINUE,this.HandleBoostContinue);
         this._app.network.AddGotoBoostScreenHandler(this);
         this._stateMachine.bindState(STATE_PREGAME_QUEST,this.quest);
         this._stateMachine.bindState(STATE_PREGAME_RARE_GEM,this.rareGem);
         this._stateMachine.bindState(STATE_PREGAME_PREBOOST_CHECK,this.preBoostCheck);
         this._stateMachine.bindState(STATE_PREGAME_BOOST,this.boost);
         this._stateMachine.bindState(STATE_PREGAME_CHECK,this.check);
         this._stateMachine.bindState(SIGNAL_PREGAME_GOTO_BOOSTS_SCREEN,this.gotoBoostState);
      }
      
      public function update() : void
      {
         if(this._stateMachine.getCurrentState() != null)
         {
            this._stateMachine.getCurrentState().update();
         }
         this._app.metaUI.Update();
         (this._app.ui as MainWidgetGame).game.dailyChallengeLeaderboardAndQuestsCoverView.UpdateScore(this._app.logic.GetScoreKeeper().GetScore());
         if(this._hasPreGameCheckSucceeded && this._isSessionDataAvailable && this._isBoostDataValidated)
         {
            this._app.metaUI.highlight.hidePopUp();
            if(!this._isStartGameSignalSent)
            {
               this._isStartGameSignalSent = true;
               dispatchEvent(new Event(MainState.SIGNAL_PLAY));
            }
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
         this._isSessionDataAvailable = false;
         this._hasPreGameCheckSucceeded = false;
         this._isStartGameSignalSent = false;
         SpinBoardUIController.GetInstance().CloseSpinBoard();
         (this._app.ui as MainWidgetGame).game.reset();
         this._app.sessionData.rareGemManager.GetCurrentOffer().evaluateAvailable();
         (this._app.ui as MainWidgetGame).game.Hide();
         if(this._shouldGotoBoostsScreen)
         {
            this._stateMachine.switchState(SIGNAL_PREGAME_GOTO_BOOSTS_SCREEN);
         }
         else
         {
            this._stateMachine.switchState(STATE_PREGAME_QUEST);
         }
      }
      
      public function onExit() : void
      {
         this._app.ui.stage.focus = this._app.ui.stage;
         this._stateMachine.getCurrentState().onExit();
         this._isActive = false;
         this._shouldGotoBoostsScreen = false;
      }
      
      public function HandleGotoBoostScreen(param1:Boolean) : void
      {
         this._shouldGotoBoostsScreen = param1;
      }
      
      private function HandleQuestContinue(param1:Event) : void
      {
         var _loc2_:RareGemOffer = null;
         if(!this._app.metaUI.questReward.HasMoreToShow())
         {
            if(this._app.isMultiplayerGame() && !this._app.party.isDoneWithPartyTutorial())
            {
               this._stateMachine.switchState(STATE_PREGAME_BOOST);
            }
            else
            {
               _loc2_ = this._app.sessionData.rareGemManager.GetCurrentOffer();
               if(_loc2_.isAvailable())
               {
                  this._stateMachine.switchState(STATE_PREGAME_RARE_GEM);
               }
               else
               {
                  this._stateMachine.switchState(STATE_PREGAME_BOOST);
               }
            }
         }
      }
      
      private function OnSeedDataGot(param1:Event) : void
      {
         this._isSessionDataAvailable = true;
         this._app.network.removeEventListener(Blitz3Network.EVENT_GOT_SEED_DATA,this.OnSeedDataGot);
         this._isBoostDataValidated = false;
         this._app.network.addEventListener(Blitz3Network.EVENT_GOT_BOOST_RESPONSE,this.OnBoostResponseReceived);
         this._app.network.VerifyBoostsInformation();
      }
      
      private function OnBoostResponseReceived(param1:Event) : void
      {
         this._app.network.removeEventListener(Blitz3Network.EVENT_GOT_BOOST_RESPONSE,this.OnBoostResponseReceived);
         this._isBoostDataValidated = true;
      }
      
      private function HandleRareGemContinue(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_PREGAME_PREBOOST_CHECK);
      }
      
      private function HandlePreGamePreBoostCheckSuccess(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_PREGAME_BOOST);
      }
      
      private function HandlePreGamePreBoostCheckFailure(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_PREGAME_RARE_GEM);
      }
      
      private function HandleBoostContinue(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_PREGAME_CHECK);
      }
      
      private function HandlePreGameCheckSuccess(param1:Event) : void
      {
         if(!this._hasPreGameCheckSucceeded)
         {
            this._hasPreGameCheckSucceeded = true;
            if(!this._isSessionDataAvailable)
            {
               this._app.network.addEventListener(Blitz3Network.EVENT_GOT_SEED_DATA,this.OnSeedDataGot);
               this._app.network.requestSeedData();
               this._app.metaUI.highlight.showLoadingWheel();
            }
            else if(!this._isStartGameSignalSent)
            {
               this._isStartGameSignalSent = true;
               dispatchEvent(new Event(MainState.SIGNAL_PLAY));
            }
         }
      }
      
      private function HandlePreGameCheckFailue(param1:Event) : void
      {
         this._stateMachine.switchState(STATE_PREGAME_BOOST);
      }
   }
}
