package com.popcap.flash.framework.math
{
   public class Hermite
   {
      
      public static const NUM_DIMS:int = 4;
       
      
      public var points:Vector.<HermitePoint>;
      
      private var q:Vector.<Vector.<Number>>;
      
      private var z:Vector.<Number>;
      
      private var mPieces:Vector.<HermitePiece>;
      
      private var mIsBuilt:Boolean;
      
      private var mXSub:Vector.<Number>;
      
      public function Hermite()
      {
         super();
         this.points = new Vector.<HermitePoint>();
         this.mPieces = new Vector.<HermitePiece>();
         this.mIsBuilt = false;
         this.mXSub = new Vector.<Number>(2);
         this.q = new Vector.<Vector.<Number>>(NUM_DIMS);
         var _loc1_:int = 0;
         while(_loc1_ < NUM_DIMS)
         {
            this.q[_loc1_] = new Vector.<Number>(NUM_DIMS);
            _loc1_++;
         }
         this.z = new Vector.<Number>(NUM_DIMS);
      }
      
      public function rebuild() : void
      {
         this.mIsBuilt = false;
      }
      
      public function evaluate(param1:Number) : Number
      {
         var _loc4_:HermitePoint = null;
         var _loc5_:HermitePoint = null;
         var _loc6_:HermitePiece = null;
         if(!this.mIsBuilt)
         {
            if(!this.build())
            {
               return 0;
            }
            this.mIsBuilt = true;
         }
         var _loc2_:int = this.mPieces.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 < this.points[_loc3_ + 1].x)
            {
               _loc4_ = this.points[_loc3_];
               _loc5_ = this.points[_loc3_ + 1];
               _loc6_ = this.mPieces[_loc3_];
               return this.evaluatePiece(param1,_loc4_.x,_loc5_.x,_loc6_);
            }
            _loc3_++;
         }
         return this.points[this.points.length - 1].fx;
      }
      
      private function build() : Boolean
      {
         this.mPieces.length = 0;
         var _loc1_:int = this.points.length;
         if(_loc1_ < 2)
         {
            return false;
         }
         var _loc2_:int = _loc1_ - 1;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.mPieces.push(this.createPiece(_loc3_));
            _loc3_++;
         }
         return true;
      }
      
      private function createPiece(param1:int) : HermitePiece
      {
         var _loc2_:int = 0;
         var _loc4_:HermitePoint = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc2_ = 0;
         while(_loc2_ <= 1)
         {
            _loc4_ = this.points[param1 + _loc2_];
            _loc5_ = 2 * _loc2_;
            this.z[_loc5_] = _loc4_.x;
            this.z[_loc5_ + 1] = _loc4_.x;
            this.q[_loc5_][0] = _loc4_.fx;
            this.q[_loc5_ + 1][0] = _loc4_.fx;
            this.q[_loc5_ + 1][1] = _loc4_.fxp;
            if(_loc2_ > 0)
            {
               this.q[_loc5_][1] = (this.q[_loc5_][0] - this.q[_loc5_ - 1][0]) / (this.z[_loc5_] - this.z[_loc5_ - 1]);
            }
            _loc2_++;
         }
         _loc2_ = 2;
         while(_loc2_ < NUM_DIMS)
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
         while(_loc2_ < NUM_DIMS)
         {
            _loc3_.coeffs[_loc2_] = this.q[_loc2_][_loc2_];
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function evaluatePiece(param1:Number, param2:Number, param3:Number, param4:HermitePiece) : Number
      {
         this.mXSub[0] = param1 - param2;
         this.mXSub[1] = param1 - param3;
         var _loc5_:Number = 1;
         var _loc6_:Number = param4.coeffs[0];
         var _loc7_:int = 1;
         while(_loc7_ < NUM_DIMS)
         {
            _loc5_ *= this.mXSub[Math.floor((_loc7_ - 1) * 0.5)];
            _loc6_ += _loc5_ * param4.coeffs[_loc7_];
            _loc7_++;
         }
         return _loc6_;
      }
   }
}
