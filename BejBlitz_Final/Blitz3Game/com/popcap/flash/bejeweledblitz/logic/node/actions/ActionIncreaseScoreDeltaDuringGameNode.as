package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionIncreaseScoreDeltaDuringGameNode extends ActionNode
   {
       
      
      public function ActionIncreaseScoreDeltaDuringGameNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionIncreaseScoreDeltaDuringGame";
      }
      
      override public function DoAction() : ParameterNode
      {
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
         var _loc3_:int = (_loc2_ as NumberDataTypeNode).dataValue;
         mBlitzLogic.IncreaseScoreBonusDuringGame(_loc3_);
         var _loc4_:Vector.<ActionQueue>;
         (_loc4_ = new Vector.<ActionQueue>()).push(new ActionQueue(null,ActionQueue.MODIFY_SCORE_BONUS_DURING_GAME,mBlitzLogic.GetScoreBonus(),mBlitzLogic.GetScoreBonusDuringGame()));
         mBlitzLogic.boostLogicV2.mBoostMap[mId].DispatchBoostFeedbackQueue(_loc4_);
         return null;
      }
   }
}
