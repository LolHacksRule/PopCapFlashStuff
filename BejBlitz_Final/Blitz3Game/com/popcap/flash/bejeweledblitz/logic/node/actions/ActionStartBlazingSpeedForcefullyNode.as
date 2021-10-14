package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionStartBlazingSpeedForcefullyNode extends ActionNode
   {
       
      
      public function ActionStartBlazingSpeedForcefullyNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionStartBlazingSpeedForcefully";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc2_:ParameterNode = null;
         var _loc3_:Number = NaN;
         mBlitzLogic.speedBonus.IncrementBonus(1000,true);
         if(mBlitzLogic.blazingSpeedLogic.IsRunning())
         {
            mBlitzLogic.blazingSpeedLogic.ResetBlazingSpeed();
            mBlitzLogic.blazingSpeedLogic.SetTimerLeft(mBlitzLogic.blazingSpeedLogic.GetDuration());
         }
         else
         {
            mBlitzLogic.blazingSpeedLogic.StartBonus();
         }
         var _loc1_:ProcessableNode = GetParamByName("bonusduration");
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.DoActionOrGetValue();
            if(_loc2_ != null)
            {
               _loc3_ = (_loc2_ as NumberDataTypeNode).dataValue;
               if(_loc3_ > 0)
               {
                  mBlitzLogic.speedBonus.SetBonusThreshold(_loc3_);
               }
            }
         }
         return null;
      }
   }
}
