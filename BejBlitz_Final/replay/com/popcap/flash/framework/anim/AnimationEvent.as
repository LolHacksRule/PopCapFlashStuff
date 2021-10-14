package com.popcap.flash.framework.anim
{
   import flash.events.Event;
   
   public class AnimationEvent extends Event
   {
      
      public static const EVENT_ANIMATION_COMPLETE:String = "EVENT_ANIMATION_COMPLETE";
      
      public static const EVENT_ANIMATION_BEGIN:String = "EVENT_ANIMATION_BEGIN";
       
      
      public var animationName:String = "";
      
      public function AnimationEvent(type:String, name:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.animationName = name;
      }
   }
}
