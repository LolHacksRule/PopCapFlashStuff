package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   
   public class ComplimentLogic
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _lastAwesome:int;
      
      private var _thresholdIndex:int;
      
      private var _handlers:Vector.<IComplimentLogicHandler>;
      
      public function ComplimentLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._handlers = new Vector.<IComplimentLogicHandler>();
         this._lastAwesome = 0;
         this._thresholdIndex = 0;
      }
      
      public function AddHandler(param1:IComplimentLogicHandler) : void
      {
         this._handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IComplimentLogicHandler) : void
      {
         var _loc2_:int = this._handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._handlers.splice(_loc2_,1);
      }
      
      public function Reset() : void
      {
         this._thresholdIndex = 0;
      }
      
      public function Update() : void
      {
         var _loc1_:int = this.GetAwesomeness();
         if(_loc1_ == 0)
         {
            this._lastAwesome = 0;
            this._thresholdIndex = 0;
            return;
         }
         if(this._thresholdIndex >= this._logic.config.complimentLogicThreshold.length)
         {
            return;
         }
         if(_loc1_ <= this._lastAwesome)
         {
            return;
         }
         var _loc2_:int = -1;
         while(this._thresholdIndex < this._logic.config.complimentLogicThreshold.length && _loc1_ >= this._logic.config.complimentLogicThreshold[this._thresholdIndex])
         {
            _loc2_ = this._thresholdIndex;
            ++this._thresholdIndex;
         }
         if(_loc2_ >= 0)
         {
            this.DispatchCompliment(_loc2_);
         }
      }
      
      private function DispatchCompliment(param1:int) : void
      {
         var _loc2_:IComplimentLogicHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleCompliment(param1);
         }
      }
      
      private function GetAwesomeness() : int
      {
         var _loc5_:MoveData = null;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Vector.<MoveData> = this._logic.moves;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = _loc2_[_loc4_]).isActive)
            {
               _loc6_ = this.GetMoveAwesomeness(_loc5_);
               _loc1_ = Math.max(_loc6_,_loc1_);
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function GetMoveAwesomeness(param1:MoveData) : int
      {
         var _loc2_:int = param1.cascades;
         var _loc3_:int = Math.floor(Math.max(0,Math.pow(Math.max(0,_loc2_ - 1),1.5)));
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
         _loc2_ = param1.largestMatch;
         _loc3_ += Math.max(0,(_loc2_ - 5) * 8);
         _loc2_ = param1.gemsCleared;
         return int(_loc3_ + Math.floor(Math.pow(_loc2_ / 15,1.5)));
      }
   }
}
