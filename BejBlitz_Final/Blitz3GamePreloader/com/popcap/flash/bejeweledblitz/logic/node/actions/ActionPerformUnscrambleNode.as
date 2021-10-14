package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionPerformUnscrambleNode extends ActionNode
   {
       
      
      public function ActionPerformUnscrambleNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionPerformUnscramble";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc11_:ParameterNode = null;
         var _loc12_:ParameterNode = null;
         var _loc1_:Boolean = false;
         var _loc4_:ProcessableNode = GetParamByName("swapTime");
         var _loc5_:ProcessableNode = GetParamByName("postSwapTime");
         if(_loc4_ == null || _loc5_ == null)
         {
            _loc1_ = true;
         }
         else
         {
            _loc11_ = _loc4_.DoActionOrGetValue();
            _loc12_ = _loc5_.DoActionOrGetValue();
            if(_loc11_ == null || _loc12_ == null)
            {
               _loc1_ = true;
            }
            else
            {
               _loc2_ = (_loc11_ as NumberDataTypeNode).dataValue;
               _loc3_ = (_loc12_ as NumberDataTypeNode).dataValue;
            }
         }
         if(!_loc1_)
         {
            mBlitzLogic.config.unScrambleEventSwapTime = _loc2_;
            mBlitzLogic.config.unScrambleEventPostSwapTime = _loc3_;
         }
         var _loc6_:Vector.<Gem>;
         var _loc7_:* = (_loc6_ = mBlitzLogic.board.mGems).length;
         var _loc8_:Gem = null;
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_)
         {
            if((_loc8_ = _loc6_[_loc9_]) && _loc8_.type != Gem.TYPE_MULTI && _loc8_.type != Gem.TYPE_STANDARD)
            {
               if(_loc8_.immuneTime == 0 && !_loc8_.IsMatched() && !_loc8_.IsMatching())
               {
                  _loc8_.SetFuseTime(mBlitzLogic.config.unScrambleEventSwapTime + mBlitzLogic.config.unScrambleEventPostSwapTime);
                  _loc8_.moveID = -1;
               }
            }
            _loc9_++;
         }
         var _loc10_:Vector.<ActionQueue>;
         (_loc10_ = new Vector.<ActionQueue>()).push(new ActionQueue(null,ActionQueue.SHOW_UNSCRAMBLE_FEEDBACK,1,0));
         mBlitzLogic.boostLogicV2.mBoostMap[mId].DispatchBoostFeedbackQueue(_loc10_);
         mBlitzLogic.UnScrambleBoard(mId);
         return null;
      }
   }
}
