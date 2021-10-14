package com.popcap.flash.bejeweledblitz.logic.finisher.states
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimePhaseEndHandler;
   
   public class FinisherEndState implements IFinisherState, ITimerLogicTimePhaseEndHandler
   {
       
      
      private var timePhaseHandleComplete:Boolean = false;
      
      private var logic:BlitzLogic = null;
      
      public function FinisherEndState(param1:BlitzLogic)
      {
         super();
         this.logic = param1;
      }
      
      public static function GetStateName() : String
      {
         return "FinisherEndState";
      }
      
      public function Activate() : void
      {
         this.logic.timerLogic.AddTimePhaseEndHandler(this);
      }
      
      public function IsStateCompleted() : Boolean
      {
         return this.timePhaseHandleComplete && this.logic.board.IsStill();
      }
      
      public function IsStateCancelled() : Boolean
      {
         return false;
      }
      
      public function CleanUp() : void
      {
         this.logic.timerLogic.RemoveTimePhaseEndHandler(this);
      }
      
      public function Update(param1:Number) : void
      {
      }
      
      public function GetName() : String
      {
         return FinisherEndState.GetStateName();
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(!this.timePhaseHandleComplete)
         {
            this.timePhaseHandleComplete = true;
         }
      }
   }
}
