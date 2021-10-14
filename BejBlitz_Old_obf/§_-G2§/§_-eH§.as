package §_-G2§
{
   import flash.events.Event;
   
   public class §_-eH§ extends Event
   {
      
      public static const §_-N8§:String = "success";
      
      public static const §_-Kt§:String = "failure";
      
      public static const §_-4B§:String = "loadStarted";
      
      public static const §_-JV§:String = "abandon";
      
      public static const COMPLETE:String = "complete";
      
      public static const §_-9L§:String = "loadCompleted";
       
      
      private var §_-IH§:Object;
      
      public function §_-eH§(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function get target() : Object
      {
         return §_-IH§ || super.target;
      }
      
      public function set target(param1:*) : void
      {
         §_-IH§ = param1;
      }
      
      override public function toString() : String
      {
         return "[SocialGoldEvent type=\'" + type + "\' bubbles=\'" + bubbles + "\' cancelable=\'" + cancelable + "\' eventPhase=\'" + eventPhase + "\']";
      }
      
      override public function clone() : Event
      {
         return new §_-eH§(type,bubbles,cancelable);
      }
   }
}
