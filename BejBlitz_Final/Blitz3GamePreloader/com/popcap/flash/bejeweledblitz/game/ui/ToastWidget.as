package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ToastWidget extends MovieClip
   {
       
      
      private var _toastClip:ToastClip;
      
      private var _callback:Function;
      
      private var _hideTimer:Timer;
      
      private var _btnToast:GenericButtonClip;
      
      private var _app:Blitz3App;
      
      private var _condition:Function;
      
      private var _isConditionChecking:Boolean;
      
      public function ToastWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._hideTimer = new Timer(5000,1);
         this._hideTimer.addEventListener(TimerEvent.TIMER,this.animateOut);
         this._toastClip = new ToastClip();
         addChild(this._toastClip);
         x = Dimensions.PRELOADER_WIDTH - (this._toastClip.width + 20);
         this._btnToast = new GenericButtonClip(this._app,this._toastClip.toastContent.btn);
         this._btnToast.setShowGraphics(false);
         this._btnToast.setPress(this.onToastPress);
         this._btnToast.setRelease(this.onToastRelease);
         this._btnToast.setRollOver(this.onToastRollOver);
         this._btnToast.setRollOut(this.onToastRollOut);
         this._btnToast.setDragOut(this.onToastRollOut);
         this._toastClip.toastContent.visible = false;
      }
      
      public function queueToast(param1:Function = null, param2:Function = null) : void
      {
         if(this._isConditionChecking)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.checkCondition);
            this._isConditionChecking = false;
         }
         this._condition = param1;
         this._callback = param2;
         if(this._condition != null && !this._condition())
         {
            this.startConditionCheck();
         }
         else
         {
            this.showToast();
         }
      }
      
      private function showToast() : void
      {
         if(this._callback != null)
         {
            this._btnToast.activate();
         }
         this._toastClip.toastContent.gotoAndStop("up");
         this.animateIn();
         this.restartTimer();
      }
      
      private function startConditionCheck() : void
      {
         if(!this._isConditionChecking)
         {
            this._isConditionChecking = true;
            this.addEventListener(Event.ENTER_FRAME,this.checkCondition);
         }
      }
      
      private function checkCondition(param1:Event) : void
      {
         if(this._condition != null && this._condition())
         {
            if(this._isConditionChecking)
            {
               this.removeEventListener(Event.ENTER_FRAME,this.checkCondition);
               this._isConditionChecking = false;
            }
            this.showToast();
         }
      }
      
      private function restartTimer() : void
      {
         this._hideTimer.reset();
         this._hideTimer.start();
      }
      
      private function stopTimer() : void
      {
         this._hideTimer.stop();
      }
      
      private function animateIn() : void
      {
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_MESSAGE_APPEAR);
         Tweener.removeTweens(this._toastClip.toastContent);
         this._toastClip.toastContent.alpha = 0;
         this._toastClip.toastContent.visible = true;
         Tweener.addTween(this._toastClip.toastContent,{
            "time":0.2,
            "x":0,
            "alpha":1
         });
      }
      
      private function animateOut(param1:Event = null) : void
      {
         var _loc2_:Number = this._toastClip.width + 5;
         this._btnToast.deactivate();
         Tweener.removeTweens(this._toastClip.toastContent);
         Tweener.addTween(this._toastClip.toastContent,{
            "time":0.2,
            "x":_loc2_,
            "alpha":0
         });
      }
      
      private function onToastRelease() : void
      {
         this.stopTimer();
         if(this._callback != null)
         {
            this._callback();
         }
         this.animateOut();
      }
      
      private function onToastPress() : void
      {
         this._toastClip.toastContent.gotoAndStop("down");
      }
      
      private function onToastRollOut() : void
      {
         this.restartTimer();
         this._toastClip.toastContent.gotoAndStop("up");
      }
      
      private function onToastRollOver() : void
      {
         this.stopTimer();
         this._toastClip.toastContent.gotoAndStop("over");
      }
   }
}
