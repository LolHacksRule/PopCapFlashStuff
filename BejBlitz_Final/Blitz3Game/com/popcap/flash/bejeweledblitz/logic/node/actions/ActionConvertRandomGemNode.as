package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostInGameInfo;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.IBoostV2Handler;
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.bejeweledblitz.logic.genericBlockingEvent.GenericBlockingEvent;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.StringDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionConvertRandomGemNode extends ActionNode implements IBoostV2Handler
   {
       
      
      private var _actionQueueSize:int;
      
      private var _genericBlockingEvent:GenericBlockingEvent;
      
      var _actionQueueFeedbackCount:int;
      
      var _moveId:int;
      
      public function ActionConvertRandomGemNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
         this._actionQueueSize = 0;
         this._genericBlockingEvent = null;
         this._actionQueueFeedbackCount = 0;
         this._moveId = -1;
      }
      
      public static function GetActionType() : String
      {
         return "ActionConvertRandomGem";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc14_:MoveData = null;
         if(!mBlitzLogic.boostLogicV2.mBoostMap[mId].HasHandler(this))
         {
            mBlitzLogic.boostLogicV2.mBoostMap[mId].AddHandler(this);
         }
         var _loc1_:ProcessableNode = GetParamByName("from");
         var _loc2_:ProcessableNode = GetParamByName("count");
         var _loc3_:ProcessableNode = GetParamByName("to");
         if(_loc1_ == null || _loc2_ == null || _loc3_ == null)
         {
            return null;
         }
         var _loc4_:ParameterNode = _loc1_.DoActionOrGetValue();
         var _loc5_:ParameterNode = _loc2_.DoActionOrGetValue();
         var _loc6_:ParameterNode = _loc3_.DoActionOrGetValue();
         if(_loc4_ == null || _loc5_ == null || _loc6_ == null)
         {
            return null;
         }
         var _loc7_:String = (_loc4_ as StringDataTypeNode).dataValue;
         var _loc8_:Number = (_loc5_ as NumberDataTypeNode).dataValue;
         var _loc9_:String = (_loc6_ as StringDataTypeNode).dataValue;
         var _loc10_:int = -1;
         if(_loc9_ == "SelectedRareGem" && mBlitzLogic.rareGemsLogic.currentRareGem)
         {
            _loc10_ = DynamicRareGemWidget.getDynamicData(mBlitzLogic.rareGemsLogic.currentRareGem.getStringID()).getFlameColor();
         }
         var _loc12_:Number = (_loc11_ = mBlitzLogic.boostLogicV2.mBoostMap[mId] as BoostInGameInfo) == null ? Number(35) : (_loc11_.GetParticleFeedback() != null ? Number(_loc11_.GetParticleFeedback().getTime()) : Number(35));
         var _loc13_:Vector.<ActionQueue> = mBlitzLogic.ChangeRandomGemTypes(_loc7_,_loc8_,_loc9_,mId,_loc12_,mRNGType,_loc10_);
         this._actionQueueSize = _loc13_.length;
         if(this._actionQueueSize > 1)
         {
            this._genericBlockingEvent = mBlitzLogic.genericBlockingEventPool.GetNextGenericBlockingEvent();
            mBlitzLogic.AddBlockingEvent(this._genericBlockingEvent);
         }
         if(mBlitzLogic.boostLogicV2.mBoostMap[mId].usesEventOfType(BoostV2.EVENT_CLICK))
         {
            _loc14_ = mBlitzLogic.movePool.GetMove();
            mBlitzLogic.AddMove(_loc14_);
            this._moveId = _loc14_.id;
         }
         mBlitzLogic.boostLogicV2.mBoostMap[mId].DispatchBoostFeedbackQueue(_loc13_);
         return null;
      }
      
      public function HandleBoostFeedback(param1:String, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleBoostFeedbackQueue(param1:Vector.<ActionQueue>) : void
      {
      }
      
      public function HandleBoostFeedbackComplete(param1:ActionQueue) : void
      {
         ++this._actionQueueFeedbackCount;
         if(this._genericBlockingEvent != null && this._actionQueueFeedbackCount == this._actionQueueSize)
         {
            this._genericBlockingEvent.SetDone();
            this._actionQueueFeedbackCount = 0;
         }
         if(param1.mGem == null || !param1.mGem.CanSelect())
         {
            return;
         }
         if(param1.mQueueType == ActionQueue.QUEUE_CHANGE_TYPE)
         {
            if(param1.mValue1 == Gem.TYPE_FLAME && param1.mValue2 != -1)
            {
               param1.mGem.color = param1.mValue2;
            }
            mBlitzLogic.QueueChangeGemType(param1.mGem,param1.mValue1,this._moveId,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
         }
         else if(param1.mQueueType == ActionQueue.QUEUE_CHANGE_COLOR)
         {
            mBlitzLogic.QueueChangeGemColor(param1.mGem,param1.mValue1,this._moveId,ReplayCommands.COMMAND_PLAY_AND_REPLAY);
         }
         else if(param1.mQueueType == ActionQueue.QUEUE_SPAWN_TOKEN_GEM)
         {
            mBlitzLogic.QueueAddRGToken(param1.mGem);
         }
      }
      
      public function HandleBoostActivated(param1:String) : void
      {
      }
      
      public function HandleBoostActivationFailed(param1:String) : void
      {
      }
      
      public function HandleMoveSuccessful(param1:String, param2:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlastUpdate(param1:String) : void
      {
      }
      
      public function HandleBoostGameTimeChange(param1:String, param2:int) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleMultiplierBonus(param1:int) : void
      {
      }
      
      public function BoardCellsActivate(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
      }
      
      public function BoardCellsDeactivate(param1:String, param2:Boolean) : void
      {
      }
      
      public function ForceStateChange(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:Number, param7:Number) : void
      {
      }
   }
}
