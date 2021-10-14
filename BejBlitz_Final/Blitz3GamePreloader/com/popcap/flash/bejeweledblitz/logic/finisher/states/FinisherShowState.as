package com.popcap.flash.bejeweledblitz.logic.finisher.states
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherEntryIntroHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class FinisherShowState implements IFinisherState, IFinisherEntryIntroHandler
   {
       
      
      private var logic:BlitzLogic = null;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      private var animationIsCompleted:Boolean = false;
      
      public function FinisherShowState(param1:IFinisherUI, param2:BlitzLogic)
      {
         super();
         this.finisherUIInterface = param1;
         this.logic = param2;
      }
      
      public static function GetStateName() : String
      {
         return "FinisherShowState";
      }
      
      public function Activate() : void
      {
         this.finisherUIInterface.showEntryIntroWidget();
         this.finisherUIInterface.AddEntryIntroAnimHandler(this);
      }
      
      public function IsStateCompleted() : Boolean
      {
         return this.animationIsCompleted;
      }
      
      public function IsStateCancelled() : Boolean
      {
         return false;
      }
      
      public function CleanUp() : void
      {
         this.finisherUIInterface.RemoveEntryIntroAnimHandler(this);
      }
      
      public function Update(param1:Number) : void
      {
         this.finisherUIInterface.updateEntryIntroWidget();
      }
      
      public function GetName() : String
      {
         return FinisherShowState.GetStateName();
      }
      
      public function AnimationCompleted() : void
      {
         if(!this.animationIsCompleted)
         {
            this.animationIsCompleted = true;
            this.finisherUIInterface.hideEntryIntroWidget();
         }
      }
   }
}
