package §_-M1§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class ShatterEvent extends Event implements BlitzEvent
   {
      
      public static const §_-aB§:String = "ShatterEvent";
       
      
      private var §_-ZN§:Gem;
      
      private var §_-4z§:Boolean = false;
      
      public function ShatterEvent(param1:Gem)
      {
         super(§_-aB§);
         this.§_-ZN§ = param1;
      }
      
      public function Init() : void
      {
      }
      
      public function Update(param1:Number) : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         this.§_-ZN§.§_-NZ§ = true;
         this.§_-4z§ = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
