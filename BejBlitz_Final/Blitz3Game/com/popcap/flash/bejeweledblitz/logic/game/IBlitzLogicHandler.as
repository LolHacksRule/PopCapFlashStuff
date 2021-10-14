package com.popcap.flash.bejeweledblitz.logic.game
{
   public interface IBlitzLogicHandler
   {
       
      
      function HandleGameLoad() : void;
      
      function HandleGameBegin() : void;
      
      function HandleGameEnd() : void;
      
      function HandleGameAbort() : void;
      
      function HandleGamePaused() : void;
      
      function HandleGameResumed() : void;
      
      function HandleScore(param1:ScoreValue) : void;
      
      function HandleBlockingEvent() : void;
      
      function HandleGameTimeDelayed() : void;
   }
}
