package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionIncreaseMultiplierPermanentNode extends ActionNode
   {
       
      
      public function ActionIncreaseMultiplierPermanentNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionIncreaseMultiplierPermanent";
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
         mBlitzLogic.multiLogic.ForceSetMultiplier(mBlitzLogic.multiLogic.multiplier + _loc3_);
         var _loc4_:Vector.<ActionQueue>;
         (_loc4_ = new Vector.<ActionQueue>()).push(new ActionQueue(null,ActionQueue.SHOW_CROSSCOLLECTOR_FEEDBACK,2,0));
         mBlitzLogic.boostLogicV2.mBoostMap[mId].DispatchBoostFeedbackQueue(_loc4_);
         return null;
      }
   }
}
