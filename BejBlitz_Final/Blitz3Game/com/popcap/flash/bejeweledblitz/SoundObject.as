package com.popcap.flash.bejeweledblitz
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   
   public class SoundObject
   {
       
      
      private var _id:String = "";
      
      private var _path:String = "";
      
      private var _sound:Sound;
      
      private var _channel:SoundChannel;
      
      private var _transform:SoundTransform;
      
      private var _isLoaded:Boolean = false;
      
      private var _isPlaying:Boolean = false;
      
      private var _baseVolume:Number = 1;
      
      public var _volume:Number = 1;
      
      private var _pan:Number = 0;
      
      private var _loadedCallback:Function;
      
      public function SoundObject(param1:String, param2:String = "")
      {
         super();
         this._id = param1;
         this._path = param2;
         this._sound = new Sound();
         this._sound.addEventListener(Event.COMPLETE,this.onLoaded);
         this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this._sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         this._channel = new SoundChannel();
         this._channel.addEventListener(Event.SOUND_COMPLETE,this.onComplete);
         this._transform = new SoundTransform(this._baseVolume,this._pan);
      }
      
      public function getID() : String
      {
         return this._id;
      }
      
      public function isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function loadSound(param1:Function) : void
      {
         this._loadedCallback = param1;
         var _loc2_:URLRequest = new URLRequest(this._path);
         this._sound.load(_loc2_);
      }
      
      public function addSound(param1:Sound) : void
      {
         this._sound = param1;
         this._isLoaded = true;
      }
      
      public function fadeOutSound(param1:Number) : void
      {
         var duration:Number = param1;
         Tweener.addTween(this,{
            "_volume":0,
            "time":duration,
            "onUpdate":function():void
            {
               this.setVolume(_volume);
            }
         });
      }
      
      public function playSound(param1:Boolean = true, param2:Number = 1) : void
      {
         var pAllowOverlap:Boolean = param1;
         var pNumLoops:Number = param2;
         if(!this._isLoaded)
         {
            return;
         }
         if(this._isPlaying && !pAllowOverlap)
         {
            return;
         }
         this._isPlaying = true;
         try
         {
            if(Capabilities.hasAudio)
            {
               this.setVolume(SoundMixer.soundTransform.volume);
               this._channel = this._sound.play(0,pNumLoops,this._transform);
            }
            else
            {
               Utils.log(this,"playSound cannot start sound data: " + this._id + " due to Capabilities.hasAudio=false.");
            }
         }
         catch(e:Event)
         {
            Utils.log(this,"playSound cannot start sound data: " + _id + " due to error: " + e);
         }
      }
      
      public function stopSound() : void
      {
         if(this._isPlaying)
         {
            if(this._channel != null)
            {
               try
               {
                  this._channel.stop();
               }
               catch(e:Error)
               {
               }
            }
            this._isPlaying = false;
         }
      }
      
      public function setVolume(param1:Number) : void
      {
         param1 = Math.max(0,Math.min(1,param1));
         if(this._channel != null)
         {
            try
            {
               if(this._transform != null)
               {
                  this._transform.volume = Math.min(this._baseVolume * param1,1);
                  this._channel.soundTransform = this._transform;
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function onLoaded(param1:Event) : void
      {
         this._isLoaded = true;
         if(this._loadedCallback != null)
         {
            this._loadedCallback.call(null,true);
         }
      }
      
      private function onComplete(param1:Event) : void
      {
         this._isPlaying = false;
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"SoundObject IO Error: " + param1.toString());
         this._isPlaying = false;
         if(this._loadedCallback != null)
         {
            this._loadedCallback.call(null,false);
         }
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         this._isPlaying = false;
         if(this._loadedCallback != null)
         {
            this._loadedCallback.call(null,false);
         }
      }
   }
}
