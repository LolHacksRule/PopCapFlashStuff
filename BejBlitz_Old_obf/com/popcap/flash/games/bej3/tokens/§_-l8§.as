package com.popcap.flash.games.bej3.tokens
{
   import com.popcap.flash.framework.events.EventContext;
   import com.popcap.flash.framework.events.§_-3D§;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.§_-2j§;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   
   public class §_-l8§
   {
      
      public static const §_-o-§:int = 25;
      
      public static const §_-PD§:int = 1000;
      
      public static const §_-7K§:int = 100;
      
      public static const §_-83§:int = 1000;
      
      public static const §_-fl§:int = 1250;
      
      public static const §_-cQ§:int = Gem.§_-AH§;
      
      public static const §_-Nb§:Number = 0.5;
       
      
      public var §_-gh§:Vector.<CoinToken>;
      
      private var §_-Ay§:int = 25;
      
      public var §_-hA§:int = 1;
      
      public var collected:Vector.<CoinToken>;
      
      private var §_-ad§:Vector.<Gem>;
      
      private var §_-VV§:Boolean = true;
      
      public var §_-bc§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      private var §_-ai§:BlitzLogic;
      
      private var mApp:§_-0Z§;
      
      public function §_-l8§(param1:§_-0Z§, param2:BlitzLogic)
      {
         super();
         this.§_-gh§ = new Vector.<CoinToken>();
         this.collected = new Vector.<CoinToken>();
         this.mApp = param1;
         this.§_-ai§ = param2;
         this.§_-ad§ = new Vector.<Gem>();
         var _loc3_:§_-3D§ = §_-3D§.§_-Tj§();
         _loc3_.§_-o1§("GemPhaseEnd",this.§_-Kc§);
         _loc3_.§_-o1§("BlitzTimeEvent",this.§_-Op§);
         _loc3_.§_-o1§("SpawnEndEvent",this.§_-FM§);
         _loc3_.§_-o1§("MultiplierCollectedEvent",this.§_-hV§);
      }
      
      private function §_-7r§() : void
      {
         if(this.§_-hA§ == 0 || this.mApp.logic.GetScore() < §_-PD§)
         {
            this.§_-bc§ = true;
            return;
         }
         --this.§_-hA§;
         this.§_-f-§();
      }
      
      private function §import§(param1:CoinToken, param2:Boolean) : void
      {
         if(param2)
         {
            param1.§_-dM§ = §_-fl§;
            this.mApp.logic.§_-4i§(§_-fl§);
         }
         param1.§_-J7§ = true;
         this.collected.push(param1);
         §_-3D§.§_-Tj§().§_-oA§(CoinTokenCollectedEvent.§_-aB§,param1);
         this.mApp.§_-3A§ += §_-7K§;
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COIN_COLLECTED);
      }
      
      public function SpawnCoinOnGem(param1:Gem) : void
      {
         if(param1.§_-D9§.§_-Iv§(CoinToken.§_-Be§))
         {
            return;
         }
         var _loc2_:CoinToken = new CoinToken();
         _loc2_.id = this.§_-gh§.length;
         _loc2_.host = param1;
         param1.§_-D9§.§_-Km§(CoinToken.§_-Be§,_loc2_);
         this.§_-gh§.push(_loc2_);
         §_-3D§.§_-Tj§().§_-oA§(CoinTokenSpawnedEvent.§_-aB§,_loc2_);
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COIN_CREATED);
      }
      
      private function §_-SW§() : void
      {
         var _loc1_:int = this.§_-ad§.length;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = _loc2_ || this.§_-ai§.random.§_-eZ§(§_-Nb§);
            _loc3_++;
         }
         if(_loc2_ == false)
         {
            return;
         }
         var _loc4_:int = this.§_-ai§.random.§_-Nn§(this.§_-ad§.length);
         var _loc5_:Gem = this.§_-ad§[_loc4_];
         var _loc6_:CoinToken;
         (_loc6_ = new CoinToken()).id = this.§_-gh§.length;
         _loc6_.host = _loc5_;
         _loc5_.§_-D9§.§_-Km§(CoinToken.§_-Be§,_loc6_);
         this.§_-gh§.push(_loc6_);
         §_-3D§.§_-Tj§().§_-oA§(CoinTokenSpawnedEvent.§_-aB§,_loc6_);
         this.§_-Gn§ = §_-83§;
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COIN_CREATED);
      }
      
      private function §_-Kc§(param1:EventContext) : void
      {
         var _loc4_:CoinToken = null;
         var _loc5_:Gem = null;
         var _loc6_:Boolean = false;
         var _loc2_:int = this.§_-gh§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(_loc4_ = this.§_-gh§[_loc3_]).§_-J7§)
            {
               if(_loc4_.§_-lC§ > 0)
               {
                  --_loc4_.§_-lC§;
               }
               if(_loc6_ = (_loc6_ = (_loc5_ = _loc4_.host).§_-hk§ || _loc5_.§_-k0§ || _loc4_.§_-lC§ == 0) || _loc5_.§_-NM§ > 0)
               {
                  this.§import§(_loc4_,true);
               }
            }
            _loc3_++;
         }
      }
      
      private function §_-Op§(param1:EventContext) : void
      {
         --this.§_-Gn§;
      }
      
      private function §_-hV§(param1:EventContext) : void
      {
         this.§_-hA§ = this.§_-ai§.multiLogic.multiplier;
      }
      
      public function §_-5u§() : int
      {
         var _loc4_:CoinToken = null;
         var _loc1_:int = 0;
         var _loc2_:int = this.§_-gh§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!(_loc4_ = this.§_-gh§[_loc3_]).§_-J7§)
            {
               _loc4_.§_-lC§ = 1;
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function §_-f-§() : void
      {
         var _loc1_:CoinToken = new CoinToken();
         _loc1_.id = this.§_-gh§.length;
         this.§_-gh§.push(_loc1_);
         §_-3D§.§_-Tj§().§_-oA§(CoinTokenSpawnedEvent.§_-aB§,_loc1_);
         this.§import§(_loc1_,false);
      }
      
      public function Reset() : void
      {
         this.§_-gh§.length = 0;
         this.collected.length = 0;
         this.§_-VV§ = true;
         this.§_-Gn§ = §_-83§;
         this.§_-ad§.length = 0;
         this.§_-hA§ = 1;
         this.§_-bc§ = false;
         this.§_-Ay§ = §_-o-§;
      }
      
      public function §_-oc§() : void
      {
         var _loc3_:CoinToken = null;
         var _loc4_:Gem = null;
         var _loc1_:int = this.§_-gh§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-gh§[_loc2_];
            _loc4_ = _loc3_.host;
            if(_loc3_.§_-dM§ > 0)
            {
               this.mApp.logic.scoreKeeper.§_-GU§(_loc3_.§_-dM§,_loc4_);
               _loc3_.§_-dM§ = 0;
            }
            _loc2_++;
         }
      }
      
      private function §_-FM§(param1:EventContext) : void
      {
         if(this.§_-ai§.§_-Kb§)
         {
            return;
         }
         if(this.§_-Gn§ > 0)
         {
            return;
         }
         this.§_-Mx§();
         this.§_-SW§();
      }
      
      public function §_-a2§() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:CoinToken = null;
         --this.§_-Ay§;
         if(this.§_-Ay§ > 0)
         {
            return;
         }
         this.§_-Ay§ = §_-o-§;
         if(this.§_-gh§.length == this.collected.length)
         {
            this.§_-7r§();
            return;
         }
         var _loc1_:§_-2j§ = this.§_-ai§.board;
         var _loc2_:int = 0;
         while(_loc2_ < §_-2j§.§_-H0§)
         {
            _loc3_ = 0;
            while(_loc3_ < §_-2j§.§_-IP§)
            {
               if(!((_loc5_ = (_loc4_ = _loc1_.§_-9K§(_loc2_,_loc3_)).§_-D9§.§_-pR§(CoinToken.§_-Be§)) == null || _loc5_.§_-J7§))
               {
                  this.§import§(_loc5_,false);
               }
               continue;
               _loc3_++;
               return;
            }
            _loc2_++;
         }
      }
      
      private function §_-Mx§() : void
      {
         var _loc4_:Gem = null;
         this.§_-ad§.length = 0;
         var _loc1_:Vector.<Gem> = this.§_-ai§.board.§_-Md§;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]).color == §_-cQ§ && _loc4_.type == Gem.§_-Jz§)
            {
               this.§_-ad§.push(_loc4_);
            }
            _loc3_++;
         }
      }
   }
}
