package com.popcap.flash.bejeweledblitz.logic.boostV2
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   
   public interface IBoostV2Handler
   {
       
      
      function HandleBoostFeedback(param1:String, param2:Vector.<Gem>) : void;
      
      function HandleBoostFeedbackQueue(param1:Vector.<ActionQueue>) : void;
      
      function HandleBoostFeedbackComplete(param1:ActionQueue) : void;
      
      function HandleBoostActivated(param1:String) : void;
      
      function HandleBoostActivationFailed(param1:String) : void;
      
      function HandleMoveSuccessful(param1:String, param2:SwapData) : void;
      
      function HandleSpecialGemBlastUpdate(param1:String) : void;
      
      function HandleBoostGameTimeChange(param1:String, param2:int) : void;
      
      function HandleMultiplierBonus(param1:int) : void;
      
      function HandleBlockingEvent() : void;
      
      function BoardCellsActivate(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void;
      
      function BoardCellsDeactivate(param1:String, param2:Boolean) : void;
      
      function ForceStateChange(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:Number, param7:Number) : void;
   }
}
