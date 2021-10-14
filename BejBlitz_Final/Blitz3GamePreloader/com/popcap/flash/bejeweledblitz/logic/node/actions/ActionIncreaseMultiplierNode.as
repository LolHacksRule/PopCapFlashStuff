package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionIncreaseMultiplierNode extends ActionNode implements ITimerLogicTimeChangeHandler, ILastHurrahLogicHandler, IBlitzLogicHandler
   {
       
      
      private var mDuration:int = -1;
      
      private var mHandlerAdded:Boolean = false;
      
      private var mTimerFinished:Boolean = true;
      
      public function ActionIncreaseMultiplierNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionIncreaseMultiplier";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc4_:ParameterNode = null;
         var _loc1_:ProcessableNode = GetParamByName("val");
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc2_:ParameterNode = _loc1_.DoActionOrGetValue();
         if(_loc2_ == null)
         {
            return null;
         }
         this.SetMultiplierInternally((_loc2_ as NumberDataTypeNode).dataValue);
         var _loc3_:ProcessableNode = GetParamByName("duration");
         if(_loc3_ != null)
         {
            if((_loc4_ = _loc3_.DoActionOrGetValue()) != null)
            {
               this.mDuration = (_loc4_ as NumberDataTypeNode).dataValue;
               if(this.mDuration > 0)
               {
                  if(!this.mHandlerAdded)
                  {
                     mBlitzLogic.timerLogic.AddTimeChangeHandler(this);
                     mBlitzLogic.lastHurrahLogic.AddHandler(this);
                     mBlitzLogic.AddHandler(this);
                     this.mHandlerAdded = true;
                  }
                  this.mTimerFinished = false;
               }
            }
         }
         return null;
      }
      
      private function SetMultiplierInternally(param1:Number) : void
      {
         mBlitzLogic.SetMultiplierBonus(param1);
         mBlitzLogic.boostLogicV2.DispatchMultiplierBonus(param1);
      }
      
      private function EndMultiplierFunctionality() : void
      {
         if(mBlitzLogic.board.IsStill() && this.mTimerFinished == false)
         {
            this.mTimerFinished = true;
            this.SetMultiplierInternally(0);
         }
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(this.mTimerFinished && !this.mHandlerAdded)
         {
            return;
         }
         if(param1 <= 0)
         {
            return;
         }
         if(this.mDuration > 0)
         {
            --this.mDuration;
         }
         else
         {
            this.EndMultiplierFunctionality();
         }
      }
      
      public function handleLastHurrahBegin() : void
      {
         this.EndMultiplierFunctionality();
      }
      
      public function handleLastHurrahEnd() : void
      {
      }
      
      public function handlePreCoinHurrah() : void
      {
      }
      
      public function canBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.CleanUp();
      }
      
      public function HandleGameAbort() : void
      {
         this.SetMultiplierInternally(0);
         this.CleanUp();
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function CleanUp() : void
      {
         this.mTimerFinished = true;
         if(this.mHandlerAdded)
         {
            mBlitzLogic.timerLogic.RemoveTimeChangeHandler(this);
            mBlitzLogic.lastHurrahLogic.RemoveHandler(this);
            mBlitzLogic.RemoveHandler(this);
            this.mHandlerAdded = false;
         }
      }
      
      public function HandleGameTimeDelayed() : void
      {
         this.EndMultiplierFunctionality();
      }
   }
}
