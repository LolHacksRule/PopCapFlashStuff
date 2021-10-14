package com.popcap.flash.games.bej3.blitz
{
   import §_-2v§.§_-4P§;
   import §_-4M§.Base64;
   import §_-M1§.MatchEvent;
   import §_-M1§.ShatterEvent;
   import §_-Ox§.§_-ek§;
   import §_-Pe§.§_-Dx§;
   import §_-ZL§.§_-Hv§;
   import §_-nE§.ScrambleDelayEvent;
   import §_-nE§.ScrambleEvent;
   import com.popcap.flash.framework.events.§_-3D§;
   import com.popcap.flash.framework.math.§_-4y§;
   import com.popcap.flash.framework.math.§_-fO§;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.MatchSet;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.SwapData;
   import com.popcap.flash.games.bej3.§_-2j§;
   import com.popcap.flash.games.bej3.§_-aY§;
   import com.popcap.flash.games.bej3.boosts.IBoost;
   import com.popcap.flash.games.bej3.boosts.§_-FI§;
   import com.popcap.flash.games.bej3.tokens.§_-l8§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BlitzLogic extends EventDispatcher
   {
      
      public static const §_-20§:Number = 1;
      
      public static const §_-hc§:int = -1;
      
      public static const §_-TL§:int = 1;
      
      public static const §_-YB§:int = 3;
      
      private static const §_-PK§:int = 175;
      
      public static const §_-SV§:Number = 2 / 128;
      
      public static const §_-k2§:int = 2;
      
      public static const §_-Ta§:int = 0;
      
      public static const §_-1s§:int = 8;
      
      public static const §_-6g§:int = 6000;
      
      private static const final:int = 25;
      
      public static const §_-nn§:int = 6;
      
      public static const §_-nD§:int = 4;
      
      public static const §_-XC§:Number = 0.275 / 128;
      
      public static const §_-bs§:int = -2;
      
      public static const §_-8f§:int = 8;
      
      public static const §_-b3§:int = 5;
      
      public static const §_-Rl§:String = "5";
       
      
      private var §_-Yj§:Number = 1.0;
      
      public var §_-Y4§:int = 0;
      
      public var §_-U2§:int = 0;
      
      public var speedBonus:§_-Ov§;
      
      private var §_-HZ§:Vector.<IBlitzLogicHandler>;
      
      public var scoreKeeper:§_-ZG§;
      
      private var §_-Zv§:int;
      
      private var §_-EH§:Vector.<Number>;
      
      public var §_-WI§:int = 0;
      
      private var §_-X-§:§_-fO§;
      
      private var §_-US§:int = 6000;
      
      public var coinTokenLogic:§_-l8§;
      
      private var §_-mA§:Boolean = false;
      
      private var §_-k4§:Array;
      
      public var blazingSpeedBonus:§_-df§;
      
      private var §_-cl§:Boolean = false;
      
      private var §_-6f§:Boolean = false;
      
      private var §_-dT§:Vector.<MatchSet>;
      
      public var §_-1e§:Vector.<BlitzEvent>;
      
      private var §_-iS§:§_-fO§;
      
      public var moves:Vector.<MoveData>;
      
      public var random:§_-fO§;
      
      public var isActive:Boolean = false;
      
      public var hadReplayError:Boolean = false;
      
      public var board:§_-2j§;
      
      public var §_-1K§:int = 0;
      
      public var §_-T0§:Vector.<BlitzScoreValue>;
      
      public var §_-ah§:Vector.<Match>;
      
      public var isPaused:Boolean = false;
      
      public var §_-OK§:Array;
      
      public var §_-Vi§:Vector.<BlitzScoreValue>;
      
      private var §default§:§_-fO§;
      
      public var §_-HD§:int = 0;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-Uk§:Array;
      
      public var hypercubeLogic:§_-Hv§;
      
      public var swaps:Vector.<SwapData>;
      
      public var grid:§_-aY§;
      
      public var frameID:int = 0;
      
      private var §_-kx§:Vector.<BlitzEvent>;
      
      public var badMove:Boolean = false;
      
      public var mBlockingEvents:Vector.<BlitzEvent>;
      
      public var §_-Va§:Boolean = false;
      
      private var §_-GP§:§_-fO§;
      
      public var compliments:§_-Q6§;
      
      public var boostLogic:§_-FI§;
      
      private var §_-as§:int = 0;
      
      public var flameGemLogic:§_-4P§;
      
      public var multiLogic:§_-ek§;
      
      private var §_-FH§:int = 0;
      
      public var §_-J1§:int = 0;
      
      public var §_-aZ§:Boolean = false;
      
      private var §_-5K§:§_-fO§;
      
      public var §_-ZE§:Vector.<SwapData>;
      
      public var §_-KX§:Vector.<BlitzEvent>;
      
      private var §_-AB§:int = 0;
      
      public var starGemLogic:§_-Dx§;
      
      public var gemsHit:Boolean = false;
      
      public var startedMove:Boolean = false;
      
      public var §_-ld§:Boolean = true;
      
      private var §_-f3§:int = 175;
      
      public function BlitzLogic(param1:§_-0Z§)
      {
         this.§_-OK§ = [];
         this.§_-ah§ = new Vector.<Match>();
         this.§_-dT§ = new Vector.<MatchSet>();
         this.§_-k4§ = new Array();
         this.§_-Uk§ = [];
         this.§_-Zv§ = 5 + Math.random() * 10;
         super();
         this.§_-Lp§ = param1;
         this.random = new §_-fO§(new §_-4y§());
         this.§_-GP§ = new §_-fO§(new §_-4y§());
         this.§_-iS§ = new §_-fO§(new §_-4y§());
         this.§_-5K§ = new §_-fO§(new §_-4y§());
         this.§_-X-§ = new §_-fO§(new §_-4y§());
         this.§default§ = new §_-fO§(new §_-4y§());
         this.grid = new §_-aY§(§_-1s§,§_-8f§);
         this.board = new §_-2j§(this.random);
         this.moves = new Vector.<MoveData>();
         this.§_-EH§ = new Vector.<Number>(§_-2j§.§_-IP§,true);
         this.swaps = new Vector.<SwapData>();
         this.§_-ZE§ = new Vector.<SwapData>();
         this.mBlockingEvents = new Vector.<BlitzEvent>();
         this.§_-KX§ = new Vector.<BlitzEvent>();
         this.§_-1e§ = new Vector.<BlitzEvent>();
         this.§_-kx§ = new Vector.<BlitzEvent>();
         this.scoreKeeper = new §_-ZG§(this);
         this.speedBonus = new §_-Ov§(param1);
         this.multiLogic = new §_-ek§(this);
         this.blazingSpeedBonus = new §_-df§(param1);
         this.starGemLogic = new §_-Dx§(param1);
         this.hypercubeLogic = new §_-Hv§(param1);
         this.flameGemLogic = new §_-4P§(param1);
         this.coinTokenLogic = new §_-l8§(param1,this);
         this.boostLogic = new §_-FI§(param1);
         this.compliments = new §_-Q6§(this);
         this.§_-T0§ = new Vector.<BlitzScoreValue>();
         this.§_-Vi§ = new Vector.<BlitzScoreValue>();
         this.§_-HZ§ = new Vector.<IBlitzLogicHandler>();
      }
      
      private function §_-en§(param1:MoveData) : void
      {
         param1.§_-5Y§.§_-aC§ = param1.id;
         param1.§_-5Y§.§_-iH§ = true;
      }
      
      private function §_-8D§() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!((_loc4_ = _loc1_[_loc3_]) == null || !_loc4_.§_-90§))
            {
               this.starGemLogic.§false§(_loc4_);
               this.flameGemLogic.§false§(_loc4_);
               this.hypercubeLogic.§false§(_loc4_);
               this.multiLogic.§false§(_loc4_);
               _loc4_.§_-Ko§();
            }
            _loc3_++;
         }
      }
      
      public function §_-Wr§(param1:Number, param2:Number, param3:Gem) : void
      {
         var _loc15_:Gem = null;
         var _loc4_:Number = param2 - 1.5;
         var _loc5_:Number = param2 + 1.5;
         var _loc6_:Number = param1 - 1.5;
         var _loc7_:Number = param1 + 1.5;
         var _loc9_:Number = §_-2j§.§_-IP§ - 0.5;
         var _loc11_:Number = §_-2j§.§_-H0§ - 0.5;
         _loc4_ = _loc4_ > -0.5 ? Number(_loc4_) : Number(-0.5);
         _loc5_ = _loc5_ < _loc9_ ? Number(_loc5_) : Number(_loc9_);
         _loc6_ = _loc6_ > -0.5 ? Number(_loc6_) : Number(-0.5);
         _loc7_ = _loc7_ < _loc11_ ? Number(_loc7_) : Number(_loc11_);
         var _loc12_:Vector.<Gem>;
         var _loc13_:int = (_loc12_ = this.board.mGems).length;
         var _loc14_:int = 0;
         while(_loc14_ < _loc13_)
         {
            if(!((_loc15_ = _loc12_[_loc14_]).x < _loc4_ || _loc15_.x > _loc5_ || _loc15_.y < _loc6_ || _loc15_.y > _loc7_))
            {
               _loc15_.§_-Mj§(param3);
            }
            _loc14_++;
         }
      }
      
      private function §_-Bm§(param1:int) : Gem
      {
         var _loc2_:int = int(param1 / §_-2j§.§_-IP§);
         var _loc3_:int = param1 % §_-2j§.§_-IP§;
         return this.board.§_-9K§(_loc2_,_loc3_);
      }
      
      public function GetTimeRemaining() : int
      {
         return this.§_-as§;
      }
      
      private function §_-KT§() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!((_loc4_ = _loc1_[_loc3_]) == null || !_loc4_.§_-iH§))
            {
               this.starGemLogic.§_-RR§(_loc4_);
               this.flameGemLogic.§_-RR§(_loc4_);
               this.hypercubeLogic.§_-RR§(_loc4_);
               this.multiLogic.§_-RR§(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function §_-I4§() : void
      {
         var _loc4_:BlitzScoreValue = null;
         var _loc1_:int = this.§_-T0§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = this.§_-T0§[_loc2_];
            this.§_-kI§(_loc4_);
            this.§_-J1§ += _loc4_.value;
            this.§_-Vi§.push(_loc4_);
            _loc2_++;
         }
         this.§_-T0§.length = 0;
         this.speedBonus.Update();
         this.scoreKeeper.§_-gm§ = this.speedBonus.§_-lY§();
         var _loc3_:Boolean = this.board.§_-oP§() && this.mBlockingEvents.length == 0;
         this.scoreKeeper.Update(_loc3_);
         this.blazingSpeedBonus.Update(this.§_-ah§,this);
      }
      
      private function §_-gZ§() : void
      {
         var _loc4_:MatchSet = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Match = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Gem = null;
         this.§_-dT§.length = 0;
         this.§_-ah§.length = 0;
         var _loc1_:Vector.<MatchSet> = this.board.§_-mh§();
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]).§_-ki§ != true)
            {
               this.§_-dT§.push(_loc4_);
               _loc5_ = _loc4_.§_-ie§.length;
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  (_loc7_ = _loc4_.§_-ie§[_loc6_]).§_-X5§ = this.§_-WI§;
                  this.§_-ah§.push(_loc7_);
                  ++this.§_-WI§;
                  _loc8_ = -1;
                  _loc9_ = _loc7_.mGems.length;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     (_loc11_ = _loc7_.mGems[_loc10_]).Match(_loc7_.§_-X5§);
                     _loc8_ = _loc11_.§_-aC§ > _loc8_ ? int(_loc11_.§_-aC§) : int(_loc8_);
                     _loc10_++;
                  }
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     (_loc11_ = _loc7_.mGems[_loc10_]).§_-aC§ = _loc8_;
                     _loc10_++;
                  }
                  _loc6_++;
               }
            }
            _loc3_++;
         }
      }
      
      public function QueueSwap(param1:Gem, param2:int, param3:int) : Boolean
      {
         if(this.§_-as§ <= 0)
         {
            return true;
         }
         if(this.mBlockingEvents.length > 0)
         {
            return false;
         }
         if(!this.§_-A3§(param1,param2,param3))
         {
            return false;
         }
         var _loc4_:Gem = this.board.§_-9K§(param2,param3);
         this.§_-IN§(§_-nD§,param1.id,_loc4_.id);
         return true;
      }
      
      public function QueueDetonate(param1:Gem) : void
      {
         if(this.§_-as§ <= 0)
         {
            return;
         }
         if(this.mBlockingEvents.length > 0)
         {
            return;
         }
         this.§_-IN§(§_-b3§,param1.id);
      }
      
      public function §_-LB§(param1:int, param2:int) : void
      {
         var _loc3_:Gem = this.board.§_-9K§(param1,param2);
         this.flameGemLogic.§_-gg§(_loc3_,null,true);
      }
      
      public function QueueRemoveGem(param1:Gem) : void
      {
         this.§_-IN§(§_-Ta§,param1.id);
      }
      
      public function §_-H§(param1:int) : void
      {
         this.§_-as§ = Math.max(0,Math.min(this.§_-US§,param1));
      }
      
      public function AddBlitzLogicHandler(param1:IBlitzLogicHandler) : void
      {
         this.§_-HZ§.push(param1);
      }
      
      public function Resume() : void
      {
         this.blazingSpeedBonus.Resume();
      }
      
      public function §_-1Z§(param1:BlitzEvent) : void
      {
         this.mBlockingEvents.push(param1);
         this.§_-kx§.push(param1);
      }
      
      private function §throw§(param1:MoveData, param2:int) : void
      {
         var _loc3_:Gem = param1.§_-5Y§;
         _loc3_.§_-aC§ = param1.id;
         switch(param2)
         {
            case Gem.§_-Q3§:
               this.flameGemLogic.§_-gg§(_loc3_,null,true);
               break;
            case Gem.§_-N3§:
               this.starGemLogic.§_-gg§(_loc3_,null,null,true);
               break;
            case Gem.§_-l0§:
               this.hypercubeLogic.§_-gg§(_loc3_,null,true);
         }
      }
      
      public function Quit() : void
      {
         var _loc1_:IBlitzLogicHandler = null;
         this.blazingSpeedBonus.Quit();
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-fD§();
         }
      }
      
      public function QueueChangeGemColor(param1:Gem, param2:int) : void
      {
         this.§_-IN§(§_-YB§,param1.id,param2);
      }
      
      protected function §_-on§() : void
      {
         var _loc1_:IBlitzLogicHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-fD§();
         }
      }
      
      private function §_-7b§(param1:Array) : void
      {
         var _loc4_:MoveData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = param1[0];
         var _loc3_:Gem = this.board.§_-gH§(param1[2]);
         (_loc4_ = new MoveData()).§_-5Y§ = _loc3_;
         this.§_-mx§(_loc4_);
         switch(_loc2_)
         {
            case §_-Ta§:
               this.§_-X8§(_loc4_);
               break;
            case §_-TL§:
               this.§_-en§(_loc4_);
               break;
            case §_-k2§:
               this.§throw§(_loc4_,this.board.§_-gH§(param1[3]).id);
               break;
            case §_-YB§:
               this.§_-Ge§(_loc4_,this.board.§_-gH§(param1[3]).id);
               break;
            case §_-nD§:
               _loc4_.§_-5p§ = this.board.§_-gH§(param1[3]);
               _loc4_.§_-fr§.x = _loc3_.§_-pX§;
               _loc4_.§_-fr§.y = _loc3_.§_-dg§;
               _loc5_ = _loc4_.§_-5p§.§_-pX§;
               _loc6_ = _loc4_.§_-5p§.§_-dg§;
               _loc4_.§_-hK§ = true;
               _loc4_.§_-6O§.x = _loc5_ - _loc3_.§_-pX§;
               _loc4_.§_-6O§.y = _loc6_ - _loc3_.§_-dg§;
               _loc4_.§_-fC§.x = _loc5_;
               _loc4_.§_-fC§.y = _loc6_;
               this.§_-DM§(_loc4_);
               break;
            case §_-b3§:
            case §_-nn§:
               this.§_-ab§(_loc4_);
         }
      }
      
      public function §_-4i§(param1:int) : BlitzScoreValue
      {
         var _loc2_:BlitzScoreValue = new BlitzScoreValue();
         _loc2_.time = this.frameID;
         _loc2_.value = param1;
         this.§_-T0§.push(_loc2_);
         return _loc2_;
      }
      
      private function §_-Fj§(param1:MoveData) : void
      {
         var _loc2_:Gem = param1.§_-5Y§;
         if(_loc2_.§_-F6§ <= 0 || !this.§_-cl§)
         {
            return;
         }
         --_loc2_.§_-F6§;
         if(_loc2_.§_-F6§ == 0)
         {
            _loc2_.§_-NZ§ = true;
         }
         this.§_-Xq§();
         this.§_-1Z§(new ScrambleEvent(this.§_-Lp§,param1));
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_SCRAMBLE_USE);
      }
      
      public function §_-JS§() : Boolean
      {
         var _loc1_:BlitzEvent = null;
         for each(_loc1_ in this.§_-1e§)
         {
            if(_loc1_ is ScrambleDelayEvent)
            {
               return false;
            }
         }
         for each(_loc1_ in this.mBlockingEvents)
         {
            if(_loc1_ is ScrambleEvent)
            {
               return false;
            }
         }
         return true;
      }
      
      private function §_-Ge§(param1:MoveData, param2:int) : void
      {
         param1.§_-5Y§.color = param2;
         param1.§_-5Y§.§_-aC§ = param1.id;
      }
      
      private function §_-Nf§() : void
      {
         var _loc2_:BlitzEvent = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.§_-KX§)
         {
            _loc2_.Update(this.§_-Yj§);
            _loc1_ = _loc1_ && _loc2_.IsDone();
         }
         if(_loc1_)
         {
            this.§_-KX§.length = 0;
         }
      }
      
      public function QueueDestroyGem(param1:Gem) : void
      {
         this.§_-IN§(§_-TL§,param1.id);
      }
      
      public function update() : void
      {
         var numMatches:int = 0;
         var j:int = 0;
         var m:Match = null;
         try
         {
            §_-3D§.§_-Tj§().§_-oA§("UpdateStartEvent");
            this.gemsHit = false;
            if(this.§_-mA§)
            {
               return;
            }
            this.startedMove = false;
            this.badMove = false;
            this.§_-7A§();
            this.§_-9B§();
            this.§_-dT§.length = 0;
            this.§_-ah§.length = 0;
            if(this.mBlockingEvents.length == 0)
            {
               if(!this.§_-6f§)
               {
                  this.§_-H8§();
               }
            }
            this.§_-4v§();
            if(this.mBlockingEvents.length == 0)
            {
               this.§_-QP§(true);
               this.§_-ZY§(this.§_-Yj§);
            }
            else
            {
               this.§_-O4§();
            }
            if(this.§_-ld§)
            {
               this.§_-gZ§();
            }
            this.§_-Cz§();
            this.blazingSpeedBonus.§_-lT§();
            this.§_-FW§();
            this.§_-8D§();
            numMatches = this.§_-ah§.length;
            j = 0;
            m = null;
            j = 0;
            while(j < numMatches)
            {
               m = this.§_-ah§[j];
               this.starGemLogic.§_-KV§(m);
               j++;
            }
            j = 0;
            while(j < numMatches)
            {
               m = this.§_-ah§[j];
               this.hypercubeLogic.§_-KV§(m);
               j++;
            }
            j = 0;
            while(j < numMatches)
            {
               m = this.§_-ah§[j];
               this.flameGemLogic.§_-KV§(m);
               j++;
            }
            this.§_-KT§();
            this.§_-8D§();
            this.§_-C8§();
            this.§_-cu§();
            this.§_-az§();
            §_-3D§.§_-Tj§().§_-oA§("GemPhaseEnd");
            this.§_-HW§();
            this.§_-I4§();
            this.compliments.Update();
            this.§_-0v§();
            this.§_-R6§();
            §_-3D§.§_-Tj§().§_-oA§("UpdateEndEvent");
         }
         catch(err:Error)
         {
            if(§_-aZ§)
            {
               hadReplayError = true;
            }
         }
      }
      
      public function get numMatches() : int
      {
         return this.§_-WI§;
      }
      
      private function §_-HW§() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc1_:int = §_-2j§.§_-XG§;
         var _loc2_:int = §_-2j§.§_-L6§;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = -1;
            _loc5_ = -1;
            _loc6_ = this.§_-k4§[_loc3_].matchId;
            _loc7_ = this.§_-k4§[_loc3_].moveId;
            _loc8_ = _loc2_ - 1;
            while(_loc8_ >= 0)
            {
               if((_loc9_ = this.board.§_-9K§(_loc8_,_loc3_)) != null)
               {
                  if(_loc9_.§_-hk§ || _loc9_.§_-k0§ || _loc9_.§_-Lc§ || _loc9_.§_-RO§)
                  {
                     _loc4_ = _loc4_ > _loc9_.§_-X5§ ? int(_loc4_) : int(_loc9_.§_-X5§);
                     _loc5_ = _loc5_ > _loc9_.§_-aC§ ? int(_loc5_) : int(_loc9_.§_-aC§);
                     _loc6_ = _loc4_ > _loc6_ ? int(_loc4_) : int(_loc6_);
                     _loc7_ = _loc5_ > _loc7_ ? int(_loc5_) : int(_loc7_);
                  }
                  if(_loc4_ > _loc9_.§_-X5§)
                  {
                     _loc9_.§_-X5§ = _loc4_;
                  }
                  if(_loc5_ > _loc9_.§_-aC§)
                  {
                     _loc9_.§_-aC§ = _loc5_;
                  }
                  if(_loc9_.y < -1)
                  {
                     _loc9_.§_-X5§ = _loc6_;
                     _loc9_.§_-aC§ = _loc7_;
                  }
               }
               _loc8_--;
            }
            this.§_-k4§[_loc3_].matchId = _loc6_;
            this.§_-k4§[_loc3_].moveId = _loc7_;
            _loc3_++;
         }
      }
      
      private function §_-ab§(param1:MoveData) : void
      {
         var _loc2_:Gem = param1.§_-5Y§;
         if(_loc2_.type == Gem.§_-72§)
         {
            this.§_-aJ§(param1);
         }
         else if(_loc2_.type == Gem.§_-nT§)
         {
            this.§_-Fj§(param1);
         }
      }
      
      public function §for §(param1:BlitzEvent) : void
      {
         this.§_-KX§.push(param1);
         this.§_-kx§.push(param1);
      }
      
      private function §_-Xq§() : void
      {
         var _loc3_:SwapData = null;
         var _loc1_:int = this.swaps.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.swaps[_loc2_];
            _loc3_.§_-iX§.§_-5Y§.§_-Lc§ = false;
            _loc3_.§_-iX§.§_-5Y§.§_-4D§ = false;
            _loc3_.§_-iX§.§_-5p§.§_-Lc§ = false;
            _loc3_.§_-iX§.§_-5p§.§_-4D§ = false;
            _loc2_++;
         }
         this.swaps.length = 0;
      }
      
      private function §_-XL§() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:int = this.§_-OK§.length;
         for(; this.§_-HD§ < _loc1_; ++this.§_-HD§)
         {
            _loc2_ = this.§_-OK§[this.§_-HD§];
            _loc3_ = _loc2_[0];
            if(_loc3_ > 0)
            {
               break;
            }
            switch(_loc3_)
            {
               case §_-hc§:
                  this.§_-1K§ = _loc2_[1];
                  this.random.§_-9H§(this.§_-1K§);
                  this.§_-s§();
                  continue;
               case §_-bs§:
                  this.boostLogic.§_-2a§(_loc2_[1]);
                  continue;
               default:
                  continue;
            }
         }
      }
      
      public function GetTimeElapsed() : int
      {
         return this.§_-US§ - this.§_-as§;
      }
      
      public function QueueScramble(param1:Gem) : void
      {
         if(this.§_-as§ <= 0)
         {
            return;
         }
         if(this.mBlockingEvents.length > 0)
         {
            return;
         }
         this.§_-IN§(§_-nn§,param1.id);
      }
      
      private function §_-FW§() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!((_loc4_ = _loc1_[_loc3_]) == null || !_loc4_.§_-iu§))
            {
               this.starGemLogic.§_-Gw§(_loc4_);
               this.flameGemLogic.§_-Gw§(_loc4_);
               this.hypercubeLogic.§_-Gw§(_loc4_);
               this.multiLogic.§_-Gw§(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function §_-QP§(param1:Boolean) : void
      {
         var _loc7_:Gem = null;
         var _loc2_:§_-3D§ = §_-3D§.§_-Tj§();
         var _loc3_:Boolean = false;
         _loc2_.§_-oA§("SpawnCancelEvent");
         var _loc4_:Vector.<Gem>;
         var _loc5_:int = (_loc4_ = this.board.mGems).length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if((_loc7_ = _loc4_[_loc6_]) != null)
            {
               if(_loc7_.§_-68§ > 0 || _loc7_.§_-90§)
               {
                  _loc3_ = true;
                  break;
               }
            }
            _loc6_++;
         }
         if(_loc3_)
         {
            return;
         }
         _loc2_.§_-oA§("SpawnBeginEvent");
         this.board.§_-eg§();
         this.§_-ff§(param1);
         _loc2_.§_-oA§("SpawnEndEvent");
         this.multiLogic.§_-FM§();
      }
      
      private function §_-C8§() : void
      {
         var _loc1_:BlitzEvent = null;
         for each(_loc1_ in this.§_-kx§)
         {
            _loc1_.Init();
         }
         this.§_-kx§.length = 0;
      }
      
      private function §_-R6§() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Gem = null;
         var _loc7_:MoveData = null;
         var _loc1_:Boolean = this.board.§_-oP§();
         if(this.§_-Kb§ && _loc1_)
         {
            _loc2_ = 0;
            _loc3_ = this.§_-f3§;
            this.§_-f3§ = final;
            _loc4_ = 0;
            while(_loc4_ < §_-2j§.§_-H0§)
            {
               _loc5_ = 0;
               while(_loc5_ < §_-2j§.§_-IP§)
               {
                  if((_loc6_ = this.board.§_-9K§(_loc4_,_loc5_)).type != Gem.§_-Jz§)
                  {
                     (_loc7_ = new MoveData()).§_-5Y§ = _loc6_;
                     _loc7_.§_-fr§.x = _loc6_.§_-pX§;
                     _loc7_.§_-fr§.y = _loc6_.§_-dg§;
                     this.§_-mx§(_loc7_);
                     _loc6_.§_-68§ = _loc3_;
                     _loc6_.§_-aC§ = _loc7_.id;
                     _loc6_.§_-7f§ = _loc6_.color;
                     _loc6_.§_-Lo§ = _loc6_.type;
                     if(_loc6_.type == Gem.§_-72§ || _loc6_.type == Gem.§_-nT§)
                     {
                        _loc6_.§_-Ki§ = 1500;
                     }
                     _loc3_ += 25;
                     _loc2_++;
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
            if(_loc2_ == 0)
            {
               this.coinTokenLogic.§_-a2§();
               if(this.coinTokenLogic.§_-bc§)
               {
                  this.§_-mA§ = true;
                  this.gemsHit = false;
                  this.§_-on§();
               }
            }
         }
         if(this.§_-as§ == 0 && _loc1_)
         {
            if(this.§_-AB§ > 0)
            {
               --this.§_-AB§;
               return;
            }
            this.§_-6f§ = true;
            this.blazingSpeedBonus.Reset();
         }
      }
      
      private function §_-Aa§() : void
      {
         var _loc2_:BlitzEvent = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.mBlockingEvents)
         {
            _loc2_.Update(this.§_-Yj§);
            _loc1_ = _loc1_ && _loc2_.IsDone();
         }
         if(_loc1_)
         {
            this.mBlockingEvents.length = 0;
         }
      }
      
      public function GetScore() : int
      {
         return this.scoreKeeper.score;
      }
      
      private function §_-ff§(param1:Boolean) : void
      {
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Gem = null;
         var _loc2_:§_-3D§ = §_-3D§.§_-Tj§();
         var _loc3_:Vector.<Gem> = this.board.§_-ff§();
         var _loc4_:Boolean = false;
         if(_loc3_.length == 0)
         {
            return;
         }
         if(_loc3_.length == 1)
         {
            _loc7_ = (_loc6_ = [Gem.§_-Y7§,Gem.§_-md§,Gem.§_-AH§,Gem.§_-Zz§,Gem.§ use§,Gem.§_-70§,Gem.§_-8M§]).length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc9_ = this.random.§_-Nn§(_loc7_);
               _loc10_ = _loc6_[_loc8_];
               _loc11_ = _loc6_[_loc9_];
               _loc6_[_loc8_] = _loc11_;
               _loc6_[_loc9_] = _loc10_;
               _loc8_++;
            }
            while(!_loc4_ && _loc6_.length > 0)
            {
               _loc12_ = _loc6_.shift();
               (_loc13_ = _loc3_[0]).color = _loc12_;
               _loc2_.§_-oA§("SpawnAcceptEvent");
               _loc4_ = this.§_-gz§(param1);
            }
            _loc4_ = true;
         }
         while(!_loc4_)
         {
            this.board.§_-8a§(_loc3_);
            _loc2_.§_-oA§("SpawnAcceptEvent");
            _loc4_ = this.§_-gz§(param1);
         }
      }
      
      public function §_-dY§(param1:int, param2:int) : void
      {
         var _loc3_:Gem = this.board.§_-9K§(param1,param2);
         this.hypercubeLogic.§_-gg§(_loc3_,null,true);
      }
      
      public function §_-WB§(param1:int) : void
      {
         this.§_-US§ = Math.max(0,param1);
      }
      
      public function DeserializeCommands(param1:ByteArray) : void
      {
         var commandID:int = 0;
         var command:Array = null;
         var numArgs:int = 0;
         var i:int = 0;
         var buffer:ByteArray = param1;
         try
         {
            this.§_-aZ§ = true;
            this.§_-OK§.length = 0;
            buffer.uncompress();
            while(buffer.bytesAvailable > 0)
            {
               commandID = buffer.readByte();
               command = [];
               command[0] = commandID;
               if(commandID >= 0)
               {
                  command.push(buffer.readUnsignedShort());
                  numArgs = buffer.readUnsignedByte();
                  i = 0;
                  while(i < numArgs)
                  {
                     command.push(buffer.readUnsignedShort());
                     i++;
                  }
               }
               else if(command[0] == §_-hc§)
               {
                  command.push(buffer.readInt());
               }
               else if(command[0] == §_-bs§)
               {
                  command.push(buffer.readUnsignedByte());
               }
               this.§_-OK§.push(command);
            }
         }
         catch(err:Error)
         {
            hadReplayError = true;
         }
      }
      
      private function §_-C9§(param1:Gem) : int
      {
         return param1.§_-dg§ * §_-2j§.§_-IP§ + param1.§_-pX§;
      }
      
      private function §_-az§() : void
      {
         var _loc3_:Gem = null;
         var _loc1_:int = this.board.mGems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.board.mGems[_loc2_];
            if(_loc3_ != null)
            {
               if(_loc3_.§_-iH§)
               {
                  this.§_-KX§.push(new ShatterEvent(_loc3_));
               }
               else if(_loc3_.§_-iu§)
               {
                  this.§_-KX§.push(new MatchEvent(_loc3_));
               }
               if(this.§_-Kb§ && _loc3_.type == Gem.§_-ec§)
               {
                  if(_loc3_.§_-68§ == 0 && _loc3_.§_-8K§)
                  {
                     _loc3_.§_-NX§(true);
                     if(_loc3_.§_-iH§)
                     {
                        this.§_-KX§.push(new ShatterEvent(_loc3_));
                     }
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function §_-IN§(param1:int, ... rest) : void
      {
         if(this.§_-aZ§)
         {
            return;
         }
         var _loc3_:Array = [param1];
         if(param1 >= 0)
         {
            _loc3_.push(this.frameID);
         }
         var _loc4_:int = rest.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_.push(rest[_loc5_]);
            _loc5_++;
         }
         if(param1 >= 0)
         {
            this.§_-Uk§.push(_loc3_);
         }
         this.§_-OK§.push(_loc3_);
      }
      
      public function §_-kJ§(param1:Number) : void
      {
         this.§_-Yj§ = param1;
      }
      
      public function §_-6e§() : String
      {
         if(!this.§_-Lp§.static)
         {
            return "";
         }
         var _loc1_:ByteArray = this.§_-Lp§.logic.§_-Yv§();
         return Base64.§_-oz§(_loc1_).toString();
      }
      
      public function Init() : void
      {
         this.boostLogic.Init();
      }
      
      public function Reset() : void
      {
         var _loc2_:int = 0;
         this.§_-AB§ = §_-PK§;
         this.isPaused = false;
         this.§_-mA§ = false;
         this.hadReplayError = false;
         this.§_-cl§ = false;
         this.§_-k4§[0] = {
            "moveId":-1,
            "matchId":-1
         };
         this.§_-k4§[1] = {
            "moveId":-1,
            "matchId":-1
         };
         this.§_-k4§[2] = {
            "moveId":-1,
            "matchId":-1
         };
         this.§_-k4§[3] = {
            "moveId":-1,
            "matchId":-1
         };
         this.§_-k4§[4] = {
            "moveId":-1,
            "matchId":-1
         };
         this.§_-k4§[5] = {
            "moveId":-1,
            "matchId":-1
         };
         this.§_-k4§[6] = {
            "moveId":-1,
            "matchId":-1
         };
         this.§_-k4§[7] = {
            "moveId":-1,
            "matchId":-1
         };
         this.moves.length = 0;
         this.board.Reset();
         this.grid.Reset();
         this.scoreKeeper.Reset();
         this.speedBonus.Reset();
         this.multiLogic.Reset();
         this.blazingSpeedBonus.Reset();
         this.compliments.Reset();
         this.starGemLogic.Reset();
         this.hypercubeLogic.Reset();
         this.flameGemLogic.Reset();
         this.coinTokenLogic.Reset();
         this.§_-ah§.length = 0;
         this.§_-dT§.length = 0;
         this.§_-Uk§.length = 0;
         this.swaps.length = 0;
         this.§_-ZE§.length = 0;
         this.mBlockingEvents.length = 0;
         this.§_-1e§.length = 0;
         this.§_-KX§.length = 0;
         this.§_-kx§.length = 0;
         this.§_-J1§ = 0;
         this.§_-T0§.length = 0;
         this.§_-Vi§.length = 0;
         this.§_-WI§ = 0;
         this.frameID = 0;
         this.§_-US§ = §_-6g§;
         this.§_-as§ = this.§_-US§;
         this.startedMove = false;
         this.badMove = false;
         this.gemsHit = false;
         this.§_-FH§ = 0;
         this.§_-U2§ = 0;
         this.§_-6f§ = false;
         this.§_-f3§ = final;
         var _loc1_:int = 0;
         while(_loc1_ < this.§_-EH§.length)
         {
            this.§_-EH§[_loc1_] = 0;
            _loc1_++;
         }
         this.§_-Yj§ = §_-20§;
         this.boostLogic.§_-Um§();
         this.§_-HD§ = 0;
         if(this.§_-aZ§ == false)
         {
            _loc2_ = new Date().time;
            this.random.§_-9H§(_loc2_);
            this.§_-1K§ = _loc2_;
            this.§_-OK§.length = 0;
            this.§_-IN§(§_-hc§,_loc2_);
            this.§_-s§();
         }
         else
         {
            this.§_-XL§();
         }
         this.§_-QP§(false);
         this.boostLogic.§_-BR§();
         this.§_-Va§ = false;
      }
      
      public function get isGameOver() : Boolean
      {
         return this.§_-mA§;
      }
      
      public function §_-39§(param1:BlitzEvent) : void
      {
         this.§_-1e§.push(param1);
         this.§_-kx§.push(param1);
      }
      
      public function §_-A3§(param1:Gem, param2:int, param3:int) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(!param1.§_-V9§())
         {
            return false;
         }
         var _loc4_:Gem;
         if((_loc4_ = this.board.§_-9K§(param2,param3)) != null)
         {
            if(!_loc4_.§_-V9§())
            {
               return false;
            }
         }
         if(param2 < §_-2j§.§_-ou§ || param2 > §_-2j§.§_-dp§ || param3 < §_-2j§.LEFT || param3 > §_-2j§.RIGHT)
         {
            return false;
         }
         var _loc5_:int = param3 - param1.§_-pX§;
         var _loc6_:int = param2 - param1.§_-dg§;
         if(Math.abs(_loc5_) + Math.abs(_loc6_) != 1)
         {
            return false;
         }
         return true;
      }
      
      private function §_-Cz§() : void
      {
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = _loc1_.length;
         this.grid.§_-dx§();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               _loc5_ = int(_loc4_.y + 0.5);
               _loc6_ = int(_loc4_.x + 0.5);
               this.grid.§_-QW§(_loc5_,_loc6_,_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function §_-0v§() : void
      {
         ++this.frameID;
         if(this.mBlockingEvents.length == 0)
         {
            if(this.isActive && !this.§_-Kb§ && this.§_-as§ > 0)
            {
               if(this.§_-Y4§ == 0)
               {
                  --this.§_-as§;
                  §_-3D§.§_-Tj§().§_-oA§("BlitzTimeEvent");
               }
               if(this.§_-Y4§ > 0)
               {
                  --this.§_-Y4§;
               }
               if(this.§_-as§ == 0)
               {
                  if(this.§_-U2§ > 0)
                  {
                     this.§_-US§ += this.§_-U2§;
                     this.§_-as§ += this.§_-U2§;
                     this.§_-U2§ = 0;
                     this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_VOICE_EXTRA_TIME);
                  }
                  else
                  {
                     this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_VOICE_TIME_UP);
                  }
               }
            }
         }
      }
      
      private function §_-H8§() : void
      {
         var _loc1_:MoveData = null;
         var _loc2_:Array = null;
         if(this.§_-aZ§)
         {
            this.§_-I1§();
         }
         while(this.§_-Uk§.length > 0)
         {
            _loc2_ = this.§_-Uk§.shift();
            this.§_-7b§(_loc2_);
         }
         for each(_loc1_ in this.moves)
         {
            _loc1_.isActive = _loc1_.isActive && !this.board.§_-oP§();
         }
      }
      
      public function §_-Yv§() : ByteArray
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!this.§_-Lp§.static)
         {
            return null;
         }
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = Endian.LITTLE_ENDIAN;
         for each(_loc2_ in this.§_-OK§)
         {
            _loc3_ = _loc2_[0];
            if(_loc3_ < 0)
            {
               if(_loc3_ == §_-hc§)
               {
                  _loc1_.writeByte(§_-hc§);
                  _loc1_.writeInt(_loc2_[1]);
               }
               else if(_loc3_ == §_-bs§)
               {
                  _loc1_.writeByte(§_-bs§);
                  _loc1_.writeByte(_loc2_[1]);
               }
            }
            else
            {
               _loc1_.writeByte(_loc3_);
               _loc1_.writeShort(_loc2_[1]);
               _loc1_.writeByte(_loc2_.length - 2);
               _loc4_ = _loc2_.length;
               _loc5_ = 2;
               while(_loc5_ < _loc4_)
               {
                  _loc1_.writeShort(_loc2_[_loc5_]);
                  _loc5_++;
               }
            }
         }
         _loc1_.compress();
         return _loc1_;
      }
      
      private function §_-9B§() : void
      {
         this.§_-Aa§();
         if(this.mBlockingEvents.length == 0)
         {
            this.§_-3F§();
         }
         this.§_-Nf§();
      }
      
      private function §_-cu§() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = this.board.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               this.multiLogic.§_-Wt§(_loc4_);
            }
            _loc3_++;
         }
      }
      
      private function §_-7A§() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               _loc4_.update();
            }
            _loc3_++;
         }
      }
      
      private function §_-I1§() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = this.§_-OK§.length;
         while(this.§_-HD§ < _loc1_)
         {
            _loc2_ = this.§_-OK§[this.§_-HD§];
            _loc3_ = _loc2_[0];
            if(_loc3_ < 0)
            {
               throw new Error("Encountered a header command after the header.");
            }
            if((_loc4_ = _loc2_[1]) != this.frameID)
            {
               break;
            }
            this.§_-Uk§.push(_loc2_);
            ++this.§_-HD§;
         }
      }
      
      private function §_-kI§(param1:BlitzScoreValue) : void
      {
         this.multiLogic.§_-kI§(param1);
      }
      
      private function §_-gz§(param1:Boolean) : Boolean
      {
         var _loc3_:Vector.<MatchSet> = null;
         if(!param1)
         {
            _loc3_ = this.board.§_-mh§();
            if(_loc3_.length > 0)
            {
               return false;
            }
         }
         var _loc2_:Vector.<MoveData> = this.board.§_-BY§.§true§(this.board);
         return _loc2_.length > 0;
      }
      
      public function §_-BO§(param1:Vector.<IBoost>) : void
      {
         var _loc2_:IBoost = null;
         for each(_loc2_ in param1)
         {
            this.§_-IN§(§_-bs§,_loc2_.§_-dW§());
         }
      }
      
      private function §_-ZY§(param1:Number) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc2_:Number = §_-XC§ * param1;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         this.gemsHit = false;
         var _loc5_:int = 0;
         while(_loc5_ < §_-2j§.§_-IP§)
         {
            _loc6_ = §_-2j§.§_-H0§;
            _loc7_ = 0;
            _loc8_ = §_-2j§.§_-H0§ - 1;
            while(_loc8_ >= 0)
            {
               if((_loc9_ = this.board.§_-9K§(_loc8_,_loc5_)) != null)
               {
                  if(_loc9_.§_-Lc§ || _loc9_.§_-hk§)
                  {
                     _loc6_ = _loc9_.§_-dg§;
                  }
                  else
                  {
                     _loc9_.§_-RO§ = true;
                     _loc9_.y += _loc9_.§_-nB§;
                     if(_loc9_.y >= _loc9_.§_-dg§)
                     {
                        _loc9_.y = _loc9_.§_-dg§;
                        if(_loc9_.§_-nB§ >= §_-SV§)
                        {
                           _loc3_++;
                        }
                        _loc9_.§_-nB§ = 0;
                        _loc9_.§_-RO§ = false;
                     }
                     else if(_loc9_.y >= _loc6_ - 1)
                     {
                        _loc9_.y = _loc6_ - 1;
                        _loc9_.§_-nB§ = _loc7_;
                     }
                     else
                     {
                        _loc9_.§_-nB§ += _loc2_;
                        _loc4_ = true;
                     }
                     _loc6_ = _loc9_.y;
                     _loc7_ = _loc9_.§_-nB§;
                  }
               }
               _loc8_--;
            }
            _loc5_++;
         }
         if(_loc3_ > 0 && Math.abs(this.§_-FH§ - this.frameID) > 8)
         {
            this.§_-FH§ = this.frameID;
            this.gemsHit = true;
         }
         if(!_loc4_)
         {
            this.§_-cl§ = true;
         }
      }
      
      private function §_-4v§() : void
      {
         var _loc4_:SwapData = null;
         var _loc1_:Boolean = true;
         var _loc2_:int = this.swaps.length;
         this.§_-ZE§.length = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.swaps[_loc3_]).update();
            _loc1_ = _loc1_ && _loc4_.§_-nM§();
            this.badMove = this.badMove || _loc4_.§_-ix§;
            if(_loc4_.§_-nM§())
            {
               this.§_-ZE§.push(_loc4_);
            }
            _loc3_++;
         }
         if(_loc1_)
         {
            this.swaps.length = 0;
         }
      }
      
      private function §_-DM§(param1:MoveData) : void
      {
         if(!this.§_-A3§(param1.§_-5Y§,param1.§_-fC§.y,param1.§_-fC§.x))
         {
            return;
         }
         var _loc2_:Gem = param1.§_-5Y§;
         var _loc3_:Gem = param1.§_-5p§;
         _loc2_.§_-An§ = false;
         if(_loc3_.§_-Lc§ || _loc2_.§_-Lc§)
         {
            return;
         }
         var _loc4_:int = Gem.§_-aK§;
         var _loc5_:Gem = null;
         if(_loc2_.type == Gem.§_-l0§ && _loc3_.type == Gem.§_-l0§)
         {
            _loc5_ = _loc2_;
            _loc2_.color = Gem.§_-aK§;
            _loc4_ = Gem.§_-aK§;
         }
         else if(_loc2_.type == Gem.§_-l0§ && _loc3_.type != Gem.§_-nT§ && _loc3_.type != Gem.§_-72§)
         {
            _loc5_ = _loc2_;
            _loc4_ = _loc3_.color;
         }
         else if(_loc3_.type == Gem.§_-l0§ && _loc2_.type != Gem.§_-nT§ && _loc2_.type != Gem.§_-72§)
         {
            _loc5_ = _loc3_;
            _loc4_ = _loc2_.color;
         }
         this.§_-mx§(param1);
         _loc2_.§_-aC§ = param1.id;
         _loc3_.§_-aC§ = param1.id;
         if(_loc5_ != null)
         {
            param1.§_-bd§ = true;
            _loc5_.§_-7f§ = _loc4_;
            _loc5_.§_-iH§ = true;
            return;
         }
         _loc2_.§_-Lc§ = true;
         _loc3_.§_-Lc§ = true;
         this.startedMove = true;
         var _loc6_:SwapData;
         (_loc6_ = new SwapData()).§_-iX§ = param1;
         _loc6_.board = this.board;
         _loc6_.§_-4f§();
         _loc6_.§_-Bh§ = this.§_-Yj§;
         this.swaps.push(_loc6_);
      }
      
      public function §_-i5§(param1:int, param2:int) : void
      {
         var _loc3_:Gem = this.board.§_-9K§(param1,param2);
         this.starGemLogic.§_-gg§(_loc3_,null,null,true);
      }
      
      private function §_-O4§() : void
      {
         var _loc4_:Gem = null;
         var _loc1_:Vector.<Gem> = this.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = _loc1_[_loc3_]) != null)
            {
               if(_loc4_.§_-nB§ < 0)
               {
                  _loc4_.§_-nB§ = 0;
               }
            }
            _loc3_++;
         }
      }
      
      private function §_-3F§() : void
      {
         var _loc2_:BlitzEvent = null;
         var _loc1_:Boolean = true;
         for each(_loc2_ in this.§_-1e§)
         {
            _loc2_.Update(this.§_-Yj§);
            _loc1_ = _loc1_ && _loc2_.IsDone();
         }
         if(_loc1_)
         {
            this.§_-1e§.length = 0;
         }
      }
      
      private function §_-X8§(param1:MoveData) : void
      {
         var _loc2_:Gem = param1.§_-5Y§;
         _loc2_.§_-aC§ = param1.id;
         _loc2_.§_-NZ§ = true;
      }
      
      public function §_-8U§(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Gem = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc4_:int = 0;
         while(_loc4_ < §_-2j§.§_-IP§)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 7;
            for(; _loc7_ >= -1; _loc7_--)
            {
               _loc8_ = this.board.§_-9K§(_loc7_,_loc4_);
               _loc9_ = 0;
               _loc10_ = 0;
               _loc11_ = false;
               if(_loc8_ != null && _loc8_.y < param2)
               {
                  _loc9_ = _loc8_.x - param1;
                  _loc10_ = _loc8_.y - param2;
                  _loc11_ = true;
               }
               else
               {
                  if(_loc7_ != -1)
                  {
                     continue;
                  }
                  _loc9_ = _loc4_ - param1;
                  _loc10_ = _loc7_ - param2;
               }
               _loc12_ = Math.atan2(_loc10_,_loc9_);
               _loc13_ = Math.sqrt(_loc9_ * _loc9_ + _loc10_ * _loc10_);
               _loc14_ = 1;
               _loc15_ = 1;
               _loc16_ = -5 / 128;
               _loc6_ = (_loc17_ = param3 / (Math.max(0,_loc13_ - _loc14_) + _loc15_) * Math.abs(Math.sin(_loc12_))) * _loc16_;
               if(_loc11_)
               {
                  if(_loc5_ == 0)
                  {
                     _loc5_ = _loc6_;
                  }
                  _loc8_.§_-nB§ = Math.min(_loc8_.§_-nB§,_loc5_);
               }
            }
            _loc4_++;
         }
      }
      
      public function Pause() : void
      {
         this.blazingSpeedBonus.Pause();
      }
      
      public function get §_-FY§() : Boolean
      {
         return !this.§_-mA§ && this.§_-as§ > 0;
      }
      
      public function §_-62§(param1:Gem) : void
      {
         var _loc2_:int = param1.§_-dg§;
         var _loc3_:int = param1.§_-pX§;
         var _loc4_:int = _loc2_ - 7;
         var _loc5_:int = _loc2_ + 7;
         var _loc6_:int = _loc2_ - 7;
         var _loc7_:int = _loc2_ + 7;
         var _loc9_:int = §_-2j§.§_-IP§ - 1;
         var _loc11_:int = §_-2j§.§_-H0§ - 1;
         _loc4_ = _loc4_ > 0 ? int(_loc4_) : int(0);
         _loc5_ = _loc5_ < _loc9_ ? int(_loc5_) : int(_loc9_);
         _loc6_ = _loc6_ > 0 ? int(_loc6_) : int(0);
         _loc7_ = _loc7_ < _loc11_ ? int(_loc7_) : int(_loc11_);
         var _loc12_:Gem = null;
         var _loc13_:int = _loc6_;
         while(_loc13_ <= _loc7_)
         {
            (_loc12_ = this.board.§_-9K§(_loc13_,_loc3_)).§_-Mj§(param1);
            _loc13_++;
         }
         var _loc14_:int = _loc4_;
         while(_loc14_ <= _loc5_)
         {
            (_loc12_ = this.board.§_-9K§(_loc2_,_loc14_)).§_-Mj§(param1);
            _loc14_++;
         }
      }
      
      public function QueueChangeGemType(param1:Gem, param2:int) : void
      {
         this.§_-IN§(§_-k2§,param1.id,param2);
      }
      
      private function §_-aJ§(param1:MoveData) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Gem = null;
         var _loc2_:int = 1;
         var _loc3_:int = 0;
         if(this.§_-cl§)
         {
            _loc3_ = this.coinTokenLogic.§_-5u§();
            _loc4_ = 0;
            while(_loc4_ < §_-2j§.§_-H0§)
            {
               _loc5_ = 0;
               while(_loc5_ < §_-2j§.§_-IP§)
               {
                  if(!((_loc6_ = this.board.§_-9K§(_loc4_,_loc5_)).type == Gem.§_-nT§ || _loc6_.type == Gem.§_-72§))
                  {
                     if(_loc6_.type != Gem.§_-Jz§ && _loc6_.§_-NM§ == 0)
                     {
                        _loc6_.§_-68§ = _loc2_;
                        _loc6_.§_-aC§ = param1.id;
                        _loc6_.§_-7f§ = _loc6_.color;
                        _loc6_.§_-Lo§ = _loc6_.type;
                        _loc2_ += 25;
                        _loc3_++;
                     }
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
         }
         if(_loc3_ > 0)
         {
            param1.§_-5Y§.§_-NZ§ = true;
            this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_DETONATE_USE);
         }
         else
         {
            this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_DETONATE_FAIL);
         }
      }
      
      private function §_-s§() : void
      {
         this.§_-GP§.§_-9H§(this.random.§_-QI§());
         this.§_-iS§.§_-9H§(this.random.§_-QI§());
         this.§_-5K§.§_-9H§(this.random.§_-QI§());
         this.§_-X-§.§_-9H§(this.random.§_-QI§());
         this.§default§.§_-9H§(this.random.§_-QI§());
      }
      
      private function §_-mx§(param1:MoveData) : void
      {
         var _loc2_:int = this.moves.length;
         param1.id = _loc2_;
         this.moves[_loc2_] = param1;
      }
      
      public function get §_-Kb§() : Boolean
      {
         return this.§_-6f§;
      }
      
      public function GetGameDuration() : int
      {
         return this.§_-US§;
      }
   }
}
