package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ReplayOverState extends Sprite implements IAppState
   {
      
      private static const DELAY_TIME:int = 260;
       
      
      protected var _app:Blitz3Game;
      
      private var _mDelayTimer:int = 0;
      
      private var _delaySet:Boolean = false;
      
      private var _replayEndDialog:TwoButtonDialog;
      
      private var _isReplayComplete:Boolean;
      
      public function ReplayOverState(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._replayEndDialog = new TwoButtonDialog(param1);
         this._replayEndDialog.visible = false;
         this._replayEndDialog.AddAcceptButtonHandler(this.handleGotoMainMenu);
         this._replayEndDialog.AddDeclineButtonHandler(this.handleRestartReplay);
         this._replayEndDialog.Init();
         this._replayEndDialog.SetDimensions(320,250);
         addChild(this._replayEndDialog);
      }
      
      public function update() : void
      {
         if(!this._delaySet)
         {
            this._mDelayTimer = DELAY_TIME;
            this._delaySet = true;
         }
         else
         {
            --this._mDelayTimer;
         }
         if(this._mDelayTimer < 0 && !this._isReplayComplete)
         {
            this.showReplayCompleteDialog();
            this._isReplayComplete = true;
         }
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this._mDelayTimer = 0;
         this._isReplayComplete = false;
      }
      
      private function showReplayCompleteDialog() : void
      {
         this._replayEndDialog.SetContent("REPLAY COMPLETE","Do you want to watch the replay again?","CLOSE","Watch again");
         this._replayEndDialog.visible = true;
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this._replayEndDialog,true,true,0.55);
      }
      
      public function onExit() : void
      {
      }
      
      private function handleGotoMainMenu(param1:MouseEvent) : void
      {
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-Close_ReplayComplete",true);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         dispatchEvent(new Event(ReplayState.SIGNAL_REPLAY_OVER_CONTINUE));
      }
      
      private function handleRestartReplay(param1:MouseEvent) : void
      {
         this._app.sessionData.replayManager.SendReplayTAPIEvent("WR-Replay_ReplayComplete",true);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         (this._app as Blitz3Game).mainState.replay.resetAndStartReplay(param1);
      }
   }
}
