package com.popcap.flash.bejeweledblitz.logic.finisher.interfaces
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.finisher.FinisherActor;
   import com.popcap.flash.bejeweledblitz.logic.finisher.FinisherProp;
   
   public interface IFinisherUI
   {
       
      
      function AddAsIndicatorHandler() : void;
      
      function RemoveAsIndicatorHandler() : void;
      
      function setCurrentStateId(param1:int) : void;
      
      function showGo() : void;
      
      function showBonusTime(param1:int, param2:int) : void;
      
      function showIntroWidget() : void;
      
      function updateIntroWidget() : void;
      
      function hideIntroWidget() : void;
      
      function showEntryIntroWidget() : void;
      
      function updateEntryIntroWidget() : void;
      
      function hideEntryIntroWidget() : void;
      
      function AddEntryIntroAnimHandler(param1:IFinisherEntryIntroHandler) : void;
      
      function RemoveEntryIntroAnimHandler(param1:IFinisherEntryIntroHandler) : void;
      
      function AddIntroAnimHandler(param1:IFinisherIntroHandler) : void;
      
      function RemoveIntroAnimHandler(param1:IFinisherIntroHandler) : void;
      
      function showPopupWidget() : Boolean;
      
      function hidePopupWidget(param1:Boolean) : void;
      
      function updatePopup(param1:Number) : void;
      
      function showActor() : void;
      
      function hideActor() : void;
      
      function AddActorAnimationCompleteHandler(param1:IFinisherAnimHandler) : void;
      
      function RemoveActorAnimationCompleteHandler(param1:IFinisherAnimHandler) : void;
      
      function playActor(param1:int, param2:int, param3:int) : void;
      
      function updateActor() : void;
      
      function generateProp(param1:FinisherActor, param2:Gem, param3:Number, param4:Boolean) : FinisherProp;
      
      function updatePropPosition(param1:FinisherProp, param2:Gem, param3:Number, param4:Number) : void;
      
      function destroyProp(param1:FinisherProp) : void;
      
      function disableTimeUpSound() : void;
      
      function enableTimeUpSound() : void;
      
      function AddPopupHandler(param1:IFinisherPopupHandler) : void;
      
      function RemovePopupHandler(param1:IFinisherPopupHandler) : void;
      
      function ShouldBlockWaitState() : Boolean;
   }
}
