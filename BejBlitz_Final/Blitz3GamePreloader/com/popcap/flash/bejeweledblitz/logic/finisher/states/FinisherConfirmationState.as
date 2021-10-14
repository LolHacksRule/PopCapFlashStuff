package com.popcap.flash.bejeweledblitz.logic.finisher.states
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherConfig;
   import com.popcap.flash.bejeweledblitz.logic.finisher.events.FinisherBlockingEvent;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherPopupHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class FinisherConfirmationState implements IFinisherState, IFinisherPopupHandler
   {
       
      
      private var logic:BlitzLogic = null;
      
      private var clicked:Boolean = false;
      
      private var cancelled:Boolean = false;
      
      private var blockingEvent:FinisherBlockingEvent;
      
      private var isPopupAnimationComplete:Boolean = false;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      private var config:IFinisherConfig = null;
      
      public function FinisherConfirmationState(param1:IFinisherUI, param2:BlitzLogic, param3:FinisherBlockingEvent, param4:IFinisherConfig)
      {
         super();
         this.finisherUIInterface = param1;
         this.logic = param2;
         this.blockingEvent = param3;
         this.config = param4;
      }
      
      public static function GetStateName() : String
      {
         return "FinisherConfirmationState";
      }
      
      public function Activate() : void
      {
         if(this.finisherUIInterface.showPopupWidget())
         {
            this.logic.DispatchGameTimeDelayed();
            this.logic.CancelSwaps();
            this.logic.AddBlockingEvent(this.blockingEvent);
            this.logic.blazingSpeedLogic.BlockPendingAnimation();
            this.finisherUIInterface.AddPopupHandler(this);
            return;
         }
         this.cancelled = true;
         this.isPopupAnimationComplete = true;
      }
      
      public function IsStateCancelled() : Boolean
      {
         if(this.cancelled && this.isPopupAnimationComplete)
         {
            this.blockingEvent.SetCompleted();
            return true;
         }
         return false;
      }
      
      public function IsStateCompleted() : Boolean
      {
         return this.clicked && this.isPopupAnimationComplete;
      }
      
      public function CleanUp() : void
      {
         this.finisherUIInterface.RemovePopupHandler(this);
         this.finisherUIInterface.hidePopupWidget(this.clicked);
      }
      
      public function Update(param1:Number) : void
      {
         this.finisherUIInterface.updatePopup(param1);
      }
      
      public function OnFinisherPopupAnimationComplete() : void
      {
         if(!this.clicked)
         {
            this.logic.blazingSpeedLogic.UnblockPendingAnimation();
         }
         this.isPopupAnimationComplete = true;
      }
      
      public function OnFinisherPopupConfirm() : void
      {
         this.logic.QueueEncoreCommand(this.config.GetID(),true);
         this.clicked = true;
         this.logic.finisherIndicatorLogic.SetDuration(this.logic.config.blazingSteedRGLogicStartDuration * 3);
         this.logic.finisherIndicatorLogic.Start();
      }
      
      public function OnFinisherPopupCancel() : void
      {
         this.logic.QueueEncoreCommand(this.config.GetID(),false);
         this.logic.blazingSpeedLogic.UnblockPendingAnimation();
         this.cancelled = true;
      }
      
      public function GetName() : String
      {
         return FinisherConfirmationState.GetStateName();
      }
   }
}
