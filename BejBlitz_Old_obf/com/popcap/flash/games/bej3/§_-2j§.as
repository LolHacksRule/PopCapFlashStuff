package com.popcap.flash.games.bej3
{
   import com.popcap.flash.framework.math.§_-fO§;
   import flash.utils.Dictionary;
   
   public class §_-2j§
   {
      
      public static const §_-IP§:int = 8;
      
      public static const LEFT:int = 0;
      
      public static const §_-L6§:int = §_-IP§;
      
      public static const §_-ou§:int = 0;
      
      public static const §_-H0§:int = 8;
      
      public static const §_-XG§:int = §_-H0§;
      
      public static const §_-gL§:int = §_-L6§ * §_-XG§;
      
      public static const §_-dp§:int = §_-H0§ - 1;
      
      public static const RIGHT:int = §_-IP§ - 1;
       
      
      public var §_-F8§:int = 0;
      
      private var §_-nU§:§_-oi§;
      
      private var §_-ie§:Vector.<Match>;
      
      private var §_-SX§:§_-fO§ = null;
      
      private var §_-H-§:Vector.<Match>;
      
      private var §_-at§:Vector.<Gem>;
      
      private var §_-SO§:int = 0;
      
      public var §_-BY§:§_-AX§;
      
      public var mGems:Vector.<Gem>;
      
      public var §_-Md§:Vector.<Gem>;
      
      private var §_-84§:Dictionary;
      
      private var §_-Vs§:Vector.<MoveData>;
      
      private var §_-od§:§_-6m§ = null;
      
      private var §_-Or§:int = 0;
      
      public function §_-2j§(param1:§_-fO§)
      {
         this.§_-Md§ = new Vector.<Gem>();
         this.§_-nU§ = new §_-oi§();
         this.§_-ie§ = new Vector.<Match>();
         this.§_-Vs§ = new Vector.<MoveData>();
         this.§_-H-§ = new Vector.<Match>();
         this.§_-at§ = new Vector.<Gem>();
         super();
         this.§_-SX§ = param1;
         this.§_-od§ = new §_-6m§();
         this.mGems = new Vector.<Gem>(§_-gL§,true);
         this.§_-BY§ = new §_-AX§();
         this.Reset();
      }
      
      public function §_-Jq§() : int
      {
         return ++this.§_-Or§;
      }
      
      public function §_-Ng§(param1:int, param2:Boolean = true) : int
      {
         var _loc6_:Gem = null;
         var _loc3_:int = 0;
         var _loc4_:int = this.mGems.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc6_ = this.mGems[_loc5_]) != null)
            {
               if(!(_loc6_.§_-Td§ == 0 && !param2))
               {
                  if(_loc6_.color == param1)
                  {
                     _loc3_++;
                  }
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function §_-eg§() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < §_-IP§)
         {
            _loc2_ = false;
            _loc3_ = §_-H0§;
            _loc4_ = §_-H0§ - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = _loc4_ * §_-IP§ + _loc1_;
               if((_loc6_ = this.mGems[_loc5_]) != null && _loc6_.§_-NZ§)
               {
                  ++this.§_-SO§;
               }
               if(_loc6_ == null || _loc6_.§_-NZ§)
               {
                  this.mGems[_loc5_] = null;
               }
               else
               {
                  _loc3_--;
                  if(_loc6_.§_-dg§ != _loc3_)
                  {
                     if(_loc6_.§_-Lc§)
                     {
                        _loc3_ = _loc6_.§_-dg§;
                     }
                     else
                     {
                        this.mGems[_loc5_] = null;
                        _loc6_.§_-dg§ = _loc3_;
                        _loc6_.§_-Ux§ = this.§_-Jq§();
                        _loc7_ = _loc3_ * §_-IP§ + _loc1_;
                        this.mGems[_loc7_] = _loc6_;
                     }
                  }
               }
               _loc4_--;
            }
            _loc1_++;
         }
      }
      
      public function §_-oP§() : Boolean
      {
         var _loc2_:Gem = null;
         var _loc1_:int = 0;
         while(_loc1_ < §_-gL§)
         {
            _loc2_ = this.mGems[_loc1_];
            if(_loc2_ == null || !_loc2_.§_-V9§())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function §_-ff§() : Vector.<Gem>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Gem = null;
         this.§_-Md§.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < §_-IP§)
         {
            _loc2_ = -2;
            _loc3_ = §_-dp§;
            _loc4_ = 0;
            while(_loc4_ <= §_-dp§)
            {
               _loc5_ = _loc4_ * §_-IP§ + _loc1_;
               if((_loc6_ = this.mGems[_loc5_]) != null)
               {
                  _loc3_ = _loc6_.§_-dg§ - 1;
                  break;
               }
               _loc4_++;
            }
            _loc4_ = _loc3_;
            while(_loc4_ >= 0)
            {
               _loc5_ = _loc4_ * §_-IP§ + _loc1_;
               _loc6_ = this.mGems[_loc5_];
               (_loc6_ = this.§_-od§.§_-gH§()).id = this.§_-F8§++;
               _loc6_.Reset();
               _loc6_.§_-dg§ = _loc4_;
               _loc6_.§_-pX§ = _loc1_;
               _loc6_.x = _loc1_;
               _loc6_.y = _loc2_;
               _loc6_.§_-Ux§ = this.§_-Jq§();
               _loc6_.§_-nB§ = 0;
               this.§_-84§[_loc6_.id] = _loc6_;
               _loc2_ -= 2;
               this.mGems[_loc5_] = _loc6_;
               this.§_-Md§.push(_loc6_);
               _loc4_--;
            }
            _loc1_++;
         }
         return this.§_-Md§;
      }
      
      private function §_-ij§() : int
      {
         var _loc1_:int = this.§_-SX§.§_-Nn§(Gem.§_-7B§.length);
         return Gem.§_-7B§[_loc1_];
      }
      
      public function §_-9K§(param1:int, param2:int) : Gem
      {
         if(param1 < 0 || param2 < 0 || param1 >= §_-H0§ || param2 >= §_-IP§)
         {
            return null;
         }
         var _loc3_:int = param1 * §_-IP§ + param2;
         return this.mGems[_loc3_];
      }
      
      public function §_-Jm§() : Boolean
      {
         var _loc2_:Gem = null;
         var _loc1_:int = 0;
         while(_loc1_ < §_-gL§)
         {
            _loc2_ = this.mGems[_loc1_];
            if(_loc2_ == null || !_loc2_.§_-av§())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function §_-d4§(param1:Number, param2:Number, param3:Number, param4:Vector.<Gem> = null) : Vector.<Gem>
      {
         var _loc15_:Gem = null;
         var _loc5_:Number = param1 - param3;
         var _loc6_:Number = param1 + param3;
         var _loc7_:Number = param2 - param3;
         var _loc8_:Number = param2 + param3;
         var _loc10_:Number = §_-IP§ - 1;
         var _loc12_:Number = §_-H0§ - 1;
         _loc5_ = _loc5_ > 0 ? Number(_loc5_) : Number(0);
         _loc6_ = _loc6_ < _loc10_ ? Number(_loc6_) : Number(_loc10_);
         _loc7_ = _loc7_ > -2 ? Number(_loc7_) : Number(-2);
         _loc8_ = _loc8_ < _loc12_ ? Number(_loc8_) : Number(_loc12_);
         if(param4 == null)
         {
            param4 = new Vector.<Gem>();
         }
         var _loc13_:int = this.mGems.length;
         var _loc14_:int = 0;
         while(_loc14_ < _loc13_)
         {
            if(!((_loc15_ = this.mGems[_loc14_]) == null || _loc15_.x < _loc5_ || _loc15_.x > _loc6_ || _loc15_.y < _loc7_ || _loc15_.y > _loc8_))
            {
               param4.push(_loc15_);
            }
            _loc14_++;
         }
         return param4;
      }
      
      public function §_-NB§(param1:Gem, param2:Gem) : void
      {
         var _loc3_:int = param1.§_-dg§ * §_-IP§ + param1.§_-pX§;
         var _loc4_:int = param2.§_-dg§ * §_-IP§ + param2.§_-pX§;
         this.mGems[_loc3_] = param2;
         this.mGems[_loc4_] = param1;
         var _loc5_:int = param1.§_-dg§;
         var _loc6_:int = param1.§_-pX§;
         param1.§_-dg§ = param2.§_-dg§;
         param1.§_-pX§ = param2.§_-pX§;
         param2.§_-dg§ = _loc5_;
         param2.§_-pX§ = _loc6_;
         param2.§_-Ux§ = this.§_-Jq§();
         param1.§_-Ux§ = this.§_-Jq§();
      }
      
      public function §_-Go§() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < §_-gL§)
         {
            _loc1_[_loc2_] = this.mGems[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function §_-8a§(param1:Vector.<Gem>) : void
      {
         var _loc4_:Gem = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = param1[_loc3_]).color = this.§_-ij§();
            _loc3_++;
         }
      }
      
      public function §_-iz§(param1:Array) : void
      {
         var _loc3_:Gem = null;
         var _loc2_:int = 0;
         while(_loc2_ < §_-gL§)
         {
            _loc3_ = param1[_loc2_];
            _loc3_.§_-dg§ = int(_loc2_ / §_-XG§);
            _loc3_.§_-pX§ = int(_loc2_ % §_-XG§);
            this.mGems[_loc2_] = _loc3_;
            _loc2_++;
         }
      }
      
      public function Reset() : void
      {
         this.§_-od§.Reset();
         this.§_-BY§.Reset();
         this.§_-F8§ = 0;
         this.§_-Or§ = 0;
         this.§_-SO§ = 0;
         this.§_-Md§.length = 0;
         this.§_-ie§.length = 0;
         this.§_-Vs§.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.mGems.length)
         {
            this.mGems[_loc1_] = null;
            _loc1_++;
         }
         this.§_-nU§.Reset();
         this.§_-84§ = new Dictionary();
         this.§_-SX§.Reset();
      }
      
      public function §_-mh§() : Vector.<MatchSet>
      {
         var _loc12_:Match = null;
         var _loc13_:MatchSet = null;
         var _loc14_:Match = null;
         var _loc15_:Vector.<Match> = null;
         var _loc16_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Gem = null;
         var _loc4_:int = 0;
         var _loc5_:Match = null;
         var _loc6_:Vector.<Match>;
         (_loc6_ = this.§_-H-§).length = 0;
         for each(_loc3_ in this.mGems)
         {
            if(_loc3_ != null)
            {
               _loc3_.§_-Oq§ = false;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < §_-IP§)
         {
            this.§_-nU§.start(this.mGems[_loc2_]);
            _loc1_ = §_-IP§;
            while(_loc1_ < §_-gL§)
            {
               _loc4_ = _loc1_ + _loc2_;
               _loc3_ = this.mGems[_loc4_];
               if((_loc5_ = this.§_-nU§.push(_loc3_)) != null)
               {
                  _loc6_.push(_loc5_);
                  for each(_loc3_ in _loc5_.mGems)
                  {
                     _loc3_.§_-Oq§ = true;
                  }
               }
               _loc1_ += §_-IP§;
            }
            if((_loc5_ = this.§_-nU§.end()) != null)
            {
               _loc6_.push(_loc5_);
            }
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ < §_-gL§)
         {
            this.§_-nU§.start(this.mGems[_loc1_]);
            _loc2_ = 1;
            while(_loc2_ < §_-IP§)
            {
               _loc4_ = _loc1_ + _loc2_;
               _loc3_ = this.mGems[_loc4_];
               if((_loc5_ = this.§_-nU§.push(_loc3_)) != null)
               {
                  _loc6_.push(_loc5_);
                  for each(_loc3_ in _loc5_.mGems)
                  {
                     _loc3_.§_-Oq§ = true;
                  }
               }
               _loc2_++;
            }
            if((_loc5_ = this.§_-nU§.end()) != null)
            {
               _loc6_.push(_loc5_);
            }
            _loc1_ += §_-IP§;
         }
         var _loc7_:int = _loc6_.length;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc5_ = _loc6_[_loc8_];
            _loc9_ = _loc8_ + 1;
            while(_loc9_ < _loc7_)
            {
               _loc12_ = _loc6_[_loc9_];
               if(_loc5_.§_-LN§(_loc12_))
               {
                  _loc5_.§_-6H§.push(_loc12_);
                  _loc12_.§_-6H§.push(_loc5_);
               }
               _loc9_++;
            }
            _loc8_++;
         }
         var _loc10_:Vector.<MatchSet> = new Vector.<MatchSet>();
         var _loc11_:Vector.<Match> = new Vector.<Match>();
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            if((_loc5_ = _loc6_[_loc8_]).§_-i-§ == null)
            {
               _loc13_ = new MatchSet();
               _loc11_.length = 0;
               _loc11_.push(_loc5_);
               while(_loc11_.length > 0)
               {
                  if((_loc14_ = _loc11_.shift() as Match).§_-i-§ == null)
                  {
                     _loc13_.§_-ie§.push(_loc14_);
                     _loc14_.§_-i-§ = _loc13_;
                     _loc16_ = (_loc15_ = _loc14_.§_-6H§).length;
                     _loc9_ = 0;
                     while(_loc9_ < _loc16_)
                     {
                        _loc11_.push(_loc15_[_loc9_]);
                        _loc9_++;
                     }
                  }
               }
               _loc13_.dynamic();
               _loc10_.push(_loc13_);
            }
            _loc8_++;
         }
         return _loc10_;
      }
      
      public function §_-D1§() : Gem
      {
         var _loc2_:int = 0;
         var _loc1_:Gem = null;
         while(_loc1_ == null)
         {
            _loc2_ = this.§_-SX§.§_-Nn§(§_-gL§);
            _loc1_ = this.mGems[_loc2_];
         }
         return _loc1_;
      }
      
      public function GetNumGemsCleared() : int
      {
         return this.§_-SO§;
      }
      
      public function §_-gH§(param1:int) : Gem
      {
         return this.§_-84§[param1];
      }
      
      public function §_-hW§(param1:Vector.<Gem>) : void
      {
         var _loc4_:Gem = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = param1[_loc3_]).§_-NZ§ = true;
            _loc3_++;
         }
      }
      
      public function §_-YL§() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc10_:Gem = null;
         var _loc1_:Array = [];
         var _loc2_:Gem = null;
         var _loc3_:int = 0;
         while(_loc3_ < §_-L6§)
         {
            _loc4_ = _loc3_ * §_-XG§;
            _loc1_.length = 0;
            _loc5_ = 0;
            while(_loc5_ < §_-XG§)
            {
               _loc2_ = this.mGems[_loc4_ + _loc5_];
               if(_loc2_ != null)
               {
                  if(!(_loc2_.type == Gem.§_-72§ || _loc2_.type == Gem.§_-nT§))
                  {
                     if(_loc2_.§_-V9§())
                     {
                        _loc1_.push(_loc2_);
                     }
                  }
               }
               _loc5_++;
            }
            if(_loc1_.length >= 2)
            {
               if(_loc1_.length == 2)
               {
                  this.§_-NB§(_loc1_[0],_loc1_[1]);
               }
               _loc6_ = _loc1_.length;
               _loc7_ = 1;
               while(_loc7_ < _loc6_)
               {
                  _loc8_ = this.§_-SX§.§_-Nn§(_loc7_ - 1);
                  _loc9_ = _loc1_[_loc7_];
                  _loc10_ = _loc1_[_loc8_];
                  this.§_-NB§(_loc9_,_loc10_);
                  _loc7_++;
               }
            }
            _loc3_++;
         }
      }
      
      public function §_-Ai§(param1:int) : Vector.<Gem>
      {
         var _loc5_:Gem = null;
         var _loc2_:Vector.<Gem> = new Vector.<Gem>();
         var _loc3_:int = this.mGems.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.mGems[_loc4_]) != null)
            {
               if(param1 == Gem.§_-aK§)
               {
                  _loc2_.push(_loc5_);
               }
               else if(_loc5_.color == param1 && _loc5_.type != Gem.§_-l0§)
               {
                  _loc2_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
