package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionModulusNode extends ActionNode
   {
       
      
      public function ActionModulusNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionModulus";
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
         return _loc3_.Subtract(_loc4_);
      }
   }
}
