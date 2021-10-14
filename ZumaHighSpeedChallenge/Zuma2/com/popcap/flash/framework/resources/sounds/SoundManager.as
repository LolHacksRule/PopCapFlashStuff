package com.popcap.flash.framework.resources.sounds
{
   import flash.events.IEventDispatcher;
   
   public interface SoundManager extends IEventDispatcher
   {
       
      
      function isMuted() : Boolean;
      
      function getSoundResource(param1:String) : SoundResource;
      
      function loopSound(param1:String) : SoundInst;
      
      function toggleMute() : void;
      
      function unmute() : void;
      
      function resumeAll() : void;
      
      function mute() : void;
      
      function pauseAll() : void;
      
      function playSound(param1:String, param2:int = 1) : SoundInst;
      
      function setVolume(param1:Number) : void;
      
      function stopAll() : void;
   }
}
