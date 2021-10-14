package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.ScoreValue;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   
   public class §_-Yr§ extends Sprite
   {
       
      
      private var §_-09§:§_-0Z§;
      
      public var §_-mW§:§_-Y8§;
      
      private var §_-GE§:int = 0;
      
      private var §_-Sc§:Array;
      
      private var §_-3f§:Array;
      
      private var § set§:Array;
      
      private var §_-0k§:int = 0;
      
      public var §_-3C§:Array;
      
      private var §_-cO§:Boolean = true;
      
      public function §_-Yr§(param1:§_-0Z§)
      {
         this.§_-3f§ = [[22,22,22,22,22,22,22,22],[22,22,22,22,22,22,22,22,22]];
         this.§_-Sc§ = [[240 - 236,272 - 236,303 - 236,335 - 236,367 - 236,398 - 236,430 - 236,461 - 236],[240 - 236,266 - 236,295 - 236,321 - 236,348 - 236,375 - 236,400 - 236,436 - 236,461 - 236]];
         this.§_-3C§ = [];
         this.§ set§ = [];
         super();
         this.§_-09§ = param1;
         this.§_-mW§ = new §_-Y8§(param1);
         this.§_-mW§.§_-kX§();
      }
      
      private function §_-C3§() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc1_:Number = Number.MIN_VALUE;
         var _loc3_:§_-U0§ = null;
         for each(_loc3_ in this.§ set§)
         {
            _loc7_ = _loc3_.§_-Ik§();
            _loc1_ = Math.max(_loc1_,_loc7_);
         }
         _loc4_ = (_loc4_ = (_loc4_ = int(Math.ceil(_loc1_ / 5000))) % 2 == 1 ? int(_loc4_ + 1) : int(_loc4_)) * 5000;
         for each(_loc3_ in this.§ set§)
         {
            _loc3_.§_-Kv§(_loc4_,0);
         }
         _loc5_ = 2;
         _loc6_ = 0;
         while(_loc6_ <= _loc5_)
         {
            _loc8_ = int(_loc6_ * _loc4_ / _loc5_);
            this.§_-3C§[_loc6_] = _loc8_;
            _loc6_++;
         }
      }
      
      public function AddMultiplier(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Number = this.§_-09§.logic.GetGameDuration() / (this.§ set§.length - 1);
         var _loc5_:int = int(param1 / _loc4_);
         var _loc6_:§_-U0§;
         (_loc6_ = this.§ set§[_loc5_]).AddMultiplier(param2,param3);
         this.§_-C3§();
      }
      
      public function Reset() : void
      {
         var _loc8_:§_-U0§ = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         this.§ set§.length = 0;
         var _loc1_:int = 8;
         var _loc2_:Array = this.§_-3f§[0];
         var _loc3_:Array = this.§_-Sc§[0];
         if(this.§_-09§.logic.GetGameDuration() > BlitzLogic.§_-6g§)
         {
            _loc2_ = this.§_-3f§[1];
            _loc3_ = this.§_-Sc§[1];
            _loc1_++;
         }
         var _loc4_:int;
         var _loc5_:int = (_loc4_ = this.§_-GE§ / _loc1_) / 2;
         var _loc6_:int = _loc4_ - 16;
         var _loc7_:int = 0;
         while(_loc7_ < _loc1_)
         {
            (_loc8_ = new §_-U0§(this.§_-09§,this.§_-mW§,_loc2_[_loc7_],_loc7_ == _loc1_ - 1)).§_-Ou§ = this.§_-0k§;
            _loc8_.§_-I5§ = _loc2_[_loc7_];
            _loc8_.x = -4 + _loc3_[_loc7_] + _loc2_[_loc7_] / 2;
            _loc8_.y = this.§_-0k§;
            this.§ set§[_loc7_] = _loc8_;
            addChild(_loc8_);
            _loc7_++;
         }
      }
      
      public function Init(param1:int, param2:int) : void
      {
         this.§_-GE§ = param1;
         this.§_-0k§ = param2;
         this.Reset();
      }
      
      public function SetScores(param1:Vector.<ScoreValue>, param2:int) : void
      {
         var _loc5_:ScoreValue = null;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:§_-U0§ = null;
         var _loc3_:int = this.§ set§.length - 1;
         var _loc4_:§_-U0§ = this.§ set§[this.§ set§.length - 1];
         for each(_loc5_ in param1)
         {
            _loc6_ = _loc5_.§_-6Q§();
            _loc7_ = _loc5_.§_-3j§("LastHurrah");
            _loc8_ = int(_loc6_ / param2 * _loc3_);
            _loc8_ = Math.min(_loc8_,_loc3_ - 1);
            _loc9_ = this.§ set§[_loc8_];
            if(_loc7_)
            {
               _loc9_ = _loc4_;
            }
            _loc9_.§_-JX§(_loc5_);
         }
         this.§_-C3§();
      }
      
      public function Update() : void
      {
         var _loc3_:§_-U0§ = null;
         if(!this.§_-cO§)
         {
            return;
         }
         var _loc1_:int = this.§ set§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§ set§[_loc2_];
            _loc3_.Update();
            if(_loc2_ < _loc1_ - 1 && _loc3_.§_-VO§() > 0.5)
            {
               this.§ set§[_loc2_ + 1].StartGrowing();
            }
            _loc2_++;
         }
      }
   }
}
