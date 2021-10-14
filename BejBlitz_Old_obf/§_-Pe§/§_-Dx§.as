package §_-Pe§
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.events.EventDispatcher;
   
   public class §_-Dx§ extends EventDispatcher
   {
       
      
      private var §_-pU§:int = 0;
      
      private var mApp:§_-0Z§;
      
      private var §_-bm§:int = 0;
      
      public function §_-Dx§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function get numCreated() : int
      {
         return this.§_-bm§;
      }
      
      public function §_-Gw§(param1:Gem) : void
      {
         if(param1.type != Gem.§_-N3§)
         {
            return;
         }
         param1.§_-90§ = true;
      }
      
      public function §_-gg§(param1:Gem, param2:Match, param3:Match, param4:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         ++this.§_-bm§;
         ++this.mApp.logic.moves[param1.§_-aC§].starsMade;
         param1.§_-PT§(Gem.§_-N3§,param4);
         var _loc5_:StarGemCreateEvent = new StarGemCreateEvent(param1,param2,param3);
         this.mApp.logic.§for §(_loc5_);
         dispatchEvent(_loc5_);
      }
      
      public function Reset() : void
      {
         this.§_-bm§ = 0;
         this.§_-pU§ = 0;
      }
      
      private function §_-S5§(param1:Gem) : void
      {
         ++this.§_-pU§;
         ++this.mApp.logic.moves[param1.§_-aC§].starsUsed;
         param1.§_-Ki§ = 0;
         var _loc2_:StarGemExplodeEvent = new StarGemExplodeEvent(param1,this.mApp.logic);
         this.mApp.logic.§_-1Z§(_loc2_);
         dispatchEvent(_loc2_);
      }
      
      public function §false§(param1:Gem) : void
      {
         if(param1.type != Gem.§_-N3§)
         {
            return;
         }
         this.§_-S5§(param1);
      }
      
      public function get numDestroyed() : int
      {
         return this.§_-pU§;
      }
      
      public function §_-KV§(param1:Match) : void
      {
         var _loc6_:Match = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc2_:* = param1.§_-Lh§ == param1.§_-Vd§;
         if(_loc2_)
         {
            return;
         }
         var _loc3_:Vector.<Match> = param1.§_-6H§;
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            _loc7_ = 0;
            _loc8_ = 0;
            _loc8_ = _loc6_.§_-Lh§;
            _loc7_ = param1.§_-LC§;
            _loc9_ = this.mApp.logic.board.§_-9K§(_loc7_,_loc8_);
            this.§_-gg§(_loc9_,param1,_loc6_);
            _loc5_++;
         }
      }
      
      public function §_-RR§(param1:Gem) : void
      {
         if(param1.type != Gem.§_-N3§)
         {
            return;
         }
         if(param1.§_-EU§)
         {
            param1.§_-NZ§ = true;
         }
         else
         {
            param1.§_-90§ = true;
         }
      }
   }
}
