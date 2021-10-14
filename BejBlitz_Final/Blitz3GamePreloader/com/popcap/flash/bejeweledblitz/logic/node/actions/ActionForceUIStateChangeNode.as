package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.StringDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionForceUIStateChangeNode extends ActionNode
   {
       
      
      public function ActionForceUIStateChangeNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionForceUIStateChange";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc12_:ParameterNode = null;
         var _loc13_:ParameterNode = null;
         var _loc14_:ParameterNode = null;
         var _loc1_:Boolean = false;
         var _loc2_:ProcessableNode = GetParamByName("override");
         if(_loc2_ != null)
         {
            _loc1_ = (_loc12_ = _loc2_.DoActionOrGetValue()) == null ? false : Boolean((_loc12_ as BooleanDataTypeNode).dataValue);
         }
         var _loc3_:ProcessableNode = GetParamByName("state");
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:ParameterNode;
         if((_loc4_ = _loc3_.DoActionOrGetValue()) == null)
         {
            return null;
         }
         var _loc5_:String = (_loc4_ as StringDataTypeNode).dataValue;
         var _loc6_:String = "INFOTYPE_NONE";
         var _loc7_:ProcessableNode;
         if((_loc7_ = GetParamByName("infotype")) != null)
         {
            _loc6_ = ((_loc13_ = _loc7_.DoActionOrGetValue()) as StringDataTypeNode).dataValue;
         }
         var _loc8_:String = "PROGRESSTYPE_NONE";
         var _loc9_:ProcessableNode;
         if((_loc9_ = GetParamByName("progresstype")) != null)
         {
            _loc8_ = ((_loc14_ = _loc9_.DoActionOrGetValue()) as StringDataTypeNode).dataValue;
         }
         mBlitzLogic.boostLogicV2.DispatchForceStateChange(mId,_loc1_,_loc5_,_loc6_,_loc8_,0,0);
         return null;
      }
   }
}
