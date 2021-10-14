package §_-M1§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class MatchEvent extends Event implements BlitzEvent
   {
      
      public static const §_-aB§:String = "MatchEvent";
      
      public static const §_-bn§:Number = 25;
       
      
      private var §_-ZN§:Gem;
      
      private var §_-mp§:Number = 25;
      
      private var §_-4z§:Boolean = false;
      
      public function MatchEvent(param1:Gem)
      {
         super(§_-aB§);
         this.§_-ZN§ = param1;
      }
      
      public function Update(param1:Number) : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         if(this.§_-ZN§.§_-iH§ || this.§_-ZN§.§_-NZ§)
         {
            this.§_-4z§ = true;
            return;
         }
         this.§_-mp§ -= 1 * param1;
         this.§_-ZN§.scale = this.§_-mp§ / §_-bn§;
         if(this.§_-mp§ <= 0)
         {
            this.§_-ZN§.§_-NZ§ = true;
            this.§_-4z§ = true;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      public function Init() : void
      {
      }
   }
}
