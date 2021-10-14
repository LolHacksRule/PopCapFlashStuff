package com.popcap.flash.framework.anim
{
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public static const EVENT_ANIMATION_COMPLETE:String = "EVENT_ANIMATION_COMPLETE";
      
      public static const EVENT_ANIMATION_BEGIN:String = "EVENT_ANIMATION_BEGIN";
       
      
      public var animationName:String = "";
      
      public function AnimationEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.animationName = param2;
      }
   }
}
