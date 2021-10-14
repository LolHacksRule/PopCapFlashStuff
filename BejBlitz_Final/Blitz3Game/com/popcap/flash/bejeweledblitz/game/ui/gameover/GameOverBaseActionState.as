package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.api.IGameOverWidgetActionState;
   
   public class GameOverBaseActionState implements IGameOverWidgetActionState
   {
       
      
      protected var nextState:IGameOverWidgetActionState;
      
      protected var gameOverWidget:GameOverV2Widget;
      
      protected var isComplete:Boolean = false;
      
      public function GameOverBaseActionState()
      {
         super();
      }
      
      public function setNext(param1:IGameOverWidgetActionState, param2:GameOverV2Widget) : void
      {
         this.nextState = param1;
         this.gameOverWidget = param2;
      }
      
      public function processAction() : void
      {
      }
      
      public function forceCompleteAction() : void
      {
      }
      
      public function isDone() : Boolean
      {
         return this.isComplete;
      }
      
      public function setDone() : IGameOverWidgetActionState
      {
         this.isComplete = true;
         return this.nextState;
      }
   }
}
