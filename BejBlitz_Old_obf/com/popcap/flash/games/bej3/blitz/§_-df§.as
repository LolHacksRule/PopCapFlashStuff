package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.framework.resources.sounds.SoundInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.SwapData;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.utils.Dictionary;
   
   public class §_-df§
   {
      
      public static const §_-I§:Number = 0.007;
      
      public static const §_-Fi§:Number = 0.1;
      
      private static const § null§:Match = null;
      
      public static const §_-0e§:int = 180;
      
      public static const §_-GK§:Number = 0.075;
      
      public static const §_-HG§:Number = 0.65;
      
      public static const §_-fJ§:int = 50;
      
      public static const §_-dV§:int = 100;
      
      public static const §_-hs§:int = 800;
      
      public static const §_-9d§:int = 9;
       
      
      private var §_-JH§:Number = 1.0;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-ob§:Dictionary;
      
      private var §_-EE§:Number = 0;
      
      private var §_-pE§:int = 0;
      
      private var §_-HZ§:Vector.<IBlazingSpeedLogicHandler>;
      
      private var §_-JQ§:SoundInst;
      
      private var §_-cY§:Boolean = false;
      
      private var §_-jX§:int = 0;
      
      public function §_-df§(param1:§_-0Z§)
      {
         super();
         this.§_-Lp§ = param1;
         this.§_-HZ§ = new Vector.<IBlazingSpeedLogicHandler>();
         this.§_-JQ§ = this.§_-Lp§.§_-Qi§.§_-pT§(Blitz3Sounds.SOUND_BLAZING_LOOP);
         this.§_-JQ§.§_-Zo§(0);
         this.Reset();
      }
      
      public function §_-lT§() : void
      {
         var _loc4_:SwapData = null;
         var _loc5_:MoveData = null;
         if(!this.§_-cY§)
         {
            return;
         }
         var _loc1_:Vector.<SwapData> = this.§_-Lp§.logic.§_-ZE§;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = (_loc4_ = _loc1_[_loc3_]).§_-iX§;
            if(this.§_-ob§[_loc5_.id] == undefined)
            {
               this.§try§(_loc5_.§_-5Y§);
               this.§try§(_loc5_.§_-5p§);
               this.§_-ob§[_loc5_.id] = _loc5_.id;
            }
            _loc3_++;
         }
      }
      
      public function §_-8v§() : int
      {
         return this.§_-pE§;
      }
      
      public function StartBonus() : void
      {
         if(this.§_-Lp§.logic.GetTimeRemaining() <= 0)
         {
            return;
         }
         if(this.§_-cY§)
         {
            return;
         }
         this.§_-Lp§.§_-Qi§.playSound(Blitz3Sounds.SOUND_BLAZING_BONUS);
         this.§_-EE§ = 1;
         this.§_-cY§ = true;
         this.§_-pE§ = §_-hs§;
         this.§_-JH§ = BlitzLogic.§_-20§ + §_-HG§;
         this.§_-Lp§.logic.§_-kJ§(this.§_-JH§);
         this.§_-AO§();
      }
      
      public function Resume() : void
      {
         this.§_-JQ§.resume();
      }
      
      public function GetNumExplosions() : int
      {
         return this.§_-jX§;
      }
      
      public function AddHandler(param1:IBlazingSpeedLogicHandler) : void
      {
         this.§_-HZ§.push(param1);
      }
      
      private function §try§(param1:Gem) : void
      {
         if(param1 == null || !param1.§_-Oq§)
         {
            return;
         }
         this.§_-Lp§.logic.flameGemLogic.§_-Qv§[param1.id] = true;
         param1.§_-90§ = true;
         ++this.§_-jX§;
      }
      
      public function Pause() : void
      {
         this.§_-JQ§.pause();
      }
      
      public function Reset() : void
      {
         this.§_-EE§ = 0;
         this.§_-JH§ = 1;
         this.§_-cY§ = false;
         this.§_-pE§ = 0;
         this.§_-JQ§.§_-Zo§(this.§_-EE§);
         this.§_-jX§ = 0;
         this.§_-ob§ = new Dictionary();
      }
      
      public function §_-7Y§() : Number
      {
         return this.§_-JH§;
      }
      
      protected function §_-Di§() : void
      {
         var _loc1_:IBlazingSpeedLogicHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-f2§()();
         }
      }
      
      public function Update(param1:Vector.<Match>, param2:BlitzLogic) : void
      {
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(param2.isGameOver || param2.§_-Kb§)
         {
            this.§_-pE§ = 0;
            this.§_-EE§ = 0;
         }
         if(param2.§_-Kb§)
         {
            return;
         }
         if(this.§_-cY§ && param2.mBlockingEvents.length == 0)
         {
            this.§_-EE§ = 1;
            if(this.§_-pE§ == 0)
            {
               this.§_-cY§ = false;
               this.§_-EE§ = 0;
               return;
            }
            --this.§_-pE§;
            return;
         }
         var _loc3_:Number = 0;
         var _loc4_:§_-Ov§;
         var _loc5_:int = (_loc4_ = this.§_-Lp§.logic.speedBonus).§_-PG§();
         if(_loc4_.§_-iU§() > §_-9d§)
         {
            _loc5_ = _loc5_ > §_-fJ§ ? int(_loc5_) : int(§_-fJ§);
            _loc7_ = §_-0e§ - §_-dV§;
            _loc3_ = 1 - (_loc5_ - §_-dV§) / _loc7_;
            _loc3_ = Math.min(1.5,_loc3_);
         }
         else
         {
            this.§_-EE§ = 0;
         }
         if(_loc4_.§_-Hh§() && _loc3_ >= this.§_-EE§)
         {
            _loc9_ = (_loc8_ = Number((_loc3_ - this.§_-EE§) * §_-GK§)) < §_-Fi§ ? Number(_loc8_) : Number(§_-Fi§);
            this.§_-EE§ = Math.min(1,this.§_-EE§ + _loc9_);
         }
         if(param2.mBlockingEvents.length == 0)
         {
            _loc10_ = §_-0e§ + this.§_-EE§ * (§_-dV§ - §_-0e§);
            if(_loc5_ >= _loc10_)
            {
               this.§_-EE§ *= 1 - §_-I§;
            }
         }
         if(this.§_-EE§ >= 1)
         {
            this.StartBonus();
         }
         var _loc6_:Number = ((_loc6_ = Math.max(0.6,this.§_-EE§)) - 0.6) / (1 - 0.6);
         this.§_-JQ§.§_-Zo§(_loc6_);
         this.§_-JH§ = BlitzLogic.§_-20§ + §_-HG§ * this.§_-EE§;
         this.§_-Lp§.logic.§_-kJ§(this.§_-JH§);
      }
      
      public function §_-iZ§() : Number
      {
         return this.§_-EE§;
      }
      
      protected function §_-AO§() : void
      {
         var _loc1_:IBlazingSpeedLogicHandler = null;
         for each(_loc1_ in this.§_-HZ§)
         {
            _loc1_.§_-P4§();
         }
      }
      
      public function Quit() : void
      {
         this.§_-JQ§.pause();
      }
   }
}
