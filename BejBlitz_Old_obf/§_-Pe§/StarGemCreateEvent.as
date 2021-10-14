package §_-Pe§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class StarGemCreateEvent extends Event implements BlitzEvent
   {
      
      public static const §_-aB§:String = "StarGemCreateEvent";
      
      public static const §_-MY§:Number = 30;
       
      
      private var §_-jt§:Match;
      
      private var §_-D2§:Match;
      
      private var §_-IB§:Gem;
      
      private var mGems:Vector.<Gem>;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-06§:Number = 0;
      
      public function StarGemCreateEvent(param1:Gem, param2:Match = null, param3:Match = null)
      {
         super(§_-aB§);
         this.§_-IB§ = param1;
         this.§_-jt§ = param2;
         this.§_-D2§ = param3;
      }
      
      public function get percent() : Number
      {
         return this.§_-06§ / §_-MY§;
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
         this.mGems = new Vector.<Gem>();
         var _loc1_:Gem = null;
         if(this.§_-jt§ != null)
         {
            for each(_loc1_ in this.§_-jt§.mGems)
            {
               if(!(_loc1_ == null || _loc1_ == this.§_-IB§ || !_loc1_.§_-iu§ || _loc1_.§_-Vx§))
               {
                  _loc1_.§_-Ko§();
                  this.mGems.push(_loc1_);
               }
            }
         }
         if(this.§_-D2§ != null)
         {
            for each(_loc1_ in this.§_-D2§.mGems)
            {
               if(!(_loc1_ == null || _loc1_ == this.§_-IB§ || !_loc1_.§_-iu§ || _loc1_.§_-Vx§))
               {
                  _loc1_.§_-Ko§();
                  this.mGems.push(_loc1_);
               }
            }
         }
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
      
      public function get §_-Ub§() : Gem
      {
         return this.§_-IB§;
      }
   }
}
