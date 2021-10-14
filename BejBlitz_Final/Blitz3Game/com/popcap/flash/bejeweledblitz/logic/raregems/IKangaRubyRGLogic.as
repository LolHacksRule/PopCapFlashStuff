package com.popcap.flash.bejeweledblitz.logic.raregems
{
   public interface IKangaRubyRGLogic
   {
       
      
      function getCurrentBoardPatternsIndex() : int;
      
      function getTimeLeftBeforeAttack() : Number;
      
      function AttackAnimationComplete() : void;
      
      function AttackCounter() : int;
      
      function NumberOfRubysDestroyed() : int;
      
      function ExplodeCurrentPattern() : void;
      
      function ExplodePrestigePattern(param1:int) : void;
   }
}
