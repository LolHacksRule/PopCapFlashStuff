package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.BaseAppStateMachine;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.IAppStateMachine;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuState extends Sprite implements IAppState
   {
      
      public static const STATE_PREGAME_RARE_GEM:String = "State:PreGame:RareGem";
      
      public static const STATE_PREGAME_PREBOOST_CHECK:String = "State:PreGame:PreBoostCheck";
      
      public static const STATE_PREGAME_BOOST:String = "State:PreGame:Boost";
      
      public static const STATE_PREGAME_CHECK:String = "State:PreGame:Check";
      
      public static const SIGNAL_PREGAME_RARE_GEM_CONTINUE:String = "Signal:PreGameRareGemContinue";
      
      public static const SIGNAL_PREGAME_PREBOOST_CHECK_SUCCESS:String = "Signal:PreGamePreBoostCheckSuccess";
      
      public static const SIGNAL_PREGAME_PREBOOST_CHECK_FAILURE:String = "Signal:PreGamePreBoostCheckFailure";
      
      public static const SIGNAL_PREGAME_BOOST_CONTINUE:String = "Signal:PreGameBoostContinue";
      
      public static const SIGNAL_PREGAME_CHECK_SUCCESS:String = "Signal:PreGameCheckSuccess";
      
      public static const SIGNAL_PREGAME_CHECK_FAILURE:String = "Signal:PreGameCheckFailure";
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_StateMachine:IAppStateMachine;
      
      protected var m_IsActive:Boolean;
      
      public var rareGem:PreGameMenuRareGemState;
      
      public var preBoostCheck:PreGameMenuPreBoostCheckState;
      
      public var boost:PreGameMenuBoostState;
      
      public var check:PreGameMenuCheckState;
      
      public function PreGameMenuState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_StateMachine = new BaseAppStateMachine();
         this.rareGem = new PreGameMenuRareGemState(app);
         this.preBoostCheck = new PreGameMenuPreBoostCheckState(app);
         this.boost = new PreGameMenuBoostState(app);
         this.check = new PreGameMenuCheckState(app);
         this.rareGem.addEventListener(SIGNAL_PREGAME_RARE_GEM_CONTINUE,this.HandleRareGemContinue);
         this.preBoostCheck.addEventListener(SIGNAL_PREGAME_PREBOOST_CHECK_SUCCESS,this.HandlePreGamePreBoostCheckSuccess);
         this.preBoostCheck.addEventListener(SIGNAL_PREGAME_PREBOOST_CHECK_FAILURE,this.HandlePreGamePreBoostCheckFailure);
         this.boost.addEventListener(SIGNAL_PREGAME_BOOST_CONTINUE,this.HandleBoostContinue);
         this.check.addEventListener(SIGNAL_PREGAME_CHECK_SUCCESS,this.HandlePreGameCheckSuccess);
         this.check.addEventListener(SIGNAL_PREGAME_CHECK_FAILURE,this.HandlePreGameCheckFailue);
         this.m_StateMachine.bindState(STATE_PREGAME_RARE_GEM,this.rareGem);
         this.m_StateMachine.bindState(STATE_PREGAME_PREBOOST_CHECK,this.preBoostCheck);
         this.m_StateMachine.bindState(STATE_PREGAME_BOOST,this.boost);
         this.m_StateMachine.bindState(STATE_PREGAME_CHECK,this.check);
      }
      
      public function update() : void
      {
         this.m_StateMachine.getCurrentState().update();
      }
      
      public function draw(elapsed:int) : void
      {
         this.m_StateMachine.getCurrentState().draw(elapsed);
      }
      
      public function onEnter() : void
      {
         this.m_IsActive = true;
         this.m_App.ui.game.board.visible = false;
         this.m_App.ui.game.sidebar.visible = false;
         this.m_App.ui.optionsButton.visible = true;
         if(this.m_App.sessionData.rareGemManager.ShouldAwardRareGem())
         {
            this.m_StateMachine.switchState(STATE_PREGAME_RARE_GEM);
         }
         else
         {
            this.m_StateMachine.switchState(STATE_PREGAME_BOOST);
         }
      }
      
      public function onExit() : void
      {
         this.m_App.ui.stage.focus = this.m_App.ui.stage;
         this.m_App.ui.game.board.visible = true;
         this.m_App.ui.game.sidebar.visible = true;
         this.m_StateMachine.getCurrentState().onExit();
         this.m_IsActive = false;
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
         this.m_StateMachine.getCurrentState().onMouseUp(x,y);
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
         this.m_StateMachine.getCurrentState().onMouseDown(x,y);
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
         this.m_StateMachine.getCurrentState().onMouseMove(x,y);
      }
      
      public function onKeyUp(keyCode:int) : void
      {
         this.m_StateMachine.getCurrentState().onKeyUp(keyCode);
      }
      
      public function onKeyDown(keyCode:int) : void
      {
         this.m_StateMachine.getCurrentState().onKeyDown(keyCode);
      }
      
      protected function HandleRareGemContinue(event:Event) : void
      {
         this.m_StateMachine.switchState(STATE_PREGAME_PREBOOST_CHECK);
      }
      
      protected function HandlePreGamePreBoostCheckSuccess(event:Event) : void
      {
         this.m_StateMachine.switchState(STATE_PREGAME_BOOST);
      }
      
      protected function HandlePreGamePreBoostCheckFailure(event:Event) : void
      {
         this.m_StateMachine.switchState(STATE_PREGAME_RARE_GEM);
      }
      
      protected function HandleBoostContinue(event:Event) : void
      {
         this.m_StateMachine.switchState(STATE_PREGAME_CHECK);
      }
      
      protected function HandlePreGameCheckSuccess(event:Event) : void
      {
         dispatchEvent(new Event(MainState.SIGNAL_PLAY));
      }
      
      protected function HandlePreGameCheckFailue(event:Event) : void
      {
         this.m_StateMachine.switchState(STATE_PREGAME_BOOST);
      }
   }
}
