package com.popcap.flash.bejeweledblitz.logic.boostV2
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicEventHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.BooleanDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterHolderNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import flash.utils.Dictionary;
   
   public class BoostV2 implements ITimerLogicTimeChangeHandler, IBlitzLogicHandler, IBlitzLogicSpawnHandler, IBlitzLogicEventHandler
   {
      
      public static const EVENT_CLICK:String = "Click";
      
      public static const EVENT_GEMSPAWN:String = "GemSpawn";
      
      public static const EVENT_TIMETICK:String = "TimeTick";
      
      public static const EVENT_GAMEEND:String = "GameEnd";
      
      public static const EVENT_GAMEBEGIN:String = "GameBegin";
      
      public static const EVENT_MATCH:String = "Match";
      
      public static const EVENT_SPECIALGEMBLAST:String = "SpecialGemBlast";
      
      public static const TARGETTYPE_CELL:String = "Cell";
      
      public static const TARGETTYPE_GEM:String = "Gem";
       
      
      protected var mId:String = "";
      
      protected var mName:String = "";
      
      protected var mDescription:String = "";
      
      protected var mInGameFeedback:String = "";
      
      protected var mIsEnabled:Boolean = false;
      
      protected var mTargetType:String = "Gem";
      
      protected var mParameters:Vector.<ParameterHolderNode> = null;
      
      protected var mComputes:Dictionary;
      
      protected var mActivations:Dictionary;
      
      protected var mUpgrades:Vector.<Vector.<ActionNode>> = null;
      
      protected var mBlitzLogic:BlitzLogic = null;
      
      protected var mBoostLogic:BoostV2Logic = null;
      
      protected var mActions:Vector.<ActionNode> = null;
      
      protected var mParticleFeedbackTime:Number = 0;
      
      protected var mIsClassic:Boolean = false;
      
      protected var mClickCount:int = 0;
      
      protected var mTriggerCount:int = 0;
      
      protected var mUpgradeLevel:int = 0;
      
      protected var mHandlers:Vector.<IBoostV2Handler> = null;
      
      protected var mLastSwapData:SwapData = null;
      
      protected var mIsBlockingEventImmuned:Boolean = false;
      
      public function BoostV2(param1:BlitzLogic)
      {
         super();
         this.mBlitzLogic = param1;
         this.mBoostLogic = this.mBlitzLogic.boostLogicV2;
         this.mParameters = new Vector.<ParameterHolderNode>();
         this.mActions = new Vector.<ActionNode>();
         this.mComputes = new Dictionary();
         this.mActivations = new Dictionary();
         this.mUpgrades = new Vector.<Vector.<ActionNode>>();
         this.mHandlers = new Vector.<IBoostV2Handler>();
      }
      
      public function getId() : String
      {
         return this.mId;
      }
      
      public function getClickCount() : int
      {
         return this.mClickCount;
      }
      
      public function getTriggerCount() : int
      {
         return this.mTriggerCount;
      }
      
      public function InitWithLevel(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.mUpgradeLevel = param1 - 1;
         var _loc2_:int = 0;
         if(this.mUpgradeLevel >= 0 && this.mUpgradeLevel <= this.mUpgrades.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this.mUpgradeLevel)
            {
               _loc2_ = this.mUpgrades[_loc3_].length;
               _loc4_ = 0;
               while(_loc4_ < _loc2_)
               {
                  this.mUpgrades[_loc3_][_loc4_].DoAction();
                  _loc4_++;
               }
               _loc3_++;
            }
         }
      }
      
      public function GetUpgradeLevel() : int
      {
         return this.mUpgradeLevel;
      }
      
      private function performEvents(param1:String) : void
      {
         if(param1 != EVENT_GAMEBEGIN && !this.mIsBlockingEventImmuned && !this.mIsEnabled)
         {
            return;
         }
         this.doCompute(param1);
         this.checkForActivation(param1);
      }
      
      public function doCompute(param1:String) : void
      {
         var _loc5_:ParameterNode = null;
         if(!(param1 in this.mComputes))
         {
            return;
         }
         var _loc2_:Vector.<ActionNode> = this.mComputes[param1];
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_].SetId(this.getId());
            if((_loc5_ = _loc2_[_loc4_].DoActionOrGetValue()) != null && _loc5_ as BooleanDataTypeNode != null && (_loc5_ as BooleanDataTypeNode).dataValue == false)
            {
               return;
            }
            _loc4_++;
         }
      }
      
      public function checkForActivation(param1:String) : Boolean
      {
         var _loc2_:Boolean = this.performActivationChecks(param1);
         if(_loc2_)
         {
            if(!this.mBlitzLogic.mIsReplay)
            {
               this.performActions(param1);
            }
         }
         else
         {
            this.DispatchBoostActivationFailed(this.getId());
         }
         return _loc2_;
      }
      
      public function performActivationChecks(param1:String) : Boolean
      {
         var _loc5_:ParameterNode = null;
         if(!(param1 in this.mActivations))
         {
            return false;
         }
         var _loc2_:Vector.<ActionNode> = this.mActivations[param1];
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = _loc2_[_loc4_].DoActionOrGetValue()) == null)
            {
               return false;
            }
            if(_loc5_ as BooleanDataTypeNode == null)
            {
               return false;
            }
            if(!(_loc5_ as BooleanDataTypeNode).dataValue)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function performActions(param1:String) : void
      {
         if(!this.mBlitzLogic.mIsReplay)
         {
            this.mBlitzLogic.QueueBoostActivatedCommand(this.mId,param1);
         }
         else if(param1 == BoostV2.EVENT_CLICK)
         {
            this.HandleClickEvent(this.mId);
         }
         ++this.mTriggerCount;
         this.DispatchBoostActivated(this.mId);
         var _loc2_:int = this.mActions.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.mActions[_loc3_].SetId(this.getId());
            this.mActions[_loc3_].DoActionOrGetValue();
            _loc3_++;
         }
         if(param1 == BoostV2.EVENT_MATCH)
         {
            this.DispatchMoveSuccessful(this.mLastSwapData);
         }
         if(param1 == BoostV2.EVENT_SPECIALGEMBLAST)
         {
            this.DispatchSpecialGemBlastUpdate();
         }
      }
      
      public function DoCleanUp() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<ActionNode> = null;
         var _loc1_:int = 0;
         for(_loc2_ in this.mComputes)
         {
            _loc1_ = (_loc4_ = this.mComputes[_loc2_]).length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc4_[_loc3_].SetId(this.getId());
               _loc4_[_loc3_].DoCleanUp();
               _loc3_++;
            }
         }
         _loc1_ = this.mActions.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            this.mActions[_loc3_].SetId(this.getId());
            this.mActions[_loc3_].DoCleanUp();
            _loc3_++;
         }
      }
      
      public function usesEventOfType(param1:String) : Boolean
      {
         return param1 in this.mComputes || param1 in this.mActivations;
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         this.performEvents(EVENT_TIMETICK);
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this.performEvents(EVENT_GAMEBEGIN);
      }
      
      public function HandleGameEnd() : void
      {
         this.performEvents(EVENT_GAMEEND);
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
         this.DispatchBlockingEventAdded();
      }
      
      public function HandleLogicSpawnPhaseBegin() : void
      {
      }
      
      public function HandleLogicSpawnPhaseEnd() : void
      {
      }
      
      public function HandlePostLogicSpawnPhase() : void
      {
      }
      
      public function HandleClickEvent(param1:String) : void
      {
         if(!this.usesEventOfType(EVENT_CLICK))
         {
            return;
         }
         if(param1 == this.getId())
         {
            ++this.mClickCount;
            this.performEvents(EVENT_CLICK);
         }
      }
      
      public function HandleSwapBegin(param1:SwapData) : void
      {
      }
      
      public function HandleSwapComplete(param1:SwapData) : void
      {
      }
      
      public function HandleLastSuccessfulSwapComplete(param1:SwapData) : void
      {
         if(param1.moveData.isSuccessful)
         {
            this.mLastSwapData = param1;
            this.performEvents(EVENT_MATCH);
         }
      }
      
      public function HasHandler(param1:IBoostV2Handler) : Boolean
      {
         var _loc2_:int = this.mHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return false;
         }
         return true;
      }
      
      public function AddHandler(param1:IBoostV2Handler) : void
      {
         this.mHandlers.push(param1);
      }
      
      public function RemoveHandler(param1:IBoostV2Handler) : void
      {
         if(!this.HasHandler(param1))
         {
            return;
         }
         this.mHandlers.splice(this.mHandlers.indexOf(param1),1);
      }
      
      public function RemoveAllHandlers() : void
      {
         this.mHandlers.length = 0;
      }
      
      public function DispatchBoostActivated(param1:String) : void
      {
         var _loc2_:IBoostV2Handler = null;
         for each(_loc2_ in this.mHandlers)
         {
            _loc2_.HandleBoostActivated(param1);
         }
      }
      
      public function DispatchBoostFeedback(param1:String, param2:Vector.<Gem>) : void
      {
         var _loc3_:IBoostV2Handler = null;
         for each(_loc3_ in this.mHandlers)
         {
            _loc3_.HandleBoostFeedback(param1,param2);
         }
      }
      
      public function DispatchBoostFeedbackQueue(param1:Vector.<ActionQueue>) : void
      {
         var _loc2_:IBoostV2Handler = null;
         for each(_loc2_ in this.mHandlers)
         {
            _loc2_.HandleBoostFeedbackQueue(param1);
         }
      }
      
      public function DispatchBoostFeedbackComplete(param1:ActionQueue) : void
      {
         var _loc2_:IBoostV2Handler = null;
         for each(_loc2_ in this.mHandlers)
         {
            _loc2_.HandleBoostFeedbackComplete(param1);
         }
      }
      
      public function DispatchBoostActivationFailed(param1:String) : void
      {
         var _loc2_:IBoostV2Handler = null;
         for each(_loc2_ in this.mHandlers)
         {
            _loc2_.HandleBoostActivationFailed(param1);
         }
      }
      
      public function DispatchMoveSuccessful(param1:SwapData) : void
      {
         var _loc2_:IBoostV2Handler = null;
         for each(_loc2_ in this.mHandlers)
         {
            _loc2_.HandleMoveSuccessful(this.getId(),param1);
         }
      }
      
      public function DispatchSpecialGemBlastUpdate() : void
      {
         var _loc1_:IBoostV2Handler = null;
         for each(_loc1_ in this.mHandlers)
         {
            _loc1_.HandleSpecialGemBlastUpdate(this.getId());
         }
      }
      
      public function DispatchGameTimeChange(param1:int) : void
      {
         var _loc2_:IBoostV2Handler = null;
         for each(_loc2_ in this.mHandlers)
         {
            _loc2_.HandleBoostGameTimeChange(this.getId(),param1);
         }
      }
      
      public function DispatchBlockingEventAdded() : void
      {
         var _loc1_:IBoostV2Handler = null;
         for each(_loc1_ in this.mHandlers)
         {
            _loc1_.HandleBlockingEvent();
         }
      }
      
      public function DispatchMultiplierBonus(param1:int) : void
      {
         var _loc2_:IBoostV2Handler = null;
         for each(_loc2_ in this.mHandlers)
         {
            _loc2_.HandleMultiplierBonus(param1);
         }
      }
      
      public function SetEnabled(param1:Boolean) : void
      {
         this.mIsEnabled = param1;
      }
      
      public function IsEnabled() : Boolean
      {
         return this.mIsEnabled;
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
      
      public function HandleSwapCancel(param1:SwapData) : void
      {
      }
      
      public function HandleSpecialGemBlast(param1:Gem) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ParameterNode = null;
         var _loc4_:ParameterNode = null;
         var _loc5_:Boolean = false;
         var _loc6_:Vector.<ActionQueue> = null;
         var _loc7_:BooleanDataTypeNode = null;
         var _loc8_:int = 0;
         if(!this.mBlitzLogic.lastHurrahLogic.IsRunning() && !this.mBlitzLogic.timerLogic.IsDone())
         {
            _loc2_ = 0;
            while(_loc2_ < this.mParameters.length)
            {
               _loc3_ = this.mParameters[_loc2_];
               if(_loc3_.GetName() == "isRGIncluded")
               {
                  if((_loc4_ = _loc3_.GetValue()) == null)
                  {
                     return;
                  }
                  if((_loc7_ = _loc4_ as BooleanDataTypeNode) == null)
                  {
                     return;
                  }
                  _loc5_ = _loc7_.dataValue;
                  (_loc6_ = new Vector.<ActionQueue>()).push(new ActionQueue(null,ActionQueue.SHOW_CROSSCOLLECTOR_FEEDBACK,1,0));
                  if(_loc5_ || !this.mBlitzLogic.rareGemsLogic.hasCurrentRareGem())
                  {
                     this.performEvents(BoostV2.EVENT_SPECIALGEMBLAST);
                     this.mBlitzLogic.boostLogicV2.mBoostMap[this.mId].DispatchBoostFeedbackQueue(_loc6_);
                  }
                  else
                  {
                     _loc8_ = this.mBlitzLogic.rareGemsLogic.currentRareGem.getFlameColor();
                     if(param1.color == _loc8_ && param1.type != Gem.TYPE_FLAME)
                     {
                        this.performEvents(BoostV2.EVENT_SPECIALGEMBLAST);
                        this.mBlitzLogic.boostLogicV2.mBoostMap[this.mId].DispatchBoostFeedbackQueue(_loc6_);
                     }
                     else if(param1.color != _loc8_)
                     {
                        this.performEvents(BoostV2.EVENT_SPECIALGEMBLAST);
                        this.mBlitzLogic.boostLogicV2.mBoostMap[this.mId].DispatchBoostFeedbackQueue(_loc6_);
                     }
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public function DispatchBoardCellsActivate(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:IBoostV2Handler = null;
         for each(_loc7_ in this.mHandlers)
         {
            _loc7_.BoardCellsActivate(param1,param2,param3,param4,param5,param6);
         }
      }
      
      public function DispatchBoardCellsDeactivate(param1:String, param2:Boolean) : void
      {
         var _loc3_:IBoostV2Handler = null;
         for each(_loc3_ in this.mHandlers)
         {
            _loc3_.BoardCellsDeactivate(param1,param2);
         }
      }
      
      public function IsTargetType(param1:String) : Boolean
      {
         return this.mTargetType == param1;
      }
      
      public function SetTargetType(param1:String) : void
      {
         this.mTargetType = param1;
      }
      
      public function SetBlockingEventImmuned(param1:Boolean) : void
      {
         this.mIsBlockingEventImmuned = param1;
      }
      
      public function IsBlockingEventImmuned() : Boolean
      {
         return this.mIsBlockingEventImmuned;
      }
   }
}
