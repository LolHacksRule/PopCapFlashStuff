package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.Gem;
   import flash.events.Event;
   
   public class ScoreEvent extends Event
   {
      
      public static const §_-aB§:String = "ScoreEvent";
       
      
      public var color:int = 0;
      
      public var gem:Gem = null;
      
      public var value:int = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var id:int = -1;
      
      public function ScoreEvent()
      {
         super(§_-aB§);
      }
   }
}
