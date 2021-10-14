package com.popcap.flash.games.bej3
{
   public class §_-aY§
   {
       
      
      private var §_-K9§:int = 0;
      
      private var §_-EM§:int = 0;
      
      private var §_-cH§:Vector.<Vector.<Gem>>;
      
      private var §_-1G§:int = 0;
      
      public function §_-aY§(param1:int, param2:int)
      {
         super();
         this.§_-EM§ = param1;
         this.§_-K9§ = param2;
         this.§_-1G§ = param1 * param2;
         this.§_-cH§ = new Vector.<Vector.<Gem>>(param1,true);
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            this.§_-cH§[_loc3_] = new Vector.<Gem>(param2,true);
            _loc3_++;
         }
         this.Reset();
      }
      
      public function §_-dx§() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.§_-EM§)
         {
            _loc2_ = 0;
            while(_loc2_ < this.§_-K9§)
            {
               this.§_-cH§[_loc1_][_loc2_] = null;
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      public function §_-Mv§(param1:int, param2:int, param3:int) : Vector.<Gem>
      {
         var _loc14_:int = 0;
         var _loc4_:Vector.<Gem> = new Vector.<Gem>();
         var _loc5_:int = param2 - param3;
         var _loc6_:int = param2 + param3;
         var _loc7_:int = param1 - param3;
         var _loc8_:int = param1 + param3;
         var _loc10_:int = this.§_-K9§ - 1;
         var _loc12_:int = this.§_-EM§ - 1;
         _loc5_ = _loc5_ > 0 ? int(_loc5_) : int(0);
         _loc6_ = _loc6_ < _loc10_ ? int(_loc6_) : int(_loc10_);
         _loc7_ = _loc7_ > 0 ? int(_loc7_) : int(0);
         _loc8_ = _loc8_ < _loc12_ ? int(_loc8_) : int(_loc12_);
         var _loc13_:int = _loc7_;
         while(_loc13_ <= _loc8_)
         {
            _loc14_ = _loc5_;
            while(_loc14_ <= _loc6_)
            {
               _loc4_.push(this.getGem(_loc13_,_loc14_));
               _loc14_++;
            }
            _loc13_++;
         }
         return _loc4_;
      }
      
      public function §_-iK§() : int
      {
         return this.§_-K9§;
      }
      
      public function §_-n1§(param1:int, param2:int, param3:int, param4:Boolean = false) : Vector.<Gem>
      {
         var _loc5_:Vector.<Gem> = new Vector.<Gem>();
         var _loc6_:int = param2 - param3;
         var _loc7_:int = param2 + param3;
         var _loc8_:int = param1 - param3;
         var _loc9_:int = param1 + param3;
         var _loc11_:int = this.§_-K9§ - 1;
         var _loc13_:int = this.§_-EM§ - 1;
         _loc6_ = _loc6_ > 0 ? int(_loc6_) : int(0);
         _loc7_ = _loc7_ < _loc11_ ? int(_loc7_) : int(_loc11_);
         _loc8_ = _loc8_ > 0 ? int(_loc8_) : int(0);
         _loc9_ = _loc9_ < _loc13_ ? int(_loc9_) : int(_loc13_);
         if(param4)
         {
            _loc5_.push(this.getGem(param1,param2));
         }
         var _loc15_:int = _loc8_;
         while(_loc15_ <= _loc9_)
         {
            if(_loc15_ != param1)
            {
               _loc5_.push(this.getGem(_loc15_,param2));
            }
            _loc15_++;
         }
         var _loc16_:int = _loc6_;
         while(_loc16_ <= _loc7_)
         {
            if(_loc16_ != param2)
            {
               _loc5_.push(this.getGem(param1,_loc16_));
            }
            _loc16_++;
         }
         return _loc5_;
      }
      
      public function override() : int
      {
         return this.§_-EM§;
      }
      
      public function §_-8T§() : int
      {
         return this.§_-1G§;
      }
      
      public function Reset() : void
      {
         var _loc2_:Vector.<Gem> = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.§_-cH§.length)
         {
            _loc2_ = this.§_-cH§[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc2_[_loc3_] = null;
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function getGem(param1:int, param2:int) : Gem
      {
         if(param1 < 0 || param2 < 0 || param1 >= this.§_-EM§ || param2 >= this.§_-K9§)
         {
            return null;
         }
         return this.§_-cH§[param1][param2];
      }
      
      public function toString() : String
      {
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc1_:* = "";
         var _loc2_:int = 0;
         while(_loc2_ < this.§_-EM§)
         {
            _loc3_ = 0;
            while(_loc3_ < this.§_-K9§)
            {
               if((_loc4_ = this.getGem(_loc2_,_loc3_)) == null)
               {
                  _loc1_ += "  ";
               }
               else
               {
                  _loc1_ += _loc4_.§_-HQ§() + " ";
               }
               _loc3_++;
            }
            _loc1_ += "\n";
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function §_-QW§(param1:int, param2:int, param3:Gem) : void
      {
         if(param1 < 0 || param2 < 0 || param1 >= this.§_-EM§ || param2 >= this.§_-K9§)
         {
            return;
         }
         this.§_-cH§[param1][param2] = param3;
      }
   }
}
