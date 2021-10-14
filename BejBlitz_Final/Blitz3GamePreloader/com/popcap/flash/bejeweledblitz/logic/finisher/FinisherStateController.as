package com.popcap.flash.bejeweledblitz.logic.finisher
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherConfigState;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherActor;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherAnimHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.finisher.modifier.GemModifierManager;
   import com.popcap.flash.bejeweledblitz.logic.finisher.modifier.IGemModifier;
   import com.popcap.flash.bejeweledblitz.logic.finisher.picker.GemPickerManager;
   import com.popcap.flash.bejeweledblitz.logic.finisher.picker.IGemPicker;
   import com.popcap.flash.bejeweledblitz.logic.finisher.stream.GemStream;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class FinisherStateController implements IFinisherAnimHandler
   {
      
      private static const STATE_INTRO:int = 0;
      
      private static const STATE_ACTION:int = 1;
      
      private static const STATE_EXIT:int = 2;
       
      
      private var stream:GemStream = null;
      
      private var gemModifier:IGemModifier = null;
      
      private var gemPicker:IGemPicker = null;
      
      private var propCreationRate:Number;
      
      private var time:Number;
      
      private var numProps:int;
      
      private var propSpeed:Number;
      
      private var iteration:int;
      
      private var actor:IFinisherActor = null;
      
      private var currentIteration:int;
      
      private var state:int = -1;
      
      private var config:IFinisherConfigState;
      
      private var animationsAreComplete:Boolean = false;
      
      private var gemPickerManager:GemPickerManager = null;
      
      private var gemModifierManager:GemModifierManager = null;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      private var animationCompleteEventType:int = -1;
      
      public function FinisherStateController(param1:IFinisherUI, param2:BlitzLogic, param3:IFinisherActor, param4:IFinisherConfigState)
      {
         super();
         this.actor = param3;
         this.finisherUIInterface = param1;
         this.currentIteration = 0;
         this.finisherUIInterface.AddActorAnimationCompleteHandler(this);
         this.Initilize(param2,param4);
      }
      
      public function Initilize(param1:BlitzLogic, param2:IFinisherConfigState) : void
      {
         this.gemModifierManager = new GemModifierManager();
         this.gemPickerManager = new GemPickerManager();
         this.gemModifier = this.gemModifierManager.Create(param1,param2.GetGemModifierType());
         var _loc3_:Vector.<GemData> = param2.GetGemModifierConfig();
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this.gemModifier.AddGemData(new GemData(_loc3_[_loc5_].gem_type,_loc3_[_loc5_].gem_weight));
            _loc5_++;
         }
         this.gemPicker = this.gemPickerManager.Create(param1,param2);
         var _loc6_:Vector.<Vector.<String>>;
         var _loc7_:int = (_loc6_ = param2.GetGemPickerConfig()).length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            this.gemPicker.addPattern(_loc6_[_loc8_]);
            _loc8_++;
         }
         this.gemPicker.PostAddingPattern();
         if(this.gemPicker != null)
         {
            this.stream = new GemStream(this.gemPicker);
         }
         this.numProps = param2.GetNumProps();
         this.propSpeed = param2.GetPropSpeed();
         this.propCreationRate = param2.GetPropsCreationRate();
         this.iteration = param2.GetIteration();
         this.time = this.propCreationRate;
         this.config = param2;
         this.state = STATE_INTRO;
         this.finisherUIInterface.playActor(this.config.GetIntroFrameStart(),this.config.GetIntroFrameEnd(),FinisherActor.FINISHER_ACTOR_ANIM_STATE_INTRO);
      }
      
      public function Update(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Gem = null;
         if(this.animationsAreComplete)
         {
            return;
         }
         if(this.animationCompleteEventType != -1)
         {
            if(this.animationCompleteEventType == FinisherActor.FINISHER_ACTOR_ANIM_STATE_INTRO || this.animationCompleteEventType == FinisherActor.FINISHER_ACTOR_ANIM_STATE_ACTION)
            {
               this.OnAnimationCompleted();
            }
            else if(this.animationCompleteEventType == FinisherActor.FINISHER_ACTOR_ANIM_STATE_EXIT)
            {
               this.AllAnimationsAreComplete();
            }
            this.animationCompleteEventType = -1;
         }
         if(this.state != STATE_ACTION)
         {
            return;
         }
         if(this.stream != null)
         {
            this.stream.Update();
         }
         this.time += param1;
         if(this.stream == null)
         {
            return;
         }
         if(this.time >= this.propCreationRate)
         {
            _loc2_ = 0;
            while(_loc2_ < this.numProps)
            {
               _loc3_ = this.stream.GetGem();
               this.actor.CreateProp(_loc3_,this.propSpeed);
               _loc2_++;
            }
            this.time = 0;
         }
      }
      
      private function getStateName(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "INTRO";
            case 1:
               return "ACTION";
            case 2:
               return "EXIT";
            default:
               return "NONE";
         }
      }
      
      public function OnAnimationCompleted() : void
      {
         if(this.state == STATE_INTRO)
         {
            this.state = STATE_ACTION;
         }
         if(this.state == STATE_ACTION)
         {
            if(this.currentIteration < this.iteration)
            {
               this.finisherUIInterface.playActor(this.config.GetActionFrameStart(),this.config.GetActionFrameEnd(),FinisherActor.FINISHER_ACTOR_ANIM_STATE_ACTION);
               this.currentIteration += 1;
               return;
            }
            this.currentIteration = 0;
            this.state = STATE_EXIT;
         }
         if(this.state == STATE_EXIT)
         {
            this.finisherUIInterface.playActor(this.config.GetEndFrameStart(),this.config.GetEndFrameEnd(),FinisherActor.FINISHER_ACTOR_ANIM_STATE_EXIT);
         }
      }
      
      private function AllAnimationsAreComplete() : void
      {
         this.animationsAreComplete = true;
      }
      
      public function IsCompleted() : Boolean
      {
         return this.animationsAreComplete;
      }
      
      public function ModifyGem(param1:Gem) : void
      {
         if(this.gemModifier != null)
         {
            this.gemModifier.ConvertGem(param1);
         }
      }
      
      public function AnimationCompleted(param1:int) : void
      {
         if(param1 == FinisherActor.FINISHER_ACTOR_ANIM_STATE_EXIT)
         {
            this.AllAnimationsAreComplete();
            this.animationCompleteEventType = -1;
         }
         else
         {
            this.animationCompleteEventType = param1;
         }
      }
      
      public function RemoveListeners() : void
      {
         this.finisherUIInterface.RemoveActorAnimationCompleteHandler(this);
         if(this.gemModifierManager != null)
         {
            this.gemModifierManager.Release();
            this.gemModifierManager = null;
         }
         if(this.gemPickerManager != null)
         {
            this.gemPickerManager.Release();
            this.gemPickerManager = null;
         }
      }
   }
}
