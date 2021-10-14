package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.*;
   
   public class FinisherAnimState
   {
       
      
      private var introFrame:FinisherFrame;
      
      private var exitFrame:FinisherFrame;
      
      private var propVisibility:Boolean;
      
      private var states:Vector.<FinisherConfigState>;
      
      public function FinisherAnimState(param1:Object)
      {
         super();
         this.parse(param1);
      }
      
      public function GetStates() : Vector.<FinisherConfigState>
      {
         return this.states;
      }
      
      public function GetIntroFrame() : IFinisherFrame
      {
         return this.introFrame;
      }
      
      public function GetExitFrame() : IFinisherFrame
      {
         return this.exitFrame;
      }
      
      public function IsPropVisible() : Boolean
      {
         return this.propVisibility;
      }
      
      public function parse(param1:Object) : void
      {
         var _loc4_:Object = null;
         var _loc5_:FinisherConfigState = null;
         this.introFrame = new FinisherFrame(param1.introFrame);
         this.exitFrame = new FinisherFrame(param1.exitFrame);
         this.propVisibility = Utils.getBoolFromObjectKey(param1,"propVisibility",true);
         this.states = new Vector.<FinisherConfigState>();
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1,"states");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = new FinisherConfigState(_loc4_);
            this.states.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
