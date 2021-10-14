package com.popcap.flash.framework.math
{
   public class §_-cV§
   {
      
      public static const §_-85§:int = 4;
       
      
      public var §_-fq§:Vector.<HermitePoint>;
      
      private var §_-kB§:Boolean = false;
      
      private var q:Vector.<Vector.<Number>>;
      
      private var §_-cm§:Vector.<HermitePiece>;
      
      private var §_-nl§:Vector.<Number>;
      
      private var z:Vector.<Number>;
      
      public function §_-cV§()
      {
         this.§_-fq§ = new Vector.<HermitePoint>();
         this.§_-cm§ = new Vector.<HermitePiece>();
         this.§_-nl§ = new Vector.<Number>(2,true);
         super();
         this.q = new Vector.<Vector.<Number>>(§_-85§,true);
         var _loc1_:int = 0;
         while(_loc1_ < §_-85§)
         {
            this.q[_loc1_] = new Vector.<Number>(§_-85§,true);
            _loc1_++;
         }
         this.z = new Vector.<Number>(§_-85§,true);
      }
      
      private function §_-a7§(param1:int) : HermitePiece
      {
         var _loc4_:HermitePoint = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ <= 1)
         {
            _loc4_ = this.§_-fq§[param1 + _loc2_];
            _loc5_ = 2 * _loc2_;
            this.z[_loc5_] = _loc4_.x;
            this.z[_loc5_ + 1] = _loc4_.x;
            this.q[_loc5_][0] = _loc4_.fx;
            this.q[_loc5_ + 1][0] = _loc4_.fx;
            this.q[_loc5_ + 1][1] = _loc4_.§_-5f§;
            if(_loc2_ > 0)
            {
               this.q[_loc5_][1] = (this.q[_loc5_][0] - this.q[_loc5_ - 1][0]) / (this.z[_loc5_] - this.z[_loc5_ - 1]);
            }
            _loc2_++;
         }
         _loc2_ = 2;
         while(_loc2_ < §_-85§)
         {
            _loc6_ = 2;
            while(_loc6_ <= _loc2_)
            {
               this.q[_loc2_][_loc6_] = (this.q[_loc2_][_loc6_ - 1] - this.q[_loc2_ - 1][_loc6_ - 1]) / (this.z[_loc2_] - this.z[_loc2_ - _loc6_]);
               _loc6_++;
            }
            _loc2_++;
         }
         var _loc3_:HermitePiece = new HermitePiece();
         _loc2_ = 0;
         while(_loc2_ < §_-85§)
         {
            _loc3_.§_-ky§[_loc2_] = this.q[_loc2_][_loc2_];
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function §var §(param1:Number) : Number
      {
         var _loc4_:HermitePoint = null;
         var _loc5_:HermitePoint = null;
         var _loc6_:HermitePiece = null;
         if(!this.§_-kB§)
         {
            if(!this.§_-RB§())
            {
               return 0;
            }
            this.§_-kB§ = true;
         }
         var _loc2_:int = this.§_-cm§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 < this.§_-fq§[_loc3_ + 1].x)
            {
               _loc4_ = this.§_-fq§[_loc3_];
               _loc5_ = this.§_-fq§[_loc3_ + 1];
               _loc6_ = this.§_-cm§[_loc3_];
               return this.§_-U4§(param1,_loc4_.x,_loc5_.x,_loc6_);
            }
            _loc3_++;
         }
         return this.§_-fq§[this.§_-fq§.length - 1].fx;
      }
      
      public function §_-kM§() : void
      {
         this.§_-kB§ = false;
      }
      
      private function §_-U4§(param1:Number, param2:Number, param3:Number, param4:HermitePiece) : Number
      {
         this.§_-nl§[0] = param1 - param2;
         this.§_-nl§[1] = param1 - param3;
         var _loc5_:Number = 1;
         var _loc6_:Number = param4.§_-ky§[0];
         var _loc7_:int = 1;
         while(_loc7_ < §_-85§)
         {
            _loc5_ *= this.§_-nl§[int((_loc7_ - 1) / 2)];
            _loc6_ += _loc5_ * param4.§_-ky§[_loc7_];
            _loc7_++;
         }
         return _loc6_;
      }
      
      private function §_-RB§() : Boolean
      {
         this.§_-cm§.length = 0;
         var _loc1_:int = this.§_-fq§.length;
         if(_loc1_ < 2)
         {
            return false;
         }
         var _loc2_:int = _loc1_ - 1;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.§_-cm§[_loc3_] = this.§_-a7§(_loc3_);
            _loc3_++;
         }
         return true;
      }
   }
}
