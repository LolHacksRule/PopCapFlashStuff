package com.popcap.flash.framework.resources.sounds
{
   import flash.events.Event;
   
   public class SoundEvent extends Event
   {
      
      public static const SOUND_MUTED:String = "SoundMuted";
      
      public static const SOUND_UNMUTED:String = "SoundUnmuted";
       
      
      public function SoundEvent(param1:String)
      {
         super(param1);
      }
      
      public static function Muted() : SoundEvent
      {
         return new SoundEvent(SOUND_MUTED);
      }
      
      public static function Unmuted() : SoundEvent
      {
         return new SoundEvent(SOUND_UNMUTED);
      }
   }
}
