package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.IBoostV2Handler;
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.CellInfo;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicEventHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzScoreKeeperHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreData;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.StringDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionModifyCellPropertiesNode extends ActionNode implements ILastHurrahLogicHandler, IBlitzScoreKeeperHandler, IBlitzLogicEventHandler, IBoostV2Handler, ITimerLogicTimeChangeHandler
   {
       
      
      var mDuration:int;
      
      var mMatchedProcessableNode:ProcessableNode = null;
      
      var gemFrameLayoutPositioned:Boolean = false;
      
      var mProcessOnManualMatchOnly:Boolean = false;
      
      var isHandledAdded:Boolean = false;
      
      var mLastMatchIsManual:Boolean = false;
      
      var mWaitToProc:Boolean = false;
      
      public function ActionModifyCellPropertiesNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
         this.gemFrameLayoutPositioned = false;
         this.isHandledAdded = false;
         this.mProcessOnManualMatchOnly = false;
         this.mLastMatchIsManual = false;
         this.mWaitToProc = false;
      }
      
      public static function GetActionType() : String
      {
         return "ActionModifyCellProperties";
      }
      
      override public function DoCleanUp() : void
      {
         this.endCellModification(false);
         if(this.isHandledAdded)
         {
            mBlitzLogic.RemoveEventHandler(this);
            mBlitzLogic.lastHurrahLogic.RemoveHandler(this);
            mBlitzLogic.GetScoreKeeper().RemoveHandler(this);
            mBlitzLogic.boostLogicV2.mBoostMap[mId].RemoveHandler(this);
            mBlitzLogic.timerLogic.RemoveTimeChangeHandler(this);
            this.isHandledAdded = false;
         }
         this.mWaitToProc = false;
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc17_:ParameterNode = null;
         var _loc18_:String = null;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc1_:ProcessableNode = GetParamByName("pattern");
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc2_:ProcessableNode = GetParamByName("draw");
         var _loc3_:ProcessableNode = GetParamByName("color");
         var _loc4_:ProcessableNode = GetParamByName("score");
         var _loc5_:ProcessableNode = GetParamByName("mult");
         var _loc6_:ProcessableNode = GetParamByName("deltaMult");
         var _loc7_:ProcessableNode = GetParamByName("duration");
         var _loc8_:ProcessableNode = GetParamByName("manual");
         this.mMatchedProcessableNode = GetParamByName("matched");
         if(!this.isHandledAdded)
         {
            mBlitzLogic.AddEventHandler(this);
            mBlitzLogic.lastHurrahLogic.AddHandler(this);
            mBlitzLogic.GetScoreKeeper().AddHandler(this);
            mBlitzLogic.boostLogicV2.mBoostMap[mId].AddHandler(this);
            mBlitzLogic.timerLogic.AddTimeChangeHandler(this);
            this.isHandledAdded = true;
            if(_loc8_ != null)
            {
               _loc17_ = _loc8_.DoActionOrGetValue();
               this.mProcessOnManualMatchOnly = _loc17_ == null ? false : Boolean((_loc17_ as BooleanDataTypeNode).dataValue);
            }
            else
            {
               this.mProcessOnManualMatchOnly = false;
            }
         }
         var _loc9_:ParameterNode;
         if((_loc9_ = _loc1_.DoActionOrGetValue()) == null)
         {
            this.mWaitToProc = true;
            return null;
         }
         this.mWaitToProc = false;
         var _loc10_:ParameterNode = _loc2_.DoActionOrGetValue();
         var _loc11_:ParameterNode = _loc3_.DoActionOrGetValue();
         var _loc12_:ParameterNode = _loc4_.DoActionOrGetValue();
         var _loc13_:ParameterNode = _loc5_.DoActionOrGetValue();
         var _loc14_:ParameterNode = _loc7_ == null ? null : _loc7_.DoActionOrGetValue();
         var _loc15_:ParameterNode = _loc6_ == null ? null : _loc6_.DoActionOrGetValue();
         if(_loc10_ == null ? false : Boolean((_loc10_ as BooleanDataTypeNode).dataValue))
         {
            _loc18_ = _loc11_ == null ? "0,0,0,1" : (_loc11_ as StringDataTypeNode).dataValue;
            _loc19_ = _loc12_ == null ? 0 : int((_loc12_ as NumberDataTypeNode).dataValue);
            _loc20_ = _loc13_ == null ? 0 : int((_loc13_ as NumberDataTypeNode).dataValue);
            _loc21_ = _loc15_ == null ? 0 : int((_loc15_ as NumberDataTypeNode).dataValue);
            this.mDuration = _loc14_ == null ? -1 : int((_loc14_ as NumberDataTypeNode).dataValue);
            this.HighlightGridCellsFromPattern((_loc9_ as StringDataTypeNode).dataValue,_loc19_,_loc20_,_loc21_);
         }
         return new StringDataTypeNode("");
      }
      
      public function HighlightGridCellsFromPattern(param1:String, param2:int, param3:int, param4:int) : void
      {
         var _loc8_:int = 0;
         var _loc9_:CellInfo = null;
         var _loc10_:Vector.<ActionQueue> = null;
         var _loc11_:Gem = null;
         var _loc5_:int = 8;
         var _loc6_:int = -1;
         var _loc7_:int = 0;
         while(_loc7_ < 8)
         {
            _loc8_ = 0;
            while(_loc8_ < 8)
            {
               if(param1.charAt(_loc7_ + 8 * _loc8_) == "X")
               {
                  _loc5_ = _loc5_ < _loc7_ ? int(_loc5_) : int(_loc7_);
                  _loc6_ = _loc6_ > _loc8_ ? int(_loc6_) : int(_loc8_);
                  (_loc9_ = new CellInfo()).mAdditiveScore = param2;
                  _loc9_.mAdditiveMultiplier = param3;
                  mBlitzLogic.GetScoreKeeper().AddCellInfo(_loc7_.toString() + "x" + _loc8_.toString(),_loc9_);
               }
               _loc8_++;
            }
            _loc7_++;
         }
         if(!this.gemFrameLayoutPositioned)
         {
            mBlitzLogic.boostLogicV2.mBoostMap[mId].SetTargetType(BoostV2.TARGETTYPE_CELL);
            _loc10_ = new Vector.<ActionQueue>();
            _loc11_ = mBlitzLogic.board.GetGemAt(_loc6_,_loc5_);
            _loc10_.push(new ActionQueue(_loc11_,ActionQueue.QUEUE_GENERATE_HIGHLIGHT_ON_BOARD,param2,param3));
            mBlitzLogic.boostLogicV2.mBoostMap[mId].DispatchBoostFeedbackQueue(_loc10_);
            this.gemFrameLayoutPositioned = true;
            mBlitzLogic.QueueShowPatternOnBoard(mId,_loc5_,_loc6_,param2,param3,param4);
         }
      }
      
      private function endCellModification(param1:Boolean) : void
      {
         mBlitzLogic.GetScoreKeeper().ClearAllCellInfo();
         this.gemFrameLayoutPositioned = false;
         this.mDuration = -1;
         this.mWaitToProc = false;
         mBlitzLogic.boostLogicV2.DispatchBoardCellsDeactivate(mId,param1);
      }
      
      public function handleLastHurrahBegin() : void
      {
         this.DoCleanUp();
      }
      
      public function handleLastHurrahEnd() : void
      {
      }
      
      public function handlePreCoinHurrah() : void
      {
      }
      
      public function canBeginCoinHurrah() : Boolean
      {
         return true;
      }
      
      public function HandlePointsScored(param1:ScoreData) : void
      {
         if(!this.gemFrameLayoutPositioned || this.mMatchedProcessableNode == null || !this.GemMatchConditionMet(param1))
         {
            this.mLastMatchIsManual = false;
            return;
         }
         if(this.mProcessOnManualMatchOnly)
         {
            if(this.mLastMatchIsManual)
            {
               this.mMatchedProcessableNode.DoActionOrGetValue();
               this.endCellModification(true);
            }
         }
         else
         {
            this.mMatchedProcessableNode.DoActionOrGetValue();
            this.endCellModification(true);
         }
         this.mLastMatchIsManual = true;
      }
      
      private function GemMatchConditionMet(param1:ScoreData) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Match = null;
         var _loc4_:Gem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this.mProcessOnManualMatchOnly)
         {
            if(this.mLastMatchIsManual)
            {
               _loc2_ = mBlitzLogic.frameMatches.length;
               _loc3_ = null;
               _loc4_ = null;
               if(_loc2_ > 0)
               {
                  _loc3_ = mBlitzLogic.frameMatches[0];
                  _loc5_ = _loc3_.matchGems.length;
                  _loc6_ = 0;
                  while(_loc6_ < _loc5_)
                  {
                     _loc4_ = _loc3_.matchGems[_loc6_];
                     if(mBlitzLogic.GetScoreKeeper().IsHighlightedGem(_loc4_) != null)
                     {
                        return true;
                     }
                     _loc6_++;
                  }
               }
            }
            return false;
         }
         return param1.cellInfo != null;
      }
      
      public function HandleSwapBegin(param1:SwapData) : void
      {
      }
      
      public function HandleSwapComplete(param1:SwapData) : void
      {
      }
      
      public function HandleLastSuccessfulSwapComplete(param1:SwapData) : void
      {
         this.mLastMatchIsManual = true;
      }
      
      public function HandleSwapCancel(param1:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlast(param1:Gem) : void
      {
      }
      
      public function HandleBoostFeedback(param1:String, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleBoostFeedbackQueue(param1:Vector.<ActionQueue>) : void
      {
      }
      
      public function HandleBoostFeedbackComplete(param1:ActionQueue) : void
      {
      }
      
      public function HandleBoostActivated(param1:String) : void
      {
      }
      
      public function HandleBoostActivationFailed(param1:String) : void
      {
      }
      
      public function HandleMoveSuccessful(param1:String, param2:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlastUpdate(param1:String) : void
      {
      }
      
      public function HandleBoostGameTimeChange(param1:String, param2:int) : void
      {
      }
      
      public function HandleMultiplierBonus(param1:int) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function BoardCellsActivate(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
      }
      
      public function BoardCellsDeactivate(param1:String, param2:Boolean) : void
      {
      }
      
      public function ForceStateChange(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:Number, param7:Number) : void
      {
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(this.mWaitToProc)
         {
            this.DoAction();
         }
      }
   }
}
