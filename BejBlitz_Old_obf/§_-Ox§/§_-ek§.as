package §_-Ox§
{
   import com.popcap.flash.framework.events.EventContext;
   import com.popcap.flash.framework.events.§_-3D§;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.§_-2j§;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.BlitzScoreValue;
   import com.popcap.flash.games.bej3.blitz.CascadeScore;
   import com.popcap.flash.games.bej3.blitz.§_-ZG§;
   import flash.utils.Dictionary;
   
   public class §_-ek§
   {
      
      public static const §_-Ew§:int = 4;
      
      public static const §_-bN§:int = 400;
      
      public static const §_-4d§:int = 5;
      
      public static const §_-gE§:int = 12;
      
      public static const §_-fY§:int = 20;
      
      public static const §_-9c§:int = 1000;
      
      public static const §_-fE§:int = 5;
      
      public static const §_-mV§:int = 7;
      
      public static const §_-gK§:int = 8;
      
      public static const §_-ON§:int = 5;
       
      
      private var §_-UR§:Boolean = true;
      
      public var multiplier:int = 1;
      
      private var §_-ZV§:Vector.<Gem>;
      
      public var §_-Nv§:Boolean = false;
      
      public var spawned:Boolean = false;
      
      public var § each§:int = 12;
      
      private var §_-ad§:Vector.<Gem>;
      
      private var §_-Wd§:§_-ZG§;
      
      private var §_-XE§:Dictionary;
      
      public var §_-z§:int = 400;
      
      public var §_-eE§:int = 0;
      
      private var §_-ai§:BlitzLogic;
      
      public var numSpawned:int = 0;
      
      public var §_-22§:int = 7;
      
      private var §_-bQ§:§_-2j§;
      
      public var §_-3§:Boolean = false;
      
      public var used:Array;
      
      public function §_-ek§(param1:BlitzLogic)
      {
         super();
         this.§_-ai§ = param1;
         this.§_-bQ§ = param1.board;
         this.§_-Wd§ = param1.scoreKeeper;
         this.§_-ad§ = new Vector.<Gem>();
         this.§_-ZV§ = new Vector.<Gem>();
         var _loc2_:§_-3D§ = §_-3D§.§_-Tj§();
         _loc2_.§_-o1§("BlitzTimeEvent",this.§_-Op§);
      }
      
      public function §_-kI§(param1:BlitzScoreValue) : void
      {
         if(param1.§_-NV§.§_-pR§("NotMultiplied"))
         {
            return;
         }
         param1.value *= this.multiplier;
      }
      
      private function §_-S5§(param1:Gem) : void
      {
         if(param1 == null || param1.type != Gem.§_-ec§)
         {
            return;
         }
         this.§_-Wd§.§_-UY§(param1.§_-aC§);
      }
      
      public function §_-Gw§(param1:Gem) : void
      {
         this.§_-Wj§(param1);
      }
      
      public function SpawnGem(param1:Gem) : void
      {
         if(this.§_-22§ <= 0)
         {
            return;
         }
         if(param1.type == Gem.§_-ec§)
         {
            return;
         }
         param1.§_-PT§(Gem.§_-ec§);
         param1.§_-Nx§ = this.multiplier + 1;
         ++this.numSpawned;
         this.§_-3§ = true;
         --this.§_-22§;
         this.§_-Nv§ = false;
         this.spawned = true;
         this.§_-XE§[param1.id] = false;
      }
      
      private function §_-Op§(param1:EventContext) : void
      {
         --this.§_-z§;
      }
      
      public function §false§(param1:Gem) : void
      {
         if(param1 == null || param1.type != Gem.§_-ec§)
         {
            return;
         }
         this.§_-Wj§(param1);
         param1.§_-NZ§ = true;
         param1.§_-NX§();
      }
      
      private function §_-Mx§() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:Vector.<Gem> = null;
         this.§_-ad§.length = 0;
         this.§_-ZV§.length = 0;
         var _loc1_:Vector.<Gem> = this.§_-bQ§.§_-Md§;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]).§_-D9§.size <= 0)
            {
               if(this.§_-ai§.board.§_-Ng§(_loc4_.color,false) < §_-Ew§)
               {
                  this.§_-ZV§.push(_loc4_);
               }
               else
               {
                  this.§_-ad§.push(_loc4_);
               }
            }
            _loc3_++;
         }
         if(this.§_-ad§.length == 0 && this.§_-ZV§.length > 0)
         {
            _loc5_ = this.§_-ad§;
            this.§_-ad§ = this.§_-ZV§;
            this.§_-ZV§ = _loc5_;
         }
      }
      
      public function §_-FM§() : void
      {
         var _loc5_:CascadeScore = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         this.spawned = false;
         if(this.§_-ai§.§_-Kb§)
         {
            return;
         }
         if(this.§_-22§ == 0)
         {
            return;
         }
         var _loc1_:Vector.<CascadeScore> = this.§_-Wd§.§_-AI§;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if((_loc5_ = _loc1_[_loc4_]).§_-Tm§)
            {
               if((_loc6_ = _loc5_.§_-Ln§()) > _loc3_)
               {
                  _loc3_ = _loc6_;
               }
            }
            _loc4_++;
         }
         if(this.§_-z§ == 0)
         {
            this.§_-z§ = §_-bN§;
            if(!this.§_-UR§)
            {
               _loc7_ = this.§_-ai§.random.§_-Nn§(§_-fE§);
               this.§ each§ = Math.max(this.§ each§ - _loc7_,§_-ON§);
            }
         }
         if(_loc3_ >= this.§ each§ && !this.§_-3§)
         {
            this.§_-Nv§ = true;
            this.§ each§ = §_-fY§;
            this.§_-UR§ = false;
         }
         if(this.§_-Nv§)
         {
            this.§_-ad§.length = 0;
            this.§_-Mx§();
            if(this.§_-ad§.length > 0)
            {
               _loc8_ = this.§_-ai§.random.§_-Nn§(this.§_-ad§.length);
               _loc9_ = this.§_-ad§[_loc8_];
               this.SpawnGem(_loc9_);
            }
         }
         if(_loc3_ < §_-gK§)
         {
            this.§_-3§ = false;
         }
         this.§_-eE§ = _loc3_;
      }
      
      public function §_-Wt§(param1:Gem) : void
      {
         if(param1 == null || param1.type != Gem.§_-ec§)
         {
            return;
         }
         param1.§_-Nx§ = this.multiplier + 1;
      }
      
      public function §_-RR§(param1:Gem) : void
      {
         this.§_-Wj§(param1);
      }
      
      private function §_-Wj§(param1:Gem) : void
      {
         var _loc2_:Object = null;
         if(param1 == null || param1.type != Gem.§_-ec§)
         {
            return;
         }
         if(this.§_-XE§[param1.id] == true)
         {
            return;
         }
         param1.§_-Fp§ = §_-9c§ * (this.multiplier + 1);
         this.§_-ai§.§_-4i§(§_-9c§ * (this.multiplier + 1)).§_-NV§.§_-Km§("NotMultiplied","NotMultiplied");
         this.§_-UY§(param1.§_-aC§);
         this.§_-XE§[param1.id] = true;
         if(!this.§_-ai§.§_-Kb§)
         {
            _loc2_ = new Object();
            _loc2_.time = this.§_-ai§.GetTimeElapsed();
            _loc2_.color = param1.color;
            _loc2_.number = Math.max(this.multiplier,param1.§_-Nx§);
            this.used.push(_loc2_);
         }
      }
      
      public function Reset() : void
      {
         this.multiplier = 1;
         this.§ each§ = §_-gE§;
         this.§_-z§ = §_-bN§;
         this.§_-eE§ = 9;
         this.numSpawned = 0;
         this.§_-22§ = §_-mV§;
         this.§_-Nv§ = false;
         this.§_-3§ = false;
         this.spawned = false;
         this.§_-XE§ = new Dictionary();
         this.used = new Array();
         this.§_-UR§ = true;
         this.§_-ad§.length = 0;
         this.§_-ZV§.length = 0;
      }
      
      private function §_-UY§(param1:int) : void
      {
         if(this.§_-ai§.§_-Kb§)
         {
            return;
         }
         ++this.multiplier;
         §_-3D§.§_-Tj§().§_-oA§("MultiplierCollectedEvent");
         this.§_-Wd§.§_-UY§(param1);
      }
   }
}
