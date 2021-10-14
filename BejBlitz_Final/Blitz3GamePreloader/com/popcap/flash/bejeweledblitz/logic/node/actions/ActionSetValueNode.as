package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.StringDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionSetValueNode extends ActionNode
   {
       
      
      public function ActionSetValueNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionSetValue";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc6_:NumberDataTypeNode = null;
         var _loc7_:NumberDataTypeNode = null;
         var _loc8_:BooleanDataTypeNode = null;
         var _loc9_:BooleanDataTypeNode = null;
         var _loc10_:StringDataTypeNode = null;
         var _loc11_:StringDataTypeNode = null;
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
         var _loc5_:ProcessableNode;
         if((_loc5_ = GetParamByName("operation")) != null)
         {
            _loc5_.DoActionOrGetValue();
         }
         if(_loc3_ as NumberDataTypeNode != null)
         {
            _loc6_ = _loc3_ as NumberDataTypeNode;
            _loc7_ = _loc4_ as NumberDataTypeNode;
            _loc6_.dataValue = _loc7_.dataValue;
         }
         else if(_loc3_ as BooleanDataTypeNode != null)
         {
            _loc8_ = _loc3_ as BooleanDataTypeNode;
            _loc9_ = _loc4_ as BooleanDataTypeNode;
            _loc8_.dataValue = _loc9_.dataValue;
         }
         else if(_loc3_ as StringDataTypeNode != null)
         {
            _loc10_ = _loc3_ as StringDataTypeNode;
            _loc11_ = _loc4_ as StringDataTypeNode;
            _loc10_.dataValue = _loc11_.dataValue;
         }
         return null;
      }
   }
}
