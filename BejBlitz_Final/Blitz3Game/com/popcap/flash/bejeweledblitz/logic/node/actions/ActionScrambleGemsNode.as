package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   
   public class ActionScrambleGemsNode extends ActionNode
   {
       
      
      public function ActionScrambleGemsNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionScrambleGems";
      }
      
      override public function DoAction() : ParameterNode
      {
         mBlitzLogic.ScrambleBoard(mId);
         return null;
      }
   }
}
