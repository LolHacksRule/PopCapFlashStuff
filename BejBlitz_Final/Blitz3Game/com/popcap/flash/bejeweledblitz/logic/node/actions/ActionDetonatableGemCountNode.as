package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   
   public class ActionDetonatableGemCountNode extends ActionNode
   {
       
      
      public function ActionDetonatableGemCountNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionDetonatableGemCount";
      }
      
      override public function DoAction() : ParameterNode
      {
         if(mBlitzLogic.mBlockingEvents.length > 0)
         {
            return new NumberDataTypeNode(0);
         }
         var _loc1_:int = mBlitzLogic.DetonatingGemCount();
         if(_loc1_ == 0)
         {
            Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_ACTIVATION_FAILED);
         }
         return new NumberDataTypeNode(_loc1_);
      }
   }
}
