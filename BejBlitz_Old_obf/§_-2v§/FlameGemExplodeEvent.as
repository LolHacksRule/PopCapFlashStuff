package §_-2v§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import flash.events.Event;
   
   public class FlameGemExplodeEvent extends Event implements BlitzEvent
   {
      
      public static const §_-aB§:String = "FlameGemExplodeEvent";
       
      
      private var §_-ai§:BlitzLogic;
      
      private var §_-IB§:Gem;
      
      private var §_-4z§:Boolean = false;
      
      public function FlameGemExplodeEvent(param1:Gem, param2:BlitzLogic)
      {
         super(§_-aB§,bubbles,cancelable);
         this.§_-IB§ = param1;
         this.§_-ai§ = param2;
      }
      
      public function Update(param1:Number) : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         this.§_-4z§ = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      public function Init() : void
      {
      }
      
      public function get §_-Ub§() : Gem
      {
         return this.§_-IB§;
      }
   }
}
