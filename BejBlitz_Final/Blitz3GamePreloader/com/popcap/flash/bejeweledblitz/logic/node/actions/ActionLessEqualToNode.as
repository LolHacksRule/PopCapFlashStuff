package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionLessEqualToNode extends ActionNode
   {
       
      
      public function ActionLessEqualToNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionLessEqualTo";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:ProcessableNode = GetParamByName("val1");
         var _loc2_:ProcessableNode = GetParamByName("val2");
         var _loc3_:ProcessableNode = GetParamByName("true");
         var _loc4_:ProcessableNode = GetParamByName("false");
         if(_loc1_ == null || _loc2_ == null)
         {
            return new BooleanDataTypeNode(false);
         }
         var _loc5_:ParameterNode = _loc1_.DoActionOrGetValue();
         var _loc6_:ParameterNode = _loc2_.DoActionOrGetValue();
         if(_loc5_ == null || _loc5_ == null)
         {
            return new BooleanDataTypeNode(false);
         }
         var _loc7_:Boolean;
         if(_loc7_ = _loc5_.LessThan(_loc6_) || _loc5_.IsEqual(_loc6_))
         {
            if(_loc3_ != null)
            {
               _loc3_.DoActionOrGetValue();
            }
         }
         else if(_loc4_ != null)
         {
            _loc4_.DoActionOrGetValue();
         }
         return new BooleanDataTypeNode(_loc7_);
      }
   }
}
