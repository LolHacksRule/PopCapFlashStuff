package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class ForcedOffer extends RareGemOffer implements IBlitzLogicHandler
   {
       
      
      public function ForcedOffer(param1:Blitz3App)
      {
         super(param1);
         _state = STATE_AVAILABLE;
         _app.logic.AddHandler(this);
      }
      
      override public function Destroy() : void
      {
         _app.logic.RemoveHandler(this);
         super.Destroy();
         _app = null;
      }
      
      override function Clear() : void
      {
         _gemID = "";
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         if(_state == STATE_WAITING)
         {
            SetState(STATE_AVAILABLE);
         }
         else if(_state == STATE_HARVESTED || _state == STATE_AVAILABLE)
         {
            SetState(STATE_CONSUMED);
         }
      }
      
      public function HandleGameEnd() : void
      {
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
