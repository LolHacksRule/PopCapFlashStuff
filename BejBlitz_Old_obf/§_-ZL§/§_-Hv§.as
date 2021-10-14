package §_-ZL§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class §_-Hv§ extends EventDispatcher
   {
      
      public static const §_-lA§:int = 5;
       
      
      private var §_-pU§:int = 0;
      
      private var §_-7w§:Dictionary;
      
      private var §_-bm§:int = 0;
      
      private var mApp:§_-0Z§;
      
      public function §_-Hv§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function get numDestroyed() : int
      {
         return this.§_-pU§;
      }
      
      public function get numCreated() : int
      {
         return this.§_-bm§;
      }
      
      public function §_-Gw§(param1:Gem) : void
      {
         if(param1.type != Gem.§_-l0§)
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
         ++this.mApp.logic.moves[param1.§_-aC§].hypersMade;
         param1.§_-PT§(Gem.§_-l0§,param3);
         param1.§_-7f§ = param1.color;
         param1.§_-Ec§ = false;
         param1.movePolicy.§_-Zx§ = false;
         param1.movePolicy.canSwapNorth = false;
         param1.movePolicy.canSwapEast = false;
         param1.movePolicy.canSwapSouth = false;
         param1.movePolicy.canSwapWest = false;
         param1.movePolicy.§set § = true;
         param1.movePolicy.§_-HE§ = true;
         param1.movePolicy.§_-8c§ = true;
         param1.movePolicy.§_-Oe§ = true;
         param1.movePolicy.§_-Tk§ = true;
         var _loc4_:§_-YJ§ = new §_-YJ§(param1,param2);
         this.mApp.logic.§for §(_loc4_);
         dispatchEvent(_loc4_);
      }
      
      private function §_-S5§(param1:Gem) : void
      {
         this.§_-7w§[param1.§_-aC§] = true;
         ++this.§_-pU§;
         ++this.mApp.logic.moves[param1.§_-aC§].hypersUsed;
         param1.§_-Ki§ = 0;
         var _loc2_:HypercubeExplodeEvent = new HypercubeExplodeEvent(this.mApp,param1);
         this.mApp.logic.§_-1Z§(_loc2_);
         dispatchEvent(_loc2_);
      }
      
      public function §_-UD§(param1:int) : Boolean
      {
         return this.§_-7w§[param1] == true;
      }
      
      public function §false§(param1:Gem) : void
      {
         if(param1.type != Gem.§_-l0§)
         {
            return;
         }
         this.§_-S5§(param1);
      }
      
      public function Reset() : void
      {
         this.§_-bm§ = 0;
         this.§_-pU§ = 0;
         this.§_-7w§ = new Dictionary();
      }
      
      public function §_-KV§(param1:Match) : void
      {
         var _loc8_:Gem = null;
         if(param1.mGems.length < §_-lA§)
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
            if((_loc8_ = _loc2_[_loc7_]).type < Gem.§_-l0§)
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
         if(param1.type != Gem.§_-l0§)
         {
            return;
         }
         if(param1.§_-EU§)
         {
            param1.§_-NZ§ = true;
            return;
         }
         param1.§_-90§ = true;
      }
   }
}
