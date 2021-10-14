package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionAddExtraTimeAtGameEndNode extends ActionNode
   {
       
      
      public function ActionAddExtraTimeAtGameEndNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionAddExtraTimeAtGameEnd";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:ProcessableNode = GetParamByName("time");
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc2_:ParameterNode = _loc1_.DoActionOrGetValue();
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:Number = (_loc2_ as NumberDataTypeNode).dataValue;
         mBlitzLogic.timerLogic.AddExtraTimeAtGameEnd(_loc3_);
         return null;
      }
   }
}
