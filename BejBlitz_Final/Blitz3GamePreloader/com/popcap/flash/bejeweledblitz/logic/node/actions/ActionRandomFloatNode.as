package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionRandomFloatNode extends ActionNode
   {
       
      
      public function ActionRandomFloatNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionRandomFloat";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:BlitzRandom = mBlitzLogic.GetRNGOfType(mRNGType);
         var _loc2_:ProcessableNode = GetParamByName("val1");
         var _loc3_:ProcessableNode = GetParamByName("val2");
         if(_loc2_ == null || _loc3_ == null)
         {
            return new NumberDataTypeNode(_loc1_.Float(0,1));
         }
         var _loc4_:ParameterNode = _loc2_.DoActionOrGetValue();
         var _loc5_:ParameterNode = _loc3_.DoActionOrGetValue();
         if(_loc4_ == null || _loc5_ == null)
         {
            return new NumberDataTypeNode(_loc1_.Float(0,1));
         }
         var _loc6_:NumberDataTypeNode = _loc4_ as NumberDataTypeNode;
         var _loc7_:NumberDataTypeNode = _loc5_ as NumberDataTypeNode;
         return new NumberDataTypeNode(_loc1_.Float(_loc6_.dataValue,_loc7_.dataValue));
      }
   }
}
