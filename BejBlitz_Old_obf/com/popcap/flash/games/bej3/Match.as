package com.popcap.flash.games.bej3
{
   public class Match
   {
       
      
      public var §_-LO§:int = 0;
      
      public var §_-O0§:Number = 0;
      
      public var §_-3q§:Number = 0;
      
      public var mGems:Vector.<Gem>;
      
      public var §_-X5§:int = 0;
      
      public var §_-Lh§:int = -1;
      
      public var §_-6H§:Vector.<Match>;
      
      public var §_-8A§:Boolean = false;
      
      public var §_-Vd§:int = -1;
      
      public var §_-i-§:MatchSet = null;
      
      public var §_-LC§:int = -1;
      
      public var §_-I3§:int = -1;
      
      public function Match()
      {
         this.§_-6H§ = new Vector.<Match>();
         super();
      }
      
      public function §_-4f§(param1:Vector.<Gem>) : void
      {
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.mGems = param1;
         this.§_-Lh§ = §_-2j§.§_-IP§;
         this.§_-Vd§ = -1;
         this.§_-LC§ = §_-2j§.§_-H0§;
         this.§_-I3§ = -1;
         var _loc2_:int = this.mGems.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = (_loc4_ = this.mGems[_loc3_]).§_-dg§;
            _loc6_ = _loc4_.§_-pX§;
            this.§_-Lh§ = _loc6_ < this.§_-Lh§ ? int(_loc6_) : int(this.§_-Lh§);
            this.§_-Vd§ = _loc6_ > this.§_-Vd§ ? int(_loc6_) : int(this.§_-Vd§);
            this.§_-LC§ = _loc5_ < this.§_-LC§ ? int(_loc5_) : int(this.§_-LC§);
            this.§_-I3§ = _loc5_ > this.§_-I3§ ? int(_loc5_) : int(this.§_-I3§);
            _loc4_.§_-Oq§ = true;
            this.§_-LO§ = _loc4_.§_-aC§ > this.§_-LO§ ? int(_loc4_.§_-aC§) : int(this.§_-LO§);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = this.mGems[_loc3_]).§_-aC§ = this.§_-LO§;
            _loc3_++;
         }
         this.§_-6H§.length = 0;
         this.§_-O0§ = this.§_-Lh§ + (this.§_-Vd§ - this.§_-Lh§) / 2;
         this.§_-3q§ = this.§_-LC§ + (this.§_-I3§ - this.§_-LC§) / 2;
      }
      
      public function §_-LN§(param1:Match) : Boolean
      {
         if(this.§_-Lh§ > param1.§_-Vd§)
         {
            return false;
         }
         if(this.§_-Vd§ < param1.§_-Lh§)
         {
            return false;
         }
         if(this.§_-LC§ > param1.§_-I3§)
         {
            return false;
         }
         if(this.§_-I3§ < param1.§_-LC§)
         {
            return false;
         }
         return true;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "( ";
         var _loc2_:int = 0;
         while(_loc2_ < this.mGems.length)
         {
            _loc1_ += this.mGems[_loc2_] + " ";
            _loc2_++;
         }
         return _loc1_ + ")";
      }
   }
}
