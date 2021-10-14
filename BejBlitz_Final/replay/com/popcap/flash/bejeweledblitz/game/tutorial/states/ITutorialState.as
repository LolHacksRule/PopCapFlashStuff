package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   public interface ITutorialState
   {
       
      
      function Update() : void;
      
      function EnterState() : void;
      
      function ExitState() : void;
      
      function IsComplete() : Boolean;
      
      function ForceComplete() : void;
   }
}
