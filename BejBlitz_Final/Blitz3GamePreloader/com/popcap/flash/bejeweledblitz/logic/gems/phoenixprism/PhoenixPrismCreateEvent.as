package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class PhoenixPrismCreateEvent implements IBlitzEvent
   {
       
      
      private var _logic:BlitzLogic;
      
      private var _locus:Gem;
      
      private var _match:Match;
      
      private var _gems:Vector.<Gem>;
      
      private var _time:Number;
      
      private var _isInited:Boolean;
      
      private var _isDone:Boolean;
      
      public function PhoenixPrismCreateEvent(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this._gems = new Vector.<Gem>();
      }
      
      public function GetPercent() : Number
      {
         return this._time / this._logic.config.phoenixPrismCreateEventDuration;
      }
      
      public function GetLocus() : Gem
      {
         return this._locus;
      }
      
      public function GetGems() : Vector.<Gem>
      {
         if(!this._isInited)
         {
            return new Vector.<Gem>();
         }
         return this._gems;
      }
      
      public function GetTime() : Number
      {
         return this._time;
      }
      
      public function Set(param1:Gem, param2:Match) : void
      {
         this._locus = param1;
         this._match = param2;
      }
      
      public function Init() : void
      {
         var _loc1_:Gem = null;
         if(this._isInited)
         {
            return;
         }
         if(this._match == null)
         {
            return;
         }
         for each(_loc1_ in this._match.matchGems)
         {
            if(!(_loc1_ == null || _loc1_ == this._locus || !_loc1_.IsMatching() || _loc1_.IsElectric()))
            {
               _loc1_.Flush();
               this._gems.push(_loc1_);
            }
         }
         this._isInited = true;
      }
      
      public function Reset() : void
      {
         this._time = 0;
         this._isInited = false;
         this._isDone = false;
         this._locus = null;
         this._match = null;
         this._gems.length = 0;
      }
      
      public function Update(param1:Number) : void
      {
         if(this._isDone)
         {
            return;
         }
         this._time += param1;
         if(this._time >= this._logic.config.phoenixPrismCreateEventDuration)
         {
            this._time = this._logic.config.phoenixPrismCreateEventDuration;
            this._isDone = true;
            this.OnDone();
         }
      }
      
      public function IsDone() : Boolean
      {
         return this._isDone;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return false;
      }
      
      private function OnDone() : void
      {
         var _loc3_:Gem = null;
         var _loc1_:int = this._gems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._gems[_loc2_];
            _loc3_.SetDead(true);
            _loc2_++;
         }
      }
   }
}
