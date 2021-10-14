package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionIncreaseScoreDeltaNode extends ActionNode
   {
       
      
      public function ActionIncreaseScoreDeltaNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionIncreaseScoreDelta";
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
         mBlitzLogic.SetScoreBonus(_loc3_);
         return null;
      }
   }
}
