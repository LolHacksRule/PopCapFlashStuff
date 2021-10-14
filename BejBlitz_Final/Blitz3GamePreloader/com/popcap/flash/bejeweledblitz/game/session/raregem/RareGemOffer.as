package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class RareGemOffer
   {
      
      static const STATE_WAITING:int = 0;
      
      static const STATE_AVAILABLE:int = 1;
      
      static const STATE_HARVESTED:int = 2;
      
      static const STATE_CONSUMED:int = 3;
       
      
      protected var _app:Blitz3App;
      
      protected var _isViral:Boolean;
      
      protected var _state:int;
      
      protected var _gemID:String;
      
      private var _handlers:Vector.<IRareGemOfferHandler>;
      
      public function RareGemOffer(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._handlers = new Vector.<IRareGemOfferHandler>();
         this._isViral = false;
         this._state = STATE_WAITING;
         this._gemID = "";
      }
      
      public function isAvailable() : Boolean
      {
         return this._state == STATE_AVAILABLE && this._gemID != "";
      }
      
      public function evaluateAvailable() : void
      {
         if(this._state == STATE_WAITING && this._gemID != "")
         {
            this.setAvailable();
         }
      }
      
      public function IsHarvested() : Boolean
      {
         return this._state == STATE_HARVESTED;
      }
      
      public function IsViral() : Boolean
      {
         return this._isViral;
      }
      
      public function GetID() : String
      {
         return this._gemID;
      }
      
      public function Harvest(param1:Boolean = false) : void
      {
         if(this.isAvailable() || param1)
         {
            this.SetState(STATE_HARVESTED);
         }
      }
      
      public function setAvailable() : void
      {
         this.SetState(STATE_AVAILABLE);
      }
      
      public function Consume() : void
      {
         this.SetState(STATE_CONSUMED);
      }
      
      public function Destroy() : void
      {
         this._state = STATE_WAITING;
         this.Clear();
         this.SaveState();
      }
      
      public function AddHandler(param1:IRareGemOfferHandler) : void
      {
         this._handlers.push(param1);
      }
      
      function SetID(param1:String) : void
      {
         this._gemID = param1;
      }
      
      function GetState() : int
      {
         return this._state;
      }
      
      function SetState(param1:int) : void
      {
         var _loc2_:int = this._state;
         this._state = param1;
         this.DispatchStateChanged(_loc2_);
      }
      
      function LoadState() : void
      {
      }
      
      function SaveState() : void
      {
      }
      
      function Clear() : void
      {
      }
      
      private function DispatchStateChanged(param1:int) : void
      {
         var _loc2_:IRareGemOfferHandler = null;
         for each(_loc2_ in this._handlers)
         {
            _loc2_.HandleOfferStateChanged(this,param1,this._state);
         }
      }
   }
}
