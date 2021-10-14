package com.popcap.flash.framework.ads
{
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class MSNAdAPI extends EventDispatcher
   {
      
      public static const MIN_BROADCAST_RATE:Number = 1000;
      
      public static const DEFAULT_LOAD_BROADCAST_RATE:Number = 3000;
      
      public static const DEFAULT_SCORE_BROADCAST_RATE:Number = 3000;
      
      private static const MILLIS_PER_UPDATE:Number = 100;
       
      
      private var _timer:Timer;
      
      private var _lastTime:int;
      
      private var _score:Number = 0;
      
      private var _updateTime:Number = 0;
      
      private var _gameTime:Number = 0;
      
      private var _loadPercent:Number = 0;
      
      private var _numBreaks:Number = 0;
      
      private var _loadBroadcastRate:Number = 3000;
      
      private var _scoreBroadcastRate:Number = 3000;
      
      private var _isLoading:Boolean = true;
      
      private var _isPlaying:Boolean = false;
      
      public var _isEnabled:Boolean = false;
      
      public function MSNAdAPI()
      {
         super();
         this._timer = new Timer(100);
         this._timer.addEventListener(TimerEvent.TIMER,this.HandleTimer);
      }
      
      public function init() : void
      {
         var _loc1_:Boolean = false;
         this._isEnabled = true;
         this._loadBroadcastRate = DEFAULT_LOAD_BROADCAST_RATE;
         this._scoreBroadcastRate = DEFAULT_SCORE_BROADCAST_RATE;
         if(!this._isEnabled)
         {
            return;
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("onGameMenu",this.onGameMenu);
            ExternalInterface.addCallback("onGameMute",this.onGameMute);
            ExternalInterface.addCallback("onMuteOn",this.onMuteOn);
            ExternalInterface.addCallback("onMuteOff",this.onMuteOff);
            ExternalInterface.addCallback("onGamePause",this.onGamePause);
            ExternalInterface.addCallback("onPauseOn",this.onPauseOn);
            ExternalInterface.addCallback("onPauseOff",this.onPauseOff);
            ExternalInterface.addCallback("onGameContinue",this.onGameContinue);
            ExternalInterface.addCallback("onGameStart",this.onGameStart);
            ExternalInterface.addCallback("onSessionStart",this.onSessionStart);
            ExternalInterface.addCallback("onCustomReturn",this.onCustomReturn);
            _loc1_ = ExternalInterface.call("isProxyReady");
            if(_loc1_ == true)
            {
               ExternalInterface.call("setSWFIsReady");
            }
            else
            {
               this._isEnabled = false;
            }
         }
         this._timer.start();
         this._lastTime = getTimer();
      }
      
      public function SetScore(param1:Number) : void
      {
         this._score = param1;
      }
      
      public function SetLoadPercent(param1:Number) : void
      {
         this._loadPercent = param1 < 0 ? Number(0) : Number(param1);
         this._loadPercent = this._loadPercent > 100 ? Number(100) : Number(this._loadPercent);
         this._loadPercent = int(this._loadPercent);
      }
      
      public function CustomEvent(param1:XML) : void
      {
         if(!this._isEnabled || !ExternalInterface.available)
         {
            this.DispatchAdEvent(AdAPIEvent.CUSTOM_RETURN);
            return;
         }
         var _loc2_:String = "<data>DeluxeDownload</data>";
         ExternalInterface.call("CustomEvent",_loc2_);
      }
      
      public function GameBreak(param1:Number) : void
      {
         this._isPlaying = false;
         this._numBreaks += 1;
         if(!this._isEnabled || !ExternalInterface.available)
         {
            this._isPlaying = true;
            this.DispatchAdEvent(AdAPIEvent.GAME_CONTINUE);
            return;
         }
         var _loc2_:* = "<data><breakpoint>" + this._numBreaks + "</breakpoint></data>";
         ExternalInterface.call("GameBreak",_loc2_);
      }
      
      public function GameEnd() : void
      {
         this._isPlaying = false;
         if(!this._isEnabled || !ExternalInterface.available)
         {
            return;
         }
         ExternalInterface.call("GameEnd","<gamedata></gamedata>");
      }
      
      public function GameError(param1:String) : void
      {
         if(!this._isEnabled || !ExternalInterface.available)
         {
            return;
         }
         ExternalInterface.call("GameError",param1);
      }
      
      public function GameReady(param1:Number, param2:Number) : void
      {
         this._gameTime = 0;
         if(!this._isEnabled || !ExternalInterface.available)
         {
            this._gameTime = 0;
            this._isPlaying = true;
            this.DispatchAdEvent(AdAPIEvent.GAME_START);
            return;
         }
         var _loc3_:* = "<data><mode>" + param1 + "</mode><startlevel>" + param2 + "</startlevel></data>";
         ExternalInterface.call("GameReady",_loc3_);
      }
      
      public function ScoreSubmit() : void
      {
         if(!this._isEnabled || !ExternalInterface.available)
         {
            return;
         }
         var _loc1_:* = "<game><score>" + this._score + "</score><time>" + int(this._gameTime / 1000) + "</time></game>";
         ExternalInterface.call("ScoreSubmit",_loc1_);
      }
      
      public function SessionReady() : void
      {
         this._isLoading = false;
         var _loc1_:* = "<data><percentcomplete>" + this._loadPercent + "</percentcomplete></data>";
         if(!this._isEnabled || !ExternalInterface.available)
         {
            this.DispatchAdEvent(AdAPIEvent.SESSION_START);
            return;
         }
         ExternalInterface.call("LoadBroadcast",_loc1_);
         ExternalInterface.call("SessionReady","<data></data>");
      }
      
      public function PauseBroadcast() : void
      {
         this._isPlaying = false;
      }
      
      public function ResumeBroadcast() : void
      {
         this._isPlaying = true;
      }
      
      private function OnOffAsBoolean(param1:String) : Boolean
      {
         if(param1 == "on")
         {
            return true;
         }
         return false;
      }
      
      private function TogglePause(param1:Boolean) : void
      {
         if(param1)
         {
            this.DispatchAdEvent(AdAPIEvent.PAUSE);
         }
         else
         {
            this.DispatchAdEvent(AdAPIEvent.UNPAUSE);
         }
      }
      
      private function ToggleMute(param1:Boolean) : void
      {
         if(param1)
         {
            this.DispatchAdEvent(AdAPIEvent.MUTE);
         }
         else
         {
            this.DispatchAdEvent(AdAPIEvent.UNMUTE);
         }
      }
      
      private function DispatchAdEvent(param1:String) : void
      {
         var _loc2_:AdAPIEvent = new AdAPIEvent(param1);
         dispatchEvent(_loc2_);
      }
      
      private function Update() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         if(!this._isEnabled)
         {
            return;
         }
         var _loc1_:int = getTimer();
         var _loc2_:int = _loc1_ - this._lastTime;
         this._lastTime = getTimer();
         this._updateTime += MILLIS_PER_UPDATE;
         if(this._isLoading)
         {
            if(_loc4_ = this._updateTime % this._loadBroadcastRate == 0)
            {
               _loc3_ = "<data><percentcomplete>" + this._loadPercent + "</percentcomplete></data>";
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("LoadBroadcast",_loc3_);
               }
            }
         }
         if(this._isPlaying)
         {
            this._gameTime += MILLIS_PER_UPDATE;
            if(_loc5_ = this._gameTime % this._scoreBroadcastRate == 0)
            {
               trace("broadcasting score: " + this._score);
               _loc3_ = "<game><score>" + this._score + "</score><time>" + int(this._gameTime / 1000) + "</time></game>";
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("ScoreBroadcast",_loc3_);
               }
            }
         }
      }
      
      private function HandleTimer(param1:TimerEvent) : void
      {
         this.Update();
      }
      
      private function onCustomReturn(param1:String = null) : void
      {
         this.DispatchAdEvent(AdAPIEvent.CUSTOM_RETURN);
      }
      
      private function onGameContinue(param1:String = null) : void
      {
         this.DispatchAdEvent(AdAPIEvent.GAME_CONTINUE);
      }
      
      private function onGameMenu() : void
      {
         this.DispatchAdEvent(AdAPIEvent.MENU);
      }
      
      private function onGameMute(param1:String) : void
      {
         this.ToggleMute(this.OnOffAsBoolean(param1));
      }
      
      private function onMuteOn() : void
      {
         this.ToggleMute(true);
      }
      
      private function onMuteOff() : void
      {
         this.ToggleMute(false);
      }
      
      private function onGamePause(param1:String) : void
      {
         var _loc2_:Boolean = this.OnOffAsBoolean(param1);
         this.TogglePause(_loc2_);
      }
      
      private function onPauseOn() : void
      {
         this.TogglePause(true);
      }
      
      private function onPauseOff() : void
      {
         this.TogglePause(false);
      }
      
      private function onGameStart() : void
      {
         this._gameTime = 0;
         this.DispatchAdEvent(AdAPIEvent.GAME_START);
      }
      
      private function onSessionStart() : void
      {
         this.DispatchAdEvent(AdAPIEvent.SESSION_START);
      }
   }
}
