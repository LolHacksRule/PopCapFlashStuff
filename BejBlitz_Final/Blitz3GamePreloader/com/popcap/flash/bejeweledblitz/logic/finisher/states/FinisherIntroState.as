package com.popcap.flash.bejeweledblitz.logic.finisher.states
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherIntroHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimePhaseEndHandler;
   
   public class FinisherIntroState implements IFinisherState, ITimerLogicTimeChangeHandler, ITimerLogicTimePhaseEndHandler, IFinisherIntroHandler
   {
       
      
      private var logic:BlitzLogic = null;
      
      private var timeHasCompleted:Boolean = false;
      
      private var timePhaseHasCompleted:Boolean = false;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      private var animationIsCompleted:Boolean = false;
      
      public function FinisherIntroState(param1:IFinisherUI, param2:BlitzLogic)
      {
         super();
         this.finisherUIInterface = param1;
         this.logic = param2;
      }
      
      public static function GetStateName() : String
      {
         return "FinisherIntroState";
      }
      
      public function Activate() : void
      {
         this.logic.timerLogic.AddTimeChangeHandler(this);
         this.logic.timerLogic.AddTimePhaseEndHandler(this);
         this.finisherUIInterface.showIntroWidget();
         this.finisherUIInterface.AddIntroAnimHandler(this);
      }
      
      public function IsStateCompleted() : Boolean
      {
         return this.timeHasCompleted && this.timePhaseHasCompleted && this.logic.board.IsStill();
      }
      
      public function IsStateCancelled() : Boolean
      {
         return false;
      }
      
      public function CleanUp() : void
      {
         this.logic.timerLogic.RemoveTimeChangeHandler(this);
         this.logic.timerLogic.RemoveTimePhaseEndHandler(this);
         this.finisherUIInterface.RemoveIntroAnimHandler(this);
      }
      
      public function Update(param1:Number) : void
      {
         this.finisherUIInterface.updateIntroWidget();
      }
      
      public function GetName() : String
      {
         return FinisherIntroState.GetStateName();
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(param1 == 0)
         {
            this.setTimeIsComplete();
         }
      }
      
      private function setTimeIsComplete() : void
      {
         this.AnimationCompleted();
         this.timeHasCompleted = true;
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(!this.timePhaseHasCompleted)
         {
            this.timePhaseHasCompleted = true;
         }
         if(this.logic.timerLogic.GetTimeRemaining() == 0)
         {
            this.setTimeIsComplete();
         }
      }
      
      public function AnimationCompleted() : void
      {
         if(!this.animationIsCompleted)
         {
            this.animationIsCompleted = true;
            this.finisherUIInterface.hideIntroWidget();
         }
      }
   }
}
