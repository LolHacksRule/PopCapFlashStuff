package §_-2v§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class §_-4P§ extends EventDispatcher
   {
      
      public static const §_-lA§:int = 4;
      
      public static const §_-4d§:int = 15;
       
      
      private var §_-pU§:int = 0;
      
      private var §_-at§:Vector.<Gem>;
      
      private var §_-bm§:int = 0;
      
      private var mApp:§_-0Z§;
      
      public var §_-Qv§:Dictionary;
      
      public function §_-4P§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
         this.§_-at§ = new Vector.<Gem>();
      }
      
      public function get numCreated() : int
      {
         return this.§_-bm§;
      }
      
      public function §try§(param1:Gem) : void
      {
         var _loc2_:Gem = null;
         var _loc3_:FlameGemExplodeEvent = null;
         this.mApp.logic.§_-4i§(100);
         this.§_-at§.length = 0;
         this.mApp.logic.board.§_-d4§(param1.x,param1.y,1.5,this.§_-at§);
         this.mApp.logic.§_-8U§(param1.x,param1.y,1);
         for each(_loc2_ in this.§_-at§)
         {
            if(_loc2_ != param1)
            {
               if(!(_loc2_.§_-68§ > 0 || _loc2_.§_-k0§ || _loc2_.§_-EU§ || _loc2_.§_-NZ§))
               {
                  this.mApp.logic.§_-4i§(100);
                  _loc2_.§_-Mj§(param1);
                  _loc2_.§_-X5§ = param1.§_-X5§;
                  _loc2_.§_-QS§ = param1.id;
                  _loc2_.§_-Ki§ = Math.max(100,_loc2_.§_-Ki§);
               }
            }
         }
         this.mApp.logic.§_-4i§(100);
         param1.§_-NZ§ = true;
         _loc3_ = new FlameGemExplodeEvent(param1,this.mApp.logic);
         this.mApp.logic.§for §(_loc3_);
         dispatchEvent(_loc3_);
      }
      
      public function §_-Gw§(param1:Gem) : void
      {
         if(param1.type != Gem.§_-Q3§)
         {
            return;
         }
         param1.§_-90§ = true;
      }
      
      public function §_-gg§(param1:Gem, param2:Match, param3:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         ++this.§_-bm§;
         ++this.mApp.logic.moves[param1.§_-aC§].flamesMade;
         param1.§_-PT§(Gem.§_-Q3§,param3);
         var _loc4_:FlameGemCreateEvent = new FlameGemCreateEvent(param1,param2);
         this.mApp.logic.§for §(_loc4_);
         dispatchEvent(_loc4_);
      }
      
      private function §_-S5§(param1:Gem) : void
      {
         ++this.§_-pU§;
         ++this.mApp.logic.moves[param1.§_-aC§].flamesUsed;
         this.§try§(param1);
      }
      
      public function §false§(param1:Gem) : void
      {
         if(this.§_-Qv§[param1.id] == true)
         {
            this.§_-Qv§[param1.id] = false;
            this.§try§(param1);
         }
         if(param1.type != Gem.§_-Q3§)
         {
            return;
         }
         this.§_-S5§(param1);
      }
      
      public function Reset() : void
      {
         this.§_-bm§ = 0;
         this.§_-pU§ = 0;
         this.§_-Qv§ = new Dictionary();
      }
      
      public function get numDestroyed() : int
      {
         return this.§_-pU§;
      }
      
      public function §_-KV§(param1:Match) : void
      {
         var _loc8_:Gem = null;
         if(param1.mGems.length != §_-lA§)
         {
            return;
         }
         var _loc2_:Vector.<Gem> = param1.mGems;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = int((param1.§_-Vd§ - param1.§_-Lh§) / 2) + param1.§_-Lh§;
         var _loc5_:int = int((param1.§_-I3§ - param1.§_-LC§) / 2) + param1.§_-LC§;
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            if(!(!(_loc8_ = _loc2_[_loc7_]).§_-iu§ && !_loc8_.§_-Vx§ || _loc8_.type >= Gem.§_-Q3§))
            {
               if(_loc6_ == null)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.§_-pX§ < _loc6_.§_-pX§ && _loc8_.§_-pX§ >= _loc4_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.§_-pX§ > _loc6_.§_-pX§ && _loc8_.§_-pX§ <= _loc4_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.§_-dg§ < _loc6_.§_-dg§ && _loc8_.§_-dg§ >= _loc5_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.§_-dg§ > _loc6_.§_-dg§ && _loc8_.§_-dg§ <= _loc5_)
               {
                  _loc6_ = _loc8_;
               }
               if(_loc8_.§_-Ux§ > _loc6_.§_-Ux§)
               {
                  _loc6_ = _loc8_;
               }
            }
            _loc7_++;
         }
         this.§_-gg§(_loc6_,param1);
      }
      
      public function §_-RR§(param1:Gem) : void
      {
         if(param1.type != Gem.§_-Q3§)
         {
            return;
         }
         param1.§_-68§ = §_-4d§;
      }
   }
}
