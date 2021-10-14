package com.popcap.flash.bejeweledblitz.logic.finisher
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherConfig;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherConfigState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherFrame;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherActor;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherAnimHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class FinisherActor implements IFinisherActor, IFinisherAnimHandler
   {
      
      public static const FINISHER_ACTOR_ANIM_GLOBAL_INTRO:int = 0;
      
      public static const FINISHER_ACTOR_ANIM_GLOBAL_EXIT:int = 1;
      
      public static const FINISHER_ACTOR_ANIM_STATE_INTRO:int = 2;
      
      public static const FINISHER_ACTOR_ANIM_STATE_ACTION:int = 3;
      
      public static const FINISHER_ACTOR_ANIM_STATE_EXIT:int = 4;
      
      public static const FINISHER_ACTOR_ANIM_SHOW:int = 5;
       
      
      private var logic:BlitzLogic = null;
      
      private var activeProps:Vector.<FinisherProp>;
      
      private var propsToRemove:Vector.<FinisherProp>;
      
      private var propGemsVec:Vector.<int>;
      
      private var config:IFinisherConfig;
      
      private var maxStates:int;
      
      private var currentState:int;
      
      private var iteration:int;
      
      private var currentIteration:int;
      
      private var introFrame:IFinisherFrame;
      
      private var exitFrame:IFinisherFrame;
      
      private var isPropVisible:Boolean;
      
      private var gemToCreate:Gem = null;
      
      private var speedForNewGem:Number = 0;
      
      private var animationCompleteEventType:int = -1;
      
      private var playingExitAnimation:Boolean = false;
      
      private var _animationIsComplete:Boolean = false;
      
      private var controller:FinisherStateController;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      public function FinisherActor(param1:IFinisherUI, param2:BlitzLogic, param3:IFinisherConfig)
      {
         super();
         this.finisherUIInterface = param1;
         this.logic = param2;
         this.config = param3;
         this.config.SelectNextAnimation();
         this.activeProps = new Vector.<FinisherProp>();
         this.propsToRemove = new Vector.<FinisherProp>();
         this.propGemsVec = new Vector.<int>();
         this.maxStates = this.config.GetNumfinisherState();
         this.iteration = this.config.GetLoopState();
         this.introFrame = this.config.GetIntroFrame();
         this.exitFrame = this.config.GetExitFrame();
         this.isPropVisible = this.config.GetPropVisibility();
         this.currentState = 0;
         this.currentIteration = 0;
         this.controller = null;
      }
      
      private function UpdateConfig() : void
      {
         this.finisherUIInterface.setCurrentStateId(this.currentState);
         var _loc1_:IFinisherConfigState = this.config.GetStateAt(this.currentState++);
         if(this.controller != null)
         {
            this.controller.RemoveListeners();
            this.controller = null;
         }
         this.controller = new FinisherStateController(this.finisherUIInterface,this.logic,this,_loc1_);
      }
      
      public function AddToStage() : void
      {
         this.finisherUIInterface.showActor();
         this.finisherUIInterface.AddActorAnimationCompleteHandler(this);
         this.finisherUIInterface.playActor(this.introFrame.GetStart(),this.introFrame.GetEnd(),FINISHER_ACTOR_ANIM_GLOBAL_INTRO);
      }
      
      public function CleanUp() : void
      {
         this.finisherUIInterface.RemoveActorAnimationCompleteHandler(this);
      }
      
      private function FinishedExitAnimation() : void
      {
         this._animationIsComplete = true;
         this.RemoveFromStage();
      }
      
      public function RemoveFromStage() : void
      {
         this.finisherUIInterface.hideActor();
         this.RemoveInActiveProps();
         this.RemoveProps();
      }
      
      public function RemoveProps() : void
      {
         while(this.activeProps.length > 0)
         {
            (this.activeProps.pop() as FinisherProp).RemoveProp();
         }
      }
      
      public function RemoveInActiveProps() : void
      {
         var _loc1_:Number = NaN;
         while(this.propsToRemove.length > 0)
         {
            _loc1_ = this.activeProps.indexOf(this.propsToRemove.pop() as FinisherProp);
            this.activeProps.splice(_loc1_,1);
         }
      }
      
      public function Update(param1:Number) : void
      {
         this.UpdateProps(param1);
         if(this.animationCompleteEventType != -1)
         {
            this.doActionsAsPerAnimationCompleteEvent();
         }
         if(this.controller != null && this.controller.IsCompleted() && !this.playingExitAnimation)
         {
            if(this.currentState < this.maxStates)
            {
               this.UpdateConfig();
            }
            else if(this.currentIteration < this.iteration - 1)
            {
               ++this.currentIteration;
               this.currentState = 0;
               this.UpdateConfig();
            }
            else
            {
               this.RemoveProps();
               this.finisherUIInterface.playActor(this.exitFrame.GetStart(),this.exitFrame.GetEnd(),FINISHER_ACTOR_ANIM_GLOBAL_EXIT);
               this.playingExitAnimation = true;
            }
         }
         else
         {
            if(this.controller != null)
            {
               this.controller.Update(param1);
            }
            this.finisherUIInterface.updateActor();
         }
      }
      
      public function UpdateProps(param1:Number) : void
      {
         var _loc2_:FinisherProp = null;
         var _loc3_:FinisherProp = null;
         this.RemoveInActiveProps();
         if(this.gemToCreate != null && this.speedForNewGem > 0)
         {
            _loc3_ = this.finisherUIInterface.generateProp(this,this.gemToCreate,this.speedForNewGem,this.isPropVisible);
            if(_loc3_ != null)
            {
               this.activeProps.push(_loc3_);
            }
            this.gemToCreate = null;
            this.speedForNewGem = 0;
         }
         for each(_loc2_ in this.activeProps)
         {
            _loc2_.Update(param1);
         }
      }
      
      public function CreateProp(param1:Gem, param2:Number) : void
      {
         if(param1 != null && this.propGemsVec.indexOf(param1.id) == -1)
         {
            this.gemToCreate = param1;
            this.speedForNewGem = param2;
            this.propGemsVec.push(param1.id);
         }
      }
      
      public function OnCollide(param1:FinisherProp) : void
      {
         param1.RemoveProp();
         if(param1.GetGem().CanSelect())
         {
            this.controller.ModifyGem(param1.GetGem());
         }
         this.propsToRemove.push(param1);
      }
      
      public function IsCompleted() : Boolean
      {
         return this._animationIsComplete;
      }
      
      public function AnimationCompleted(param1:int) : void
      {
         this.animationCompleteEventType = param1;
      }
      
      private function doActionsAsPerAnimationCompleteEvent() : void
      {
         if(this.animationCompleteEventType == FINISHER_ACTOR_ANIM_GLOBAL_INTRO)
         {
            this.UpdateConfig();
         }
         else if(this.animationCompleteEventType == FINISHER_ACTOR_ANIM_GLOBAL_EXIT)
         {
            this.FinishedExitAnimation();
         }
         this.animationCompleteEventType = -1;
      }
   }
}
