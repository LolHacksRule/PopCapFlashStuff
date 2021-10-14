package com.popcap.flash.games.zuma2.logic
{
   public class QRand
   {
       
      
      public var mPrevLastHitUpdate:Vector.<int>;
      
      public var mWeights:Vector.<Number>;
      
      public var mCurSway:Vector.<Number>;
      
      public var mUpdateCnt:int;
      
      public var mLastIndex:int;
      
      public var mLastHitUpdate:Vector.<int>;
      
      public function QRand()
      {
         this.mWeights = new Vector.<Number>();
         this.mCurSway = new Vector.<Number>();
         this.mLastHitUpdate = new Vector.<int>();
         this.mPrevLastHitUpdate = new Vector.<int>();
         super();
         this.Init();
      }
      
      public function SetWeights(param1:Vector.<Number>) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.mWeights = new Vector.<Number>();
         if(param1.length == 1)
         {
            this.mWeights.push(1 - param1[0]);
            this.mWeights.push(param1[0]);
         }
         else
         {
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               this.mWeights.push(param1[_loc4_]);
               _loc3_ += this.mWeights[_loc4_];
               _loc4_++;
            }
            _loc5_ = 0;
            while(_loc5_ < this.mWeights.length)
            {
               this.mWeights[_loc5_] /= _loc3_;
               _loc5_++;
            }
         }
         var _loc2_:int = int(this.mLastHitUpdate.length);
         while(_loc2_ < this.mWeights.length)
         {
            this.mLastHitUpdate.push(0);
            this.mPrevLastHitUpdate.push(0);
            _loc2_++;
         }
         this.mCurSway = new Vector.<Number>();
      }
      
      public function HasWeight(param1:int) : Boolean
      {
         if(param1 >= this.mWeights.length)
         {
            return false;
         }
         return this.mWeights[param1] > 0;
      }
      
      public function Next() : int
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         ++this.mUpdateCnt;
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.mWeights.length)
         {
            if((_loc5_ = this.mWeights[_loc2_]) != 0)
            {
               _loc6_ = 1 / _loc5_;
               _loc7_ = 1 + (Number(this.mUpdateCnt - this.mLastHitUpdate[_loc2_]) - _loc6_) / _loc6_;
               _loc8_ = 1 + (Number(this.mUpdateCnt - this.mPrevLastHitUpdate[_loc2_]) - _loc6_ * 2) / (_loc6_ * 2);
               _loc9_ = _loc5_ * Math.max(Math.min(_loc7_ * 0.75 + _loc8_ * 0.25,3),0.333);
               this.mCurSway[_loc2_] = _loc9_;
               _loc1_ += _loc9_;
            }
            else
            {
               this.mCurSway[_loc2_] = 0;
            }
            _loc2_++;
         }
         var _loc3_:Number = Math.random() * _loc1_;
         var _loc4_:int = 0;
         while(_loc4_ < this.mCurSway.length && _loc3_ > this.mCurSway[_loc4_])
         {
            _loc3_ -= this.mCurSway[_loc4_];
            _loc4_++;
         }
         if(_loc4_ >= this.mCurSway.length)
         {
            _loc4_--;
         }
         this.mPrevLastHitUpdate[_loc4_] = this.mLastHitUpdate[_loc4_];
         this.mLastHitUpdate[_loc4_] = this.mUpdateCnt;
         this.mLastIndex = _loc4_;
         return _loc4_;
      }
      
      public function Init() : void
      {
         this.mUpdateCnt = 0;
         this.mLastIndex = -1;
      }
      
      public function Clear() : void
      {
         this.mWeights = new Vector.<Number>();
         this.mCurSway = new Vector.<Number>();
         this.mLastHitUpdate = new Vector.<int>();
         this.mPrevLastHitUpdate = new Vector.<int>();
      }
      
      public function NumNonZeroWeights() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.mWeights.length)
         {
            if(this.mWeights[_loc2_] != 0)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
