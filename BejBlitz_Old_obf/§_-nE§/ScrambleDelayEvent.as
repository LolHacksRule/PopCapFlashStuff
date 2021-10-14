package §_-nE§
{
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.events.Event;
   
   public class ScrambleDelayEvent extends Event implements BlitzEvent
   {
      
      public static const §_-aB§:String = "ScrambleDelayEvent";
       
      
      protected var §_-kV§:Boolean;
      
      protected var §_-Ek§:MoveData;
      
      protected var §_-Lp§:§_-0Z§;
      
      public function ScrambleDelayEvent(param1:§_-0Z§, param2:MoveData)
      {
         super(§_-aB§);
         this.§_-Lp§ = param1;
         this.§_-Ek§ = param2;
         this.Init();
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-kV§;
      }
      
      public function Init() : void
      {
         this.§_-kV§ = false;
      }
      
      public function Update(param1:Number) : void
      {
         if(this.§_-kV§ || !this.§_-Lp§.logic.board.§_-oP§())
         {
            return;
         }
         this.§_-Lp§.logic.§_-1Z§(new ScrambleEvent(this.§_-Lp§,this.§_-Ek§));
         this.§_-kV§ = true;
      }
   }
}
