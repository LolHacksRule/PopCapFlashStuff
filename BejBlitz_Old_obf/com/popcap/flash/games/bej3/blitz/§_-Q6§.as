package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.MoveData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class §_-Q6§ extends EventDispatcher
   {
      
      private static const §_-7§:Array = [3,6,12,20,30,45];
       
      
      private var §_-6P§:int = 0;
      
      private var §_-ai§:BlitzLogic;
      
      private var §_-RF§:int = 0;
      
      public function §_-Q6§(param1:BlitzLogic)
      {
         super();
         this.§_-ai§ = param1;
      }
      
      public function Update() : void
      {
         var _loc3_:Event = null;
         var _loc1_:int = this.§_-lX§();
         if(_loc1_ == 0)
         {
            this.§_-6P§ = 0;
            this.§_-RF§ = 0;
            return;
         }
         if(this.§_-RF§ >= §_-7§.length)
         {
            return;
         }
         if(_loc1_ <= this.§_-6P§)
         {
            return;
         }
         var _loc2_:int = -1;
         while(_loc1_ >= §_-7§[this.§_-RF§])
         {
            _loc2_ = this.§_-RF§;
            ++this.§_-RF§;
         }
         if(_loc2_ >= 0)
         {
            _loc3_ = new §_-Rh§(_loc2_);
            dispatchEvent(_loc3_);
         }
      }
      
      private function §_-2Y§(param1:MoveData) : int
      {
         var _loc2_:int = param1.§_-nk§;
         var _loc3_:int = int(Math.max(0,Math.pow(Math.max(0,_loc2_ - 1),1.5)));
         _loc2_ = param1.flamesUsed;
         _loc3_ += Math.max(0,_loc2_ * 2 - 1);
         _loc2_ = param1.starsUsed;
         _loc3_ += Math.max(0,_loc2_ * 2.5 - 1);
         _loc2_ = param1.hypersUsed;
         _loc3_ += Math.max(0,_loc2_ * 3 - 1);
         _loc2_ = param1.flamesMade;
         _loc3_ += _loc2_;
         _loc2_ = param1.starsMade;
         _loc3_ += _loc2_;
         _loc2_ = param1.hypersMade;
         _loc3_ += _loc2_ * 2;
         _loc2_ = param1.§_-if§;
         _loc3_ += Math.max(0,(_loc2_ - 5) * 8);
         _loc2_ = param1.§_-aU§;
         return int(_loc3_ + int(Math.pow(_loc2_ / 15,1.5)));
      }
      
      private function §_-lX§() : int
      {
         var _loc5_:MoveData = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Vector.<MoveData> = this.§_-ai§.moves;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = _loc2_[_loc4_]).isActive)
            {
               _loc6_ = this.§_-2Y§(_loc5_);
               _loc1_ = Math.max(_loc6_,_loc1_);
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function Reset() : void
      {
         this.§_-RF§ = 0;
      }
   }
}
