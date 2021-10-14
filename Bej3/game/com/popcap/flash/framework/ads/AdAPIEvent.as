package com.popcap.flash.framework.ads
{
   import flash.events.Event;
   
   public class AdAPIEvent extends Event
   {
      
      public static const PAUSE:String = "AdAPIEvent:Pause";
      
      public static const UNPAUSE:String = "AdAPIEvent:UnPause";
      
      public static const MUTE:String = "AdAPIEvent:Mute";
      
      public static const UNMUTE:String = "AdAPIEvent:UnMute";
      
      public static const MENU:String = "AdAPIEvent:Menu";
      
      public static const SESSION_START:String = "AdAPIEvent:SessionStart";
      
      public static const GAME_START:String = "AdAPIEvent:GameStart";
      
      public static const GAME_CONTINUE:String = "AdAPIEvent:GameContinue";
      
      public static const CUSTOM_RETURN:String = "AdAPIEvent:CustomReturn";
       
      
      public function AdAPIEvent(type:String)
      {
         super(type);
      }
   }
}
