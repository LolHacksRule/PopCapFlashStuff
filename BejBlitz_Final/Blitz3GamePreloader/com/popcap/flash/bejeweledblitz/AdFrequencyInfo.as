package com.popcap.flash.bejeweledblitz
{
   public class AdFrequencyInfo
   {
       
      
      private var _placement:String;
      
      private var _adCap:uint;
      
      private var _rewardCap:uint;
      
      private var _adsRemaining:int;
      
      public function AdFrequencyInfo(param1:Object)
      {
         super();
         this.placement = param1["placement"];
         this.adCap = param1["adCap"];
         this.rewardCap = param1["rewardCap"];
         this.adsRemaining = param1["adCap"];
      }
      
      public function get placement() : String
      {
         return this._placement;
      }
      
      public function set placement(param1:String) : void
      {
         this._placement = param1;
      }
      
      public function get adCap() : uint
      {
         return this._adCap;
      }
      
      public function set adCap(param1:uint) : void
      {
         this._adCap = param1;
      }
      
      public function get rewardCap() : uint
      {
         return this._rewardCap;
      }
      
      public function set rewardCap(param1:uint) : void
      {
         this._rewardCap = param1;
      }
      
      public function get adsRemaining() : int
      {
         return this._adsRemaining;
      }
      
      public function set adsRemaining(param1:int) : void
      {
         this._adsRemaining = param1;
      }
   }
}
