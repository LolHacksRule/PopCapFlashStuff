package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionOrNode extends ActionNode
   {
       
      
      public function ActionOrNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionOr";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:ProcessableNode = GetParamByName("val1");
         var _loc2_:ProcessableNode = GetParamByName("val2");
         if(_loc1_ == null || _loc2_ == null)
         {
            return new BooleanDataTypeNode(false);
         }
         var _loc3_:ParameterNode = _loc1_.DoActionOrGetValue();
         var _loc4_:ParameterNode = _loc2_.DoActionOrGetValue();
         if(_loc3_ == null || _loc3_ == null)
         {
            return new BooleanDataTypeNode(false);
         }
         var _loc5_:BooleanDataTypeNode = _loc3_ as BooleanDataTypeNode;
         var _loc6_:BooleanDataTypeNode = _loc4_ as BooleanDataTypeNode;
         if(_loc5_ == null || _loc6_ == null)
         {
            return new BooleanDataTypeNode(false);
         }
         return new BooleanDataTypeNode(_loc5_.dataValue == true || _loc6_.dataValue == true);
      }
   }
}
