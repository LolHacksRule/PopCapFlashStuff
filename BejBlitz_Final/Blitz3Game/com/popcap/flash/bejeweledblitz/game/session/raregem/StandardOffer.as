package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   
   public class StandardOffer extends RareGemOffer implements IBlitzLogicHandler
   {
       
      
      public function StandardOffer(param1:Blitz3App)
      {
         super(param1);
         _app.logic.AddHandler(this);
      }
      
      override public function Destroy() : void
      {
         _app.logic.RemoveHandler(this);
         super.Destroy();
      }
      
      override function LoadState() : void
      {
      }
      
      override function Clear() : void
      {
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         if(_state == STATE_HARVESTED || _state == STATE_AVAILABLE)
         {
            SetState(STATE_CONSUMED);
         }
      }
      
      public function HandleGameEnd() : void
      {
      }
      
      override public function evaluateAvailable() : void
      {
         if(_state == STATE_WAITING && _app.sessionData.rareGemManager.hasMetTarget())
         {
            setAvailable();
         }
      }
      
      public function HandleGameAbort() : void
      {
         this.HandleGameEnd();
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
