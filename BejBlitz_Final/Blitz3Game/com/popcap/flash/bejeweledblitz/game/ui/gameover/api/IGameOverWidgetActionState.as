package com.popcap.flash.bejeweledblitz.game.ui.gameover.api
{
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.GameOverV2Widget;
   
   public interface IGameOverWidgetActionState
   {
       
      
      function setNext(param1:IGameOverWidgetActionState, param2:GameOverV2Widget) : void;
      
      function processAction() : void;
      
      function forceCompleteAction() : void;
      
      function isDone() : Boolean;
      
      function setDone() : IGameOverWidgetActionState;
   }
}
