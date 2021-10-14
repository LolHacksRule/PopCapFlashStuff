package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionShowBlazingSpeedFeedbackNode extends ActionNode
   {
       
      
      public function ActionShowBlazingSpeedFeedbackNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionShowBlazingSpeedFeedback";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc6_:ParameterNode = null;
         var _loc7_:ParameterNode = null;
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:ProcessableNode = GetParamByName("lineAnimDuration");
         if(_loc3_ != null)
         {
            if((_loc6_ = _loc3_.DoActionOrGetValue()) != null)
            {
               _loc1_ = (_loc6_ as NumberDataTypeNode).dataValue;
            }
         }
         var _loc4_:ProcessableNode;
         if((_loc4_ = GetParamByName("showGlow")) != null)
         {
            if((_loc7_ = _loc4_.DoActionOrGetValue()) != null)
            {
               _loc2_ = (_loc7_ as BooleanDataTypeNode).dataValue;
            }
         }
         var _loc5_:Vector.<ActionQueue>;
         (_loc5_ = new Vector.<ActionQueue>()).push(new ActionQueue(null,ActionQueue.SHOW_BLAZING_SPEED_FEEDBACK,_loc1_,int(_loc2_)));
         mBlitzLogic.boostLogicV2.mBoostMap[mId].DispatchBoostFeedbackQueue(_loc5_);
         return null;
      }
   }
}
