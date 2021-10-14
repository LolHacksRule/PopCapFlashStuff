package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class GenericButtonClip
   {
      
      private static const _DEFAULT_REPEATER_WAIT:Number = 500;
      
      private static const _DEFAULT_REPEATER_INTERVAL:Number = 10;
       
      
      private var _app:Blitz3App;
      
      private var _clipListener:MovieClip;
      
      private var _isActive:Boolean = false;
      
      private var _isDown:Boolean = false;
      
      private var _showGraphics:Boolean = true;
      
      private var _isAnimated:Boolean = false;
      
      private var _rolloverAudio:String = "SOUND_BLITZ3GAME_BUTTON_OVER";
      
      private var _pressAudio:String = "SOUND_BLITZ3GAME_GENERIC_TAP";
      
      private var _releaseAudio:String = "SOUND_BLITZ3GAME_BUTTON_RELEASE";
      
      private var _dragOutCallback:Function;
      
      private var _dragOverCallback:Function;
      
      private var _pressCallback:Function;
      
      private var _releaseCallback:Function;
      
      private var _releaseOutsideCallback:Function;
      
      private var _rollOutCallback:Function;
      
      private var _rollOverCallback:Function;
      
      private var _mouseMoveCallback:Function;
      
      private var _enterCallback:Function;
      
      private var _escCallback:Function;
      
      private var _holdRepeaterCallback:Function;
      
      private var _wheelCallback:Function;
      
      private var _keyCallback:Function;
      
      private var _dragOutParam:Object;
      
      private var _dragOverParam:Object;
      
      private var _pressParam:Object;
      
      private var _releaseParam:Object;
      
      private var _releaseOutsideParam:Object;
      
      private var _rollOutParam:Object;
      
      private var _rollOverParam:Object;
      
      private var _mouseMoveParam:Object;
      
      private var _enterParam:Object;
      
      private var _escParam:Object;
      
      private var _holdRepeaterParam:Object;
      
      private var _wheelParam:Object;
      
      private var _keyParam:Object;
      
      private var _keyNum:uint = 0;
      
      private var _holdRepeaterWait:Number = 500;
      
      private var _holdRepeaterInterval:Number = 10;
      
      private var _holdRepeaterTimer:Timer;
      
      private var _holdRepeaterElapsed:Number;
      
      private var _stopImmediatePropagation:Boolean = false;
      
      private var _allowMouseChildren:Boolean = false;
      
      private var _isDisabled:Boolean = false;
      
      private var _ignoreHover:Boolean = false;
      
      private var _ignoreClick:Boolean = false;
      
      public function GenericButtonClip(param1:Blitz3App, param2:MovieClip, param3:Boolean = false, param4:Boolean = false)
      {
         super();
         if(param1 != null)
         {
            this._app = param1;
         }
         this._clipListener = param2;
         this._isAnimated = param3;
         this._allowMouseChildren = param4;
         if(this._clipListener != null)
         {
            if(this._clipListener.getChildByName("hitBox") != null)
            {
               this._clipListener.hitArea = this._clipListener.hitBox;
            }
            this._clipListener.stop();
            this._clipListener.addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
            this._clipListener.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         }
      }
      
      public function set clipListener(param1:MovieClip) : void
      {
         var _loc2_:Boolean = this._isActive;
         if(this._clipListener != null)
         {
            this._clipListener.stop();
            if(this._isActive)
            {
               this.deactivate();
            }
            this._clipListener.removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
            this._clipListener.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         }
         this._clipListener = param1;
         if(this._clipListener != null)
         {
            if(this._clipListener.getChildByName("hitBox") != null)
            {
               this._clipListener.hitArea = this._clipListener.hitBox;
            }
            this._clipListener.stop();
            this._clipListener.addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
            this._clipListener.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         }
         if(_loc2_)
         {
            this.activate();
         }
      }
      
      public function get clipListener() : MovieClip
      {
         return this._clipListener;
      }
      
      public function isActive() : Boolean
      {
         return this._isActive && !this._isDisabled;
      }
      
      public function hide() : void
      {
         if(this._clipListener != null && this._clipListener.visible)
         {
            this._clipListener.visible = false;
         }
      }
      
      public function show() : void
      {
         if(this._clipListener != null && !this._clipListener.visible)
         {
            this._clipListener.visible = true;
         }
      }
      
      public function IsVisible() : Boolean
      {
         if(this._clipListener != null)
         {
            return this._clipListener.visible;
         }
         return false;
      }
      
      public function setRolloverAudio(param1:String) : void
      {
         this._rolloverAudio = param1;
      }
      
      public function setPressAudio(param1:String) : void
      {
         this._pressAudio = param1;
      }
      
      public function setReleaseAudio(param1:String) : void
      {
         this._releaseAudio = param1;
      }
      
      public function setStopPropagation(param1:Boolean) : void
      {
         this._stopImmediatePropagation = param1;
      }
      
      public function clearAudio() : void
      {
         this.setRolloverAudio("");
         this.setPressAudio("");
         this.setReleaseAudio("");
      }
      
      public function setDragOut(param1:Function, param2:Object = null) : void
      {
         this._dragOutCallback = param1;
         if(param2 != null)
         {
            this._dragOutParam = param2;
         }
      }
      
      public function setDragOver(param1:Function, param2:Object = null) : void
      {
         this._dragOverCallback = param1;
         if(param2 != null)
         {
            this._dragOverParam = param2;
         }
      }
      
      public function setPress(param1:Function, param2:Object = null) : void
      {
         this._pressCallback = param1;
         if(param2 != null)
         {
            this._pressParam = param2;
         }
      }
      
      public function setRelease(param1:Function, param2:Object = null) : void
      {
         this._releaseCallback = param1;
         if(param2 != null)
         {
            this._releaseParam = param2;
         }
      }
      
      public function setReleaseOutside(param1:Function, param2:Object = null) : void
      {
         this._releaseOutsideCallback = param1;
         if(param2 != null)
         {
            this._releaseOutsideParam = param2;
         }
      }
      
      public function setRollOut(param1:Function, param2:Object = null) : void
      {
         this._rollOutCallback = param1;
         if(param2 != null)
         {
            this._rollOutParam = param2;
         }
      }
      
      public function setRollOver(param1:Function, param2:Object = null) : void
      {
         this._rollOverCallback = param1;
         if(param2 != null)
         {
            this._rollOverParam = param2;
         }
      }
      
      public function setMouseMove(param1:Function, param2:Object = null) : void
      {
         this._mouseMoveCallback = param1;
         if(param2 != null)
         {
            this._mouseMoveParam = param2;
         }
      }
      
      public function setEnter(param1:Function, param2:Object = null) : void
      {
         this._enterCallback = param1;
         if(param2 != null)
         {
            this._enterParam = param2;
         }
      }
      
      public function setEsc(param1:Function, param2:Object = null) : void
      {
         this._escCallback = param1;
         if(param2 != null)
         {
            this._escParam = param2;
         }
      }
      
      public function setRepeater(param1:Function, param2:Object = null, param3:Number = 500, param4:Number = 10) : void
      {
         this._holdRepeaterCallback = param1;
         if(param2 != null)
         {
            this._holdRepeaterParam = param2;
         }
         this._holdRepeaterWait = param3;
         this._holdRepeaterInterval = param4;
      }
      
      public function setWheel(param1:Function, param2:Object = null) : void
      {
         this._wheelCallback = param1;
         if(param2 != null)
         {
            this._wheelParam = param2;
         }
      }
      
      public function setKey(param1:uint, param2:Function, param3:Object = null) : void
      {
         this._keyNum = param1;
         this._keyCallback = param2;
         if(param3 != null)
         {
            this._keyParam = param3;
         }
      }
      
      public function clearKey() : void
      {
         this._keyNum = 0;
         this._keyCallback = null;
         this._keyParam = null;
      }
      
      public function setShowGraphics(param1:Boolean) : void
      {
         this._showGraphics = param1;
      }
      
      public function activate() : void
      {
         if(!this._isActive)
         {
            this._isActive = true;
            this._isDown = false;
            this._clipListener.tabEnabled = false;
            this._clipListener.tabChildren = false;
            this._clipListener.mouseChildren = this._allowMouseChildren;
            this._clipListener.mouseEnabled = true;
            this._clipListener.buttonMode = true;
            this._holdRepeaterTimer = new Timer(this._holdRepeaterWait);
            this._holdRepeaterTimer.addEventListener(TimerEvent.TIMER,this.timerListener);
            this._clipListener.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverListener);
            this._clipListener.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownListener);
            this._clipListener.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpListener);
            this._clipListener.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutListener);
            this._clipListener.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelListener);
            if(this._clipListener.stage)
            {
               this._clipListener.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
            }
         }
      }
      
      public function deactivate() : void
      {
         if(this._isActive)
         {
            this._isActive = false;
            try
            {
               this._clipListener.buttonMode = false;
               this._clipListener.mouseChildren = false;
               this._clipListener.mouseEnabled = false;
               this._holdRepeaterTimer.stop();
               this._holdRepeaterTimer.removeEventListener(TimerEvent.TIMER,this.timerListener);
               this._holdRepeaterTimer = null;
               this._clipListener.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOverListener);
               this._clipListener.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownListener);
               this._clipListener.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpListener);
               this._clipListener.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOutListener);
               this._clipListener.removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelListener);
               if(this._clipListener.stage)
               {
                  this._clipListener.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveListener);
                  this._clipListener.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownListener);
                  this._clipListener.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpListener);
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function SetDisabled(param1:Boolean) : void
      {
         var _loc2_:int = -1;
         this._isDisabled = param1;
         this._clipListener.useHandCursor = !this._isDisabled;
         if(this._isDisabled)
         {
            _loc2_ = this.getFrameByLabel("disable");
            if(_loc2_ != -1)
            {
               this._clipListener.gotoAndStop(_loc2_);
            }
         }
         else
         {
            _loc2_ = this.getFrameByLabel("up");
            if(_loc2_ != -1)
            {
               this._clipListener.gotoAndStop("up");
            }
         }
      }
      
      public function IsDisabled() : Boolean
      {
         return this._isDisabled;
      }
      
      private function onAdded(param1:Event) : void
      {
         this.activate();
      }
      
      private function onRemoved(param1:Event) : void
      {
         this.deactivate();
      }
      
      private function timerListener(param1:TimerEvent) : void
      {
         if(this._holdRepeaterCallback != null)
         {
            if(this._holdRepeaterParam != null)
            {
               this._holdRepeaterCallback.call(null,this._holdRepeaterParam);
            }
            else
            {
               this._holdRepeaterCallback();
            }
         }
         this._holdRepeaterTimer.delay = this._holdRepeaterInterval;
      }
      
      public function resetParams() : void
      {
         this._dragOutCallback = null;
         this._dragOverCallback = null;
         this._pressCallback = null;
         this._releaseCallback = null;
         this._releaseOutsideCallback = null;
         this._rollOutCallback = null;
         this._rollOverCallback = null;
         this._mouseMoveCallback = null;
         this._enterCallback = null;
         this._escCallback = null;
         this._holdRepeaterCallback = null;
         this._wheelCallback = null;
         this._keyCallback = null;
         this._dragOutParam = null;
         this._dragOverParam = null;
         this._pressParam = null;
         this._releaseParam = null;
         this._releaseOutsideParam = null;
         this._rollOutParam = null;
         this._rollOverParam = null;
         this._mouseMoveParam = null;
         this._enterParam = null;
         this._escParam = null;
         this._holdRepeaterParam = null;
         this._wheelParam = null;
         this._keyParam = null;
      }
      
      private function mouseOverListener(param1:MouseEvent) : void
      {
         if(this._isDisabled || this._ignoreHover)
         {
            return;
         }
         if(this._stopImmediatePropagation)
         {
            param1.stopImmediatePropagation();
         }
         if(this._rolloverAudio != "" && this._app != null)
         {
            this._app.SoundManager.playSound(this._rolloverAudio);
         }
         if(this._showGraphics)
         {
            if(this._isAnimated)
            {
               this._clipListener.gotoAndPlay("over");
            }
            else
            {
               this._clipListener.gotoAndStop("over");
            }
         }
         if(param1.buttonDown)
         {
            if(this._dragOverCallback != null)
            {
               if(this._dragOverParam != null)
               {
                  this._dragOverCallback.call(null,this._dragOverParam);
               }
               else
               {
                  this._dragOverCallback();
               }
            }
         }
         else if(this._rollOverCallback != null)
         {
            if(this._rollOverParam != null)
            {
               this._rollOverCallback.call(null,this._rollOverParam);
            }
            else
            {
               this._rollOverCallback();
            }
         }
      }
      
      private function mouseMoveListener(param1:MouseEvent) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         if(this._stopImmediatePropagation)
         {
            param1.stopImmediatePropagation();
         }
         if(this._mouseMoveCallback != null)
         {
            if(this._mouseMoveParam != null)
            {
               this._mouseMoveCallback.call(null,this._mouseMoveParam);
            }
            else
            {
               this._mouseMoveCallback();
            }
         }
      }
      
      private function mouseDownListener(param1:MouseEvent) : void
      {
         if(this._isDisabled || this._ignoreClick)
         {
            return;
         }
         if(this._stopImmediatePropagation)
         {
            param1.stopImmediatePropagation();
         }
         if(this._isDown)
         {
            return;
         }
         if(this._pressAudio != "" && this._app != null)
         {
            this._app.SoundManager.playSound(this._pressAudio);
         }
         this._isDown = true;
         try
         {
            if(this._showGraphics)
            {
               if(this._isAnimated)
               {
                  this._clipListener.gotoAndPlay("down");
               }
               else
               {
                  this._clipListener.gotoAndStop("down");
               }
            }
         }
         catch(e:Error)
         {
         }
         this._clipListener.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpListener);
         this._clipListener.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveListener);
         if(this._pressCallback != null)
         {
            if(this._pressParam != null)
            {
               this._pressCallback.call(null,this._pressParam);
            }
            else
            {
               this._pressCallback();
            }
         }
         if(this._holdRepeaterCallback != null)
         {
            this._holdRepeaterTimer.delay = this._holdRepeaterWait;
            this._holdRepeaterTimer.start();
         }
      }
      
      private function mouseUpListener(param1:MouseEvent) : void
      {
         if(this._isDisabled || this._ignoreClick)
         {
            return;
         }
         if(this._stopImmediatePropagation)
         {
            param1.stopImmediatePropagation();
         }
         if(!this._isDown)
         {
            return;
         }
         if(this._releaseAudio != "" && this._app != null)
         {
            this._app.SoundManager.playSound(this._releaseAudio);
         }
         this._isDown = false;
         this._clipListener.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpListener);
         this._clipListener.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveListener);
         if(this._holdRepeaterTimer != null)
         {
            this._holdRepeaterTimer.stop();
         }
         if(param1.currentTarget != this._clipListener)
         {
            if(this._showGraphics)
            {
               this._clipListener.gotoAndStop("up");
            }
            if(this._releaseOutsideCallback != null)
            {
               if(this._releaseOutsideParam != null)
               {
                  this._releaseOutsideCallback.call(null,this._releaseOutsideParam);
               }
               else
               {
                  this._releaseOutsideCallback();
               }
            }
         }
         else
         {
            if(this._showGraphics)
            {
               if(this._isAnimated)
               {
                  this._clipListener.gotoAndPlay("over");
               }
               else
               {
                  this._clipListener.gotoAndStop("over");
               }
            }
            if(this._releaseCallback != null)
            {
               if(this._releaseParam != null)
               {
                  this._releaseCallback.call(null,this._releaseParam);
               }
               else
               {
                  this._releaseCallback();
               }
            }
         }
      }
      
      private function keyDownListener(param1:KeyboardEvent) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         if(param1.keyCode == Keyboard.ENTER && this._enterCallback != null)
         {
            if(this._enterParam != null)
            {
               this._enterCallback.call(null,this._escParam);
            }
            else
            {
               this._enterCallback();
            }
         }
         else if(param1.keyCode == Keyboard.ESCAPE && this._escCallback != null)
         {
            if(this._escParam != null)
            {
               this._escCallback.call(null,this._escParam);
            }
            else
            {
               this._escCallback();
            }
         }
         else if(param1.keyCode == this._keyNum && this._keyCallback != null)
         {
            if(this._keyParam != null)
            {
               this._keyCallback.call(null,this._keyParam);
            }
            else
            {
               this._keyCallback();
            }
         }
      }
      
      private function mouseOutListener(param1:MouseEvent) : void
      {
         if(this._isDisabled || this._ignoreHover)
         {
            return;
         }
         if(this._stopImmediatePropagation)
         {
            param1.stopImmediatePropagation();
         }
         if(this._showGraphics)
         {
            if(this._isAnimated)
            {
               this._clipListener.gotoAndPlay("out");
            }
            else
            {
               this._clipListener.gotoAndStop("up");
            }
         }
         if(param1.buttonDown)
         {
            if(this._dragOutCallback != null)
            {
               if(this._dragOutParam != null)
               {
                  this._dragOutCallback.call(null,this._dragOutParam);
               }
               else
               {
                  this._dragOutCallback();
               }
            }
         }
         else if(this._rollOutCallback != null)
         {
            if(this._rollOutParam != null)
            {
               this._rollOutCallback.call(null,this._rollOutParam);
            }
            else
            {
               this._rollOutCallback();
            }
         }
      }
      
      private function mouseWheelListener(param1:MouseEvent) : void
      {
         if(this._isDisabled)
         {
            return;
         }
         if(this._stopImmediatePropagation)
         {
            param1.stopImmediatePropagation();
         }
         if(this._wheelCallback != null)
         {
            if(this._wheelParam != null)
            {
               this._wheelCallback.call(null,param1.delta,this._wheelParam);
            }
            else
            {
               this._wheelCallback.call(null,param1.delta);
            }
         }
      }
      
      public function destroy() : void
      {
         try
         {
            this._clipListener.removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
            this._clipListener.removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         }
         catch(e:Error)
         {
         }
         this.deactivate();
         this.resetParams();
      }
      
      private function getFrameByLabel(param1:String) : int
      {
         var _loc5_:FrameLabel = null;
         var _loc6_:String = null;
         var _loc2_:Array = this._clipListener.currentLabels;
         var _loc3_:int = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = (_loc5_ = _loc2_[_loc4_]).name;
            if(param1 == _loc6_)
            {
               return _loc5_.frame;
            }
            _loc4_++;
         }
         return -1;
      }
      
      public function get IgnoreHover() : Boolean
      {
         return this._ignoreHover;
      }
      
      public function set IgnoreHover(param1:Boolean) : void
      {
         this._ignoreHover = param1;
      }
      
      public function get IgnoreClick() : Boolean
      {
         return this._ignoreClick;
      }
      
      public function set IgnoreClick(param1:Boolean) : void
      {
         this._ignoreClick = param1;
      }
   }
}
