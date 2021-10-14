package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionIncrementByNode extends ActionNode
   {
       
      
      public function ActionIncrementByNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionIncrementBy";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:ProcessableNode = GetParamByName("val1");
         var _loc2_:ProcessableNode = GetParamByName("val2");
         if(_loc1_ == null || _loc2_ == null)
         {
            return null;
         }
         var _loc3_:ParameterNode = _loc1_.DoActionOrGetValue();
         var _loc4_:ParameterNode = _loc2_.DoActionOrGetValue();
         if(_loc3_ == null || _loc4_ == null)
         {
            return null;
         }
         var _loc5_:NumberDataTypeNode = _loc3_ as NumberDataTypeNode;
         var _loc6_:NumberDataTypeNode = _loc4_ as NumberDataTypeNode;
         _loc5_.IncrementBy(_loc6_);
         return null;
      }
   }
}
