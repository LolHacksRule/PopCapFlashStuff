package com.popcap.flash.bejeweledblitz.logic.finisher.states
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.FinisherActor;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherConfig;
   import com.popcap.flash.bejeweledblitz.logic.finisher.events.FinisherBlockingEvent;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class FinisherPlayState implements IFinisherState
   {
       
      
      private var finisherActor:FinisherActor;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      private var logic:BlitzLogic = null;
      
      private var blockingEvent:FinisherBlockingEvent;
      
      private var config:IFinisherConfig;
      
      public function FinisherPlayState(param1:IFinisherUI, param2:BlitzLogic, param3:IFinisherConfig)
      {
         super();
         this.finisherUIInterface = param1;
         this.blockingEvent = new FinisherBlockingEvent(true);
         this.config = param3;
         this.logic = param2;
         this.finisherActor = new FinisherActor(this.finisherUIInterface,this.logic,param3);
      }
      
      public static function GetStateName() : String
      {
         return "FinisherPlayState";
      }
      
      public function Activate() : void
      {
         this.finisherActor.AddToStage();
         if(this.config.IsBlockingFinisher())
         {
            this.logic.AddTimeBlockingEvent(this.blockingEvent);
         }
      }
      
      public function IsStateCompleted() : Boolean
      {
         return this.finisherActor.IsCompleted() && this.logic.board.IsStill();
      }
      
      public function IsStateCancelled() : Boolean
      {
         return false;
      }
      
      public function CleanUp() : void
      {
         this.logic.finisherIndicatorLogic.End();
         this.finisherActor.CleanUp();
         if(this.config.IsBlockingFinisher())
         {
            this.blockingEvent.SetCompleted();
         }
      }
      
      public function Update(param1:Number) : void
      {
         this.finisherActor.Update(param1);
      }
      
      public function GetName() : String
      {
         return FinisherPlayState.GetStateName();
      }
   }
}
