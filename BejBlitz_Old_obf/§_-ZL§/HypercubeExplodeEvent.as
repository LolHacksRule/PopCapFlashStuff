package §_-ZL§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.events.Event;
   
   public class HypercubeExplodeEvent extends Event implements BlitzEvent
   {
      
      public static const §_-9c§:int = 250;
      
      public static const §_-aB§:String = "HypercubeExplodeEvent";
      
      public static const §_-Q2§:int = 5;
       
      
      private var §_-Jw§:Vector.<Gem>;
      
      private var §_-A6§:Vector.<Gem>;
      
      private var mApp:§_-0Z§;
      
      private var §_-IB§:Gem = null;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      public function HypercubeExplodeEvent(param1:§_-0Z§, param2:Gem)
      {
         super(§_-aB§);
         this.mApp = param1;
         this.§_-IB§ = param2;
         this.§_-A6§ = new Vector.<Gem>();
      }
      
      public function §_-e0§() : void
      {
         this.§_-4z§ = true;
      }
      
      public function Update(param1:Number) : void
      {
         var _loc2_:Gem = null;
         for each(_loc2_ in this.§_-A6§)
         {
            if(!(_loc2_ != this.§_-IB§ && (_loc2_.§_-EU§ || _loc2_.§_-k0§ || _loc2_.§_-NZ§ || _loc2_.§_-68§ > 0)))
            {
               _loc2_.§_-Ki§ = 250;
               this.mApp.logic.§_-4i§(250);
               if(_loc2_ == this.§_-IB§)
               {
                  _loc2_.§_-NX§();
               }
               else if(_loc2_.type == Gem.§_-l0§)
               {
                  _loc2_.§_-iB§();
                  _loc2_.§_-NX§();
               }
               else
               {
                  _loc2_.§_-Mj§(this.§_-IB§);
               }
            }
         }
         this.§_-A6§.length = 0;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      public function §_-gl§(param1:Gem) : void
      {
         if(param1.§_-af§ || param1.§_-NM§ > 0)
         {
            return;
         }
         this.§_-A6§.push(param1);
      }
      
      public function §_-J5§() : Vector.<Gem>
      {
         return this.§_-Jw§;
      }
      
      public function Init() : void
      {
         var _loc5_:Gem = null;
         this.§_-Jw§ = new Vector.<Gem>();
         var _loc1_:int = this.§_-IB§.§_-7f§;
         if(_loc1_ == Gem.§_-aK§)
         {
            _loc1_ = this.§_-IB§.color;
         }
         var _loc2_:Vector.<Gem> = this.mApp.logic.board.§_-Ai§(_loc1_);
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = _loc2_[_loc4_]).y >= -1.5)
            {
               if(!(_loc5_.§_-af§ || _loc5_.§_-NM§ > 0))
               {
                  if(!(_loc5_.§_-EU§ || _loc5_.§_-k0§ || _loc5_.§_-NZ§ || _loc5_.§_-68§ > 0))
                  {
                     _loc5_.§_-X5§ = this.§_-Ub§.§_-X5§;
                     _loc5_.§_-aC§ = this.§_-Ub§.§_-aC§;
                     this.§_-Jw§.push(_loc5_);
                  }
               }
            }
            _loc4_++;
         }
         this.§_-Gn§ = 0;
      }
      
      public function get §_-Ub§() : Gem
      {
         return this.§_-IB§;
      }
   }
}
