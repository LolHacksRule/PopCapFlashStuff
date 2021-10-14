package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionIncreaseSpecialGemBonusNode extends ActionNode
   {
       
      
      public function ActionIncreaseSpecialGemBonusNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionIncreaseSpecialGemBonus";
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
         var _loc4_:Vector.<Gem>;
         var _loc5_:int = (_loc4_ = mBlitzLogic.board.mGems).length;
         var _loc6_:Gem = null;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            if((_loc6_ = _loc4_[_loc7_]).type != Gem.TYPE_MULTI && _loc6_.type != Gem.TYPE_STANDARD)
            {
               _loc6_.bonusValue += _loc3_;
            }
            _loc7_++;
         }
         return null;
      }
   }
}
