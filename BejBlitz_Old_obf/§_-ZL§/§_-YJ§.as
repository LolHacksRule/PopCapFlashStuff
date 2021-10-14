package §_-ZL§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class §_-YJ§ extends Event implements BlitzEvent
   {
      
      public static const §_-aB§:String = "RainbowGemCreateEvent";
      
      public static const §_-MY§:Number = 30;
       
      
      private var mGems:Vector.<Gem>;
      
      private var §_-IB§:Gem;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-06§:Number = 0;
      
      private var §_-p0§:Match;
      
      public function §_-YJ§(param1:Gem, param2:Match = null)
      {
         super(§_-aB§);
         this.§_-IB§ = param1;
         this.§_-p0§ = param2;
      }
      
      public function Update(param1:Number) : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         this.§_-06§ += param1;
         if(this.§_-06§ >= §_-MY§)
         {
            this.§_-06§ = §_-MY§;
            this.§_-4z§ = true;
            this.§_-3H§();
         }
      }
      
      private function §_-3H§() : void
      {
         var _loc3_:Gem = null;
         var _loc1_:int = this.mGems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mGems[_loc2_];
            _loc3_.§_-NZ§ = true;
            _loc2_++;
         }
      }
      
      public function get gems() : Vector.<Gem>
      {
         return this.mGems;
      }
      
      public function get percent() : Number
      {
         return this.§_-06§ / §_-MY§;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      public function get time() : Number
      {
         return this.§_-06§;
      }
      
      public function Init() : void
      {
         var _loc1_:Gem = null;
         this.mGems = new Vector.<Gem>();
         if(this.§_-p0§ == null)
         {
            return;
         }
         for each(_loc1_ in this.§_-p0§.mGems)
         {
            if(!(_loc1_ == null || _loc1_ == this.§_-IB§ || !_loc1_.§_-iu§ || _loc1_.§_-Vx§))
            {
               _loc1_.§_-Ko§();
               this.mGems.push(_loc1_);
            }
         }
      }
      
      public function get §_-Ub§() : Gem
      {
         return this.§_-IB§;
      }
   }
}
