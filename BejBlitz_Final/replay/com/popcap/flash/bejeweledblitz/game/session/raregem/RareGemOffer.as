package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class RareGemOffer
   {
      
      static const STATE_WAITING:int = 0;
      
      static const STATE_AVAILABLE:int = 1;
      
      static const STATE_HARVESTED:int = 2;
      
      static const STATE_CONSUMED:int = 3;
       
      
      private var m_App:Blitz3App;
      
      private var m_Handlers:Vector.<IRareGemOfferHandler>;
      
      protected var isViral:Boolean;
      
      protected var state:int;
      
      protected var gemId:String;
      
      public function RareGemOffer(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<IRareGemOfferHandler>();
         this.isViral = false;
         this.state = STATE_WAITING;
         this.gemId = "";
      }
      
      public function IsAvailable() : Boolean
      {
         return this.state == STATE_AVAILABLE && this.gemId != "";
      }
      
      public function IsHarvested() : Boolean
      {
         return this.state == STATE_HARVESTED;
      }
      
      public function IsConsumed() : Boolean
      {
         return this.state == STATE_CONSUMED;
      }
      
      public function IsViral() : Boolean
      {
         return this.isViral;
      }
      
      public function GetID() : String
      {
         return this.gemId;
      }
      
      public function Harvest() : void
      {
         if(this.state == STATE_AVAILABLE)
         {
            this.SetState(STATE_HARVESTED);
         }
      }
      
      public function Consume() : void
      {
         this.SetState(STATE_CONSUMED);
      }
      
      public function Destroy() : void
      {
         this.Clear();
         this.SaveState();
      }
      
      public function AddHandler(handler:IRareGemOfferHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      function SetID(id:String) : void
      {
         this.gemId = id;
      }
      
      function GetState() : int
      {
         return this.state;
      }
      
      function SetState(nextState:int) : void
      {
         var prevState:int = this.state;
         this.state = nextState;
         this.DispatchStateChanged(prevState);
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
      
      private function DispatchStateChanged(prevState:int) : void
      {
         var handler:IRareGemOfferHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleOfferStateChanged(this,prevState,this.state);
         }
      }
   }
}
