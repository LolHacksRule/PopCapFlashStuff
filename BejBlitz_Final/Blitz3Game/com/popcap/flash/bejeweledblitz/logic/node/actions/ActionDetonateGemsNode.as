package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostInGameInfo;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   
   public class ActionDetonateGemsNode extends ActionNode
   {
       
      
      public function ActionDetonateGemsNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionDetonateGems";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc1_:BoostInGameInfo = mBlitzLogic.boostLogicV2.mBoostMap[mId] as BoostInGameInfo;
         var _loc2_:Number = _loc1_ == null ? Number(35) : (_loc1_.GetParticleFeedback() != null ? Number(_loc1_.GetParticleFeedback().getTime()) : Number(35));
         var _loc3_:int = mBlitzLogic.DetonatingGemCount();
         if(_loc3_ == 0)
         {
            return null;
         }
         var _loc4_:Number = _loc2_ + _loc3_ * 30;
         mBlitzLogic.QueueDetonateOnBoard(mId,_loc2_);
         return new NumberDataTypeNode(_loc4_);
      }
   }
}
