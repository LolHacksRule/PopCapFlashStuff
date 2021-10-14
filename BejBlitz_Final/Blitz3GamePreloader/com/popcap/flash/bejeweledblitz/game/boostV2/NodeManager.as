package com.popcap.flash.bejeweledblitz.game.boostV2
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionAddExtraTimeAtGameEndNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionAddNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionAndNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionBlockingEventImmunityNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionConvertRandomGemNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionDecreaseScoreDeltaDuringGameNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionDecrementByNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionDetonatableGemCountNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionDetonateGemsNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionDivideNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionEqualToNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionForceUIStateChangeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionGetEquipedRareGemNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionGreaterEqualToNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionGreaterThanNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionHideBlazingSpeedFeedbackNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionIncreaseBlazingSpeedNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionIncreaseMultiplierNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionIncreaseMultiplierPermanentNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionIncreaseScoreDeltaDuringGameNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionIncreaseScoreDeltaNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionIncreaseSpecialGemBonusNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionIncrementByNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionLessEqualToNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionLessThanNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionModifyCellPropertiesNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionModulusNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionMultiplyNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionNotEqualToNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionOrNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionPerformUnscrambleNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionRandomFloatNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionRandomIntNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionRandomizeBoardPatternPositionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionScrambleGemsNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionSetValueNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionShowBlazingSpeedFeedbackNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionStartBlazingSpeedForcefullyNode;
   import com.popcap.flash.bejeweledblitz.logic.node.actions.ActionSubtractNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class NodeManager
   {
      
      public static var mActions:Dictionary = null;
       
      
      public function NodeManager()
      {
         super();
         mActions = new Dictionary();
         this.RegisterAllSupportedActions();
      }
      
      public static function GetRegisteredActionByName(param1:String, param2:BlitzLogic) : ActionNode
      {
         var _loc3_:Class = null;
         if(mActions.hasOwnProperty(param1))
         {
            _loc3_ = mActions[param1];
            return new _loc3_(param2) as ActionNode;
         }
         throw new Error("Undefined Action Type " + param1);
      }
      
      public static function createActionFromName(param1:String, param2:String, param3:BlitzLogic) : ActionNode
      {
         var actionClass:Class = null;
         var instance:ActionNode = null;
         var packageName:String = param1;
         var className:String = param2;
         var logic:BlitzLogic = param3;
         var qualifiedClassName:String = packageName + "." + className + "Node";
         trace("Creating action " + qualifiedClassName);
         try
         {
            actionClass = getDefinitionByName(qualifiedClassName) as Class;
            instance = new actionClass(logic) as ActionNode;
            return instance;
         }
         catch(e:Error)
         {
            trace("Type Error -- " + e);
            return null;
         }
      }
      
      private function RegisterAllSupportedActions() : void
      {
         this.RegisterFunctionByString(ActionRandomIntNode.GetActionType(),ActionRandomIntNode);
         this.RegisterFunctionByString(ActionRandomFloatNode.GetActionType(),ActionRandomFloatNode);
         this.RegisterFunctionByString(ActionSetValueNode.GetActionType(),ActionSetValueNode);
         this.RegisterFunctionByString(ActionConvertRandomGemNode.GetActionType(),ActionConvertRandomGemNode);
         this.RegisterFunctionByString(ActionDetonateGemsNode.GetActionType(),ActionDetonateGemsNode);
         this.RegisterFunctionByString(ActionScrambleGemsNode.GetActionType(),ActionScrambleGemsNode);
         this.RegisterFunctionByString(ActionLessEqualToNode.GetActionType(),ActionLessEqualToNode);
         this.RegisterFunctionByString(ActionLessThanNode.GetActionType(),ActionLessThanNode);
         this.RegisterFunctionByString(ActionGreaterEqualToNode.GetActionType(),ActionGreaterEqualToNode);
         this.RegisterFunctionByString(ActionGreaterThanNode.GetActionType(),ActionGreaterThanNode);
         this.RegisterFunctionByString(ActionEqualToNode.GetActionType(),ActionEqualToNode);
         this.RegisterFunctionByString(ActionNotEqualToNode.GetActionType(),ActionNotEqualToNode);
         this.RegisterFunctionByString(ActionAddExtraTimeAtGameEndNode.GetActionType(),ActionAddExtraTimeAtGameEndNode);
         this.RegisterFunctionByString(ActionIncrementByNode.GetActionType(),ActionIncrementByNode);
         this.RegisterFunctionByString(ActionDecrementByNode.GetActionType(),ActionDecrementByNode);
         this.RegisterFunctionByString(ActionIncreaseMultiplierNode.GetActionType(),ActionIncreaseMultiplierNode);
         this.RegisterFunctionByString(ActionIncreaseBlazingSpeedNode.GetActionType(),ActionIncreaseBlazingSpeedNode);
         this.RegisterFunctionByString(ActionIncreaseScoreDeltaNode.GetActionType(),ActionIncreaseScoreDeltaNode);
         this.RegisterFunctionByString(ActionIncreaseSpecialGemBonusNode.GetActionType(),ActionIncreaseSpecialGemBonusNode);
         this.RegisterFunctionByString(ActionPerformUnscrambleNode.GetActionType(),ActionPerformUnscrambleNode);
         this.RegisterFunctionByString(ActionOrNode.GetActionType(),ActionOrNode);
         this.RegisterFunctionByString(ActionAndNode.GetActionType(),ActionAndNode);
         this.RegisterFunctionByString(ActionAddNode.GetActionType(),ActionAddNode);
         this.RegisterFunctionByString(ActionSubtractNode.GetActionType(),ActionSubtractNode);
         this.RegisterFunctionByString(ActionMultiplyNode.GetActionType(),ActionMultiplyNode);
         this.RegisterFunctionByString(ActionDivideNode.GetActionType(),ActionDivideNode);
         this.RegisterFunctionByString(ActionModulusNode.GetActionType(),ActionModulusNode);
         this.RegisterFunctionByString(ActionDetonatableGemCountNode.GetActionType(),ActionDetonatableGemCountNode);
         this.RegisterFunctionByString(ActionGetEquipedRareGemNode.GetActionType(),ActionGetEquipedRareGemNode);
         this.RegisterFunctionByString(ActionForceUIStateChangeNode.GetActionType(),ActionForceUIStateChangeNode);
         this.RegisterFunctionByString(ActionModifyCellPropertiesNode.GetActionType(),ActionModifyCellPropertiesNode);
         this.RegisterFunctionByString(ActionRandomizeBoardPatternPositionNode.GetActionType(),ActionRandomizeBoardPatternPositionNode);
         this.RegisterFunctionByString(ActionIncreaseScoreDeltaDuringGameNode.GetActionType(),ActionIncreaseScoreDeltaDuringGameNode);
         this.RegisterFunctionByString(ActionDecreaseScoreDeltaDuringGameNode.GetActionType(),ActionDecreaseScoreDeltaDuringGameNode);
         this.RegisterFunctionByString(ActionStartBlazingSpeedForcefullyNode.GetActionType(),ActionStartBlazingSpeedForcefullyNode);
         this.RegisterFunctionByString(ActionShowBlazingSpeedFeedbackNode.GetActionType(),ActionShowBlazingSpeedFeedbackNode);
         this.RegisterFunctionByString(ActionHideBlazingSpeedFeedbackNode.GetActionType(),ActionHideBlazingSpeedFeedbackNode);
         this.RegisterFunctionByString(ActionIncreaseMultiplierPermanentNode.GetActionType(),ActionIncreaseMultiplierPermanentNode);
         this.RegisterFunctionByString(ActionBlockingEventImmunityNode.GetActionType(),ActionBlockingEventImmunityNode);
      }
      
      public function RegisterFunctionByString(param1:String, param2:Class) : void
      {
         mActions[param1] = param2;
      }
   }
}
