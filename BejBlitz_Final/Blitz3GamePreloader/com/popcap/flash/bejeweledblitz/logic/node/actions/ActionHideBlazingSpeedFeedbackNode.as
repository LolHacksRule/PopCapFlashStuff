package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   
   public class ActionHideBlazingSpeedFeedbackNode extends ActionNode
   {
       
      
      public function ActionHideBlazingSpeedFeedbackNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionHideBlazingSpeedFeedback";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:Vector.<ActionQueue> = new Vector.<ActionQueue>();
         _loc1_.push(new ActionQueue(null,ActionQueue.HIDE_BLAZING_SPEED_FEEDBACK,0,0));
         mBlitzLogic.boostLogicV2.mBoostMap[mId].DispatchBoostFeedbackQueue(_loc1_);
         return null;
      }
   }
}
