package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.StringDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   
   public class ActionGetEquipedRareGemNode extends ActionNode
   {
       
      
      public function ActionGetEquipedRareGemNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionGetEquipedRareGem";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:String = "";
         if(mBlitzLogic.rareGemsLogic.isDynamicGem() && mBlitzLogic.rareGemsLogic.currentRareGem && !mBlitzLogic.rareGemsLogic.currentRareGem.isTokenRareGem())
         {
            _loc1_ = mBlitzLogic.rareGemsLogic.currentRareGem.getStringID();
         }
         return new StringDataTypeNode(_loc1_);
      }
   }
}
