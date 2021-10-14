package com.popcap.flash.games.bej3.blitz
{
   import flash.events.Event;
   
   public class ComplimentEvent extends Event
   {
      
      public static const ON_RESET:String = "Compliments:Reset";
      
      public static const ON_COMPLIMENT:String = "Compliments:OnCompliment";
       
      
      private var mLevel:int = -1;
      
      public function ComplimentEvent(level:int)
      {
         super(ON_COMPLIMENT);
         this.mLevel = level;
      }
      
      public function get level() : int
      {
         return this.mLevel;
      }
   }
}
