package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import org.osmf.logging.Log;
   
   public class SpinBoardTileInfo
   {
       
      
      private var mHighlightWeight:uint;
      
      private var mIsExclusive:Boolean;
      
      private var mRewards:Vector.<SpinBoardRewardInfo>;
      
      public function SpinBoardTileInfo()
      {
         super();
         this.mHighlightWeight = 0;
         this.mRewards = new Vector.<SpinBoardRewardInfo>();
         this.mIsExclusive = false;
      }
      
      public function GetHighlightWeight() : uint
      {
         return this.mHighlightWeight;
      }
      
      public function IsExclusive() : Boolean
      {
         return this.mIsExclusive;
      }
      
      public function GetRewards() : Vector.<SpinBoardRewardInfo>
      {
         return this.mRewards;
      }
      
      public function SetInfo(param1:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:SpinBoardRewardInfo = null;
         var _loc2_:Boolean = true;
         if(param1 == null)
         {
            _loc2_ = false;
         }
         else
         {
            this.mRewards.length = 0;
            this.mHighlightWeight = Utils.getUintFromObjectKey(param1,"weight",0);
            this.mIsExclusive = Utils.getBoolFromObjectKey(param1,"exclusive",false);
            _loc3_ = Utils.getArrayFromObjectKey(param1,"rewards");
            if(_loc3_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  if(!_loc3_[_loc4_].empty)
                  {
                     if((_loc5_ = new SpinBoardRewardInfo()).SetInfo(_loc3_[_loc4_]))
                     {
                        this.mRewards.push(_loc5_);
                     }
                     else
                     {
                        Log("[SpinBoardTileInfo] Invalid Reward");
                        _loc2_ = false;
                     }
                  }
                  _loc4_++;
               }
            }
         }
         return _loc2_;
      }
   }
}
