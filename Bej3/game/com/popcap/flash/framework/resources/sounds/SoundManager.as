package com.popcap.flash.framework.resources.sounds
{
   import flash.events.IEventDispatcher;
   
   public interface SoundManager extends IEventDispatcher
   {
       
      
      function mute() : void;
      
      function unmute() : void;
      
      function toggleMute() : void;
      
      function stopAll() : void;
      
      function pauseAll() : void;
      
      function resumeAll() : void;
      
      function setVolume(param1:Number) : void;
      
      function isMuted() : Boolean;
      
      function playSound(param1:String, param2:int = 1) : SoundInst;
      
      function loopSound(param1:String) : SoundInst;
      
      function getSoundResource(param1:String) : SoundResource;
   }
}
