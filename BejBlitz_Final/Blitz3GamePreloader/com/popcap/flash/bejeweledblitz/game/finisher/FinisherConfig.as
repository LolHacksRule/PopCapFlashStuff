package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.finisher.decision.DecisionManager;
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.*;
   
   public class FinisherConfig implements IFinisherConfig
   {
       
      
      private var id:String;
      
      private var assetId:String;
      
      private var label:String;
      
      private var isBlocking:Boolean;
      
      private var description:String;
      
      private var cost:FinisherCost;
      
      private var loopState:int;
      
      private var extraTime:int;
      
      private var sequence:String;
      
      private var showFinisher:Boolean;
      
      private var introFrame:FinisherFrame;
      
      private var exitFrame:FinisherFrame;
      
      private var animStates:Vector.<FinisherAnimState>;
      
      private var prePrestigeStates:Vector.<FinisherAnimState>;
      
      private var weight:Number;
      
      private var decision:DecisionManager;
      
      private var popupConfig:IFinisherPopupConfig;
      
      private var data:Object;
      
      private var currAnim:int;
      
      private var currAnimIndex:int;
      
      public function FinisherConfig(param1:Object)
      {
         super();
         this.currAnim = 0;
         this.currAnimIndex = 0;
         this.data = param1;
         this.Parse(param1);
      }
      
      public function GetID() : String
      {
         return this.id;
      }
      
      public function GetAssetID() : String
      {
         return this.assetId;
      }
      
      public function IsBlockingFinisher() : Boolean
      {
         return this.isBlocking;
      }
      
      public function GetIntroFrame() : IFinisherFrame
      {
         return this.animStates[this.currAnim].GetIntroFrame();
      }
      
      public function GetExitFrame() : IFinisherFrame
      {
         return this.animStates[this.currAnim].GetExitFrame();
      }
      
      public function GetLabel() : String
      {
         return this.label;
      }
      
      public function GetDescription() : String
      {
         return this.description;
      }
      
      public function GetLoopState() : int
      {
         return this.loopState;
      }
      
      public function GetExtraTime() : int
      {
         return this.extraTime;
      }
      
      public function ShouldShowFinisher() : Boolean
      {
         return this.GetWeight() > 0 && this.decision.CanShowFinisher();
      }
      
      public function AllowFinisher() : Boolean
      {
         return this.showFinisher;
      }
      
      public function GetNumfinisherState() : int
      {
         return this.animStates[this.currAnim].GetStates().length;
      }
      
      public function GetStateAt(param1:int) : IFinisherConfigState
      {
         return this.animStates[this.currAnim].GetStates()[param1];
      }
      
      public function GetPropVisibility() : Boolean
      {
         return this.animStates[this.currAnim].IsPropVisible();
      }
      
      public function GetWeight() : int
      {
         return this.weight;
      }
      
      public function GetCost() : ICost
      {
         return this.cost;
      }
      
      public function GetFinisherPopupConfig() : IFinisherPopupConfig
      {
         return this.popupConfig;
      }
      
      public function SelectNextAnimation() : void
      {
         var _loc1_:int = this.animStates.length;
         var _loc2_:int = this.sequence.length;
         if(_loc2_ != 0)
         {
            this.currAnimIndex = (this.currAnimIndex + 1) % _loc2_;
            this.currAnim = (this.sequence.charCodeAt(this.currAnimIndex) - 48) % _loc1_;
         }
         else
         {
            this.currAnim = Blitz3App.app.logic.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_FINISHER).Int(0,1000) % _loc1_;
         }
      }
      
      public function SetConfigForPrePrestige() : Boolean
      {
         if(this.prePrestigeStates.length == 0)
         {
            return false;
         }
         this.animStates = this.prePrestigeStates;
         this.currAnim = 0;
         return true;
      }
      
      public function ResetConfig() : void
      {
         this.Parse(this.data);
      }
      
      private function Parse(param1:Object) : void
      {
         var _loc2_:FinisherAnimState = null;
         var _loc4_:Object = null;
         this.id = Utils.getStringFromObjectKey(param1,"id","");
         this.assetId = Utils.getStringFromObjectKey(param1,"assetId",this.id);
         this.isBlocking = Utils.getBoolFromObjectKey(param1,"isBlocking");
         this.label = Utils.getStringFromObjectKey(param1,"label","");
         this.description = Utils.getStringFromObjectKey(param1,"description","");
         this.showFinisher = Utils.getBoolFromObjectKey(param1,"shouldShowFinisher",true);
         if(param1.popup)
         {
            this.popupConfig = new FinisherPopupConfig(param1.popup);
         }
         if(param1.cost)
         {
            this.cost = new FinisherCost(param1.cost);
         }
         this.loopState = Utils.getNumberFromObjectKey(param1,"loopState",0);
         this.extraTime = Utils.getNumberFromObjectKey(param1,"extraTime",0);
         this.weight = Utils.getNumberFromObjectKey(param1,"weight",0);
         this.sequence = Utils.getStringFromObjectKey(param1,"sequence","");
         if(param1.decision)
         {
            this.decision = new DecisionManager(param1.decision);
         }
         this.animStates = new Vector.<FinisherAnimState>();
         var _loc3_:int = 0;
         var _loc5_:Array;
         if((_loc5_ = Utils.getArrayFromObjectKey(param1,"animStates")) == null)
         {
            _loc2_ = new FinisherAnimState(param1);
            this.animStates.push(_loc2_);
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc5_.length)
            {
               _loc4_ = _loc5_[_loc3_];
               _loc2_ = new FinisherAnimState(_loc4_);
               this.animStates.push(_loc2_);
               _loc3_++;
            }
         }
         this.prePrestigeStates = new Vector.<FinisherAnimState>();
         var _loc6_:Array;
         if((_loc6_ = Utils.getArrayFromObjectKey(param1,"PreprestigeStates")) != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc6_.length)
            {
               _loc4_ = _loc6_[_loc3_];
               _loc2_ = new FinisherAnimState(_loc4_);
               this.prePrestigeStates.push(_loc2_);
               _loc3_++;
            }
         }
      }
   }
}
