package §_-Pe§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.§_-2j§;
   import com.popcap.flash.games.bej3.§_-aY§;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import flash.events.Event;
   
   public class StarGemExplodeEvent extends Event implements BlitzEvent
   {
      
      public static const §_-7W§:int = 8;
      
      public static const §_-9c§:int = 250;
      
      public static const §_-hr§:int = 80;
      
      public static const §_-aB§:String = "StarGemExplodeEvent";
      
      public static const §_-Q2§:int = 10;
       
      
      private var §_-Cq§:int = 0;
      
      private var §_-9m§:Array;
      
      private var §_-ai§:BlitzLogic = null;
      
      private var §_-cH§:§_-aY§ = null;
      
      private var §_-IB§:Gem = null;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      public function StarGemExplodeEvent(param1:Gem, param2:BlitzLogic)
      {
         var _loc6_:Vector.<Gem> = null;
         var _loc7_:Object = null;
         super(§_-aB§);
         this.§_-IB§ = param1;
         this.§_-ai§ = param2;
         this.§_-cH§ = this.§_-ai§.grid;
         var _loc3_:int = 1;
         var _loc4_:int = §_-hr§;
         var _loc5_:* = false;
         this.§_-9m§ = new Array();
         while(!_loc5_)
         {
            _loc6_ = this.§_-4T§(_loc3_);
            (_loc7_ = new Object()).gems = _loc6_;
            _loc7_.time = _loc4_;
            this.§_-9m§.push(_loc7_);
            _loc3_++;
            _loc4_ += §_-Q2§;
            _loc5_ = _loc6_ == null;
         }
      }
      
      public function Update(param1:Number) : void
      {
         var _loc3_:Vector.<Gem> = null;
         var _loc4_:Gem = null;
         if(this.§_-4z§ == true)
         {
            return;
         }
         ++this.§_-Gn§;
         var _loc2_:Object = this.§_-9m§[0];
         if(_loc2_.time == this.§_-Gn§)
         {
            this.§_-9m§.shift();
            _loc3_ = _loc2_.gems;
            if(_loc3_ == null)
            {
               this.§_-gl§(this.§_-IB§);
               this.§_-4z§ = true;
            }
            else
            {
               for each(_loc4_ in _loc3_)
               {
                  this.§_-gl§(_loc4_);
               }
            }
         }
      }
      
      private function §_-DS§(param1:int, param2:int, param3:Vector.<Gem>) : void
      {
         var _loc4_:Gem;
         if((_loc4_ = this.§_-cH§.getGem(param1,param2)) == null)
         {
            return;
         }
         if(_loc4_.type == Gem.§_-72§ || _loc4_.type == Gem.§_-nT§)
         {
            return;
         }
         if(_loc4_.§_-af§ || _loc4_.§_-NM§ > 0)
         {
            return;
         }
         if(_loc4_.§_-NZ§ || _loc4_.§_-k0§ || _loc4_.§_-EU§ || _loc4_.§_-68§ > 0)
         {
            return;
         }
         _loc4_.§_-Vx§ = true;
         param3.push(_loc4_);
      }
      
      public function Init() : void
      {
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      private function §_-4T§(param1:int) : Vector.<Gem>
      {
         var _loc2_:int = this.§_-IB§.y;
         var _loc3_:int = this.§_-IB§.x;
         var _loc4_:int = _loc3_ - param1;
         var _loc5_:int = _loc3_ + param1;
         var _loc6_:int = _loc2_ - param1;
         var _loc7_:int = _loc2_ + param1;
         if(_loc4_ < §_-2j§.LEFT && _loc5_ > §_-2j§.RIGHT && _loc6_ < §_-2j§.§_-ou§ && _loc7_ > §_-2j§.§_-dp§)
         {
            return null;
         }
         var _loc8_:Vector.<Gem> = new Vector.<Gem>();
         this.§_-DS§(_loc2_,_loc4_,_loc8_);
         this.§_-DS§(_loc2_,_loc5_,_loc8_);
         this.§_-DS§(_loc6_,_loc3_,_loc8_);
         this.§_-DS§(_loc7_,_loc3_,_loc8_);
         return _loc8_;
      }
      
      private function §_-gl§(param1:Gem) : void
      {
         param1.§_-Ki§ = §_-9c§;
         this.§_-ai§.§_-4i§(§_-9c§);
         if(param1 == this.§_-IB§)
         {
            param1.§_-NX§();
         }
         else
         {
            param1.§_-Mj§(this.§_-IB§);
            param1.§_-X5§ = this.§_-IB§.§_-X5§;
            param1.§_-QS§ = this.§_-IB§.id;
         }
      }
      
      public function get §_-Ub§() : Gem
      {
         return this.§_-IB§;
      }
   }
}
