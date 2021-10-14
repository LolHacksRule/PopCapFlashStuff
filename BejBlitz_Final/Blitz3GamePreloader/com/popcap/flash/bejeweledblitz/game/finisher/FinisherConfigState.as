package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.finisher.GemData;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.*;
   import com.popcap.flash.bejeweledblitz.logic.finisher.modifier.GemModifierManager;
   import com.popcap.flash.bejeweledblitz.logic.finisher.picker.CustomPickerManager;
   import com.popcap.flash.bejeweledblitz.logic.finisher.picker.GemPickerManager;
   import flash.utils.Dictionary;
   
   public class FinisherConfigState implements IFinisherConfigState
   {
       
      
      private var introFrame:String;
      
      private var actionFrame:String;
      
      private var exitFrame:String;
      
      private var introFrameStart:int;
      
      private var introFrameEnd:int;
      
      private var actionFrameStart:int;
      
      private var actionFrameEnd:int;
      
      private var exitFrameStart:int;
      
      private var exitFrameEnd:int;
      
      private var gemPicker:String;
      
      private var gemModifier:String;
      
      private var modifierConfig:Dictionary;
      
      private var numProps:int;
      
      private var propCreationRate:int;
      
      private var propSpeed:Number;
      
      private var gemPickerConfig:Dictionary;
      
      private var iteration:int;
      
      private var CustomPatternType:String;
      
      private var modifierConfigVec:Vector.<GemData>;
      
      private var pickerConfigVec:Vector.<Vector.<String>>;
      
      public function FinisherConfigState(param1:Object)
      {
         super();
         this.modifierConfigVec = new Vector.<GemData>();
         this.pickerConfigVec = new Vector.<Vector.<String>>();
         this.CustomPatternType = "";
         this.Parse(param1);
      }
      
      public function GetIntroFrame() : String
      {
         return this.introFrame;
      }
      
      public function GetIntroFrameStart() : int
      {
         return this.introFrameStart;
      }
      
      public function GetIntroFrameEnd() : int
      {
         return this.introFrameEnd;
      }
      
      public function GetActionFrame() : String
      {
         return this.actionFrame;
      }
      
      public function GetActionFrameStart() : int
      {
         return this.actionFrameStart;
      }
      
      public function GetActionFrameEnd() : int
      {
         return this.actionFrameEnd;
      }
      
      public function GetEndFrame() : String
      {
         return this.exitFrame;
      }
      
      public function GetEndFrameStart() : int
      {
         return this.exitFrameStart;
      }
      
      public function GetEndFrameEnd() : int
      {
         return this.exitFrameEnd;
      }
      
      public function GetGemPickerType() : int
      {
         if(this.gemPicker == "RandomGemPicker")
         {
            return GemPickerManager.GEMPICKER_RANDOM;
         }
         if(this.gemPicker == "PatternGemPicker")
         {
            return GemPickerManager.GEMPICKER_PATTERN;
         }
         if(this.gemPicker == "CustomGemPicker")
         {
            return GemPickerManager.GEMPICKER_CUSTOM;
         }
         return -1;
      }
      
      public function GetGemPickerConfig() : Vector.<Vector.<String>>
      {
         return this.pickerConfigVec;
      }
      
      public function GetGemModifierType() : int
      {
         if(this.gemModifier == "ExplodeGemModifier")
         {
            return GemModifierManager.GEMMODIFIER_EXPLODE;
         }
         if(this.gemModifier == "SpecialGemModifier")
         {
            return GemModifierManager.GEMMODIFIER_SPECIAL;
         }
         return -1;
      }
      
      public function GetGemModifierConfig() : Vector.<GemData>
      {
         if(this.modifierConfig["hyperCube"])
         {
            this.modifierConfigVec.push(new GemData(Gem.TYPE_HYPERCUBE,this.modifierConfig["hyperCube"]));
         }
         if(this.modifierConfig["flameGem"])
         {
            this.modifierConfigVec.push(new GemData(Gem.TYPE_FLAME,this.modifierConfig["flameGem"]));
         }
         if(this.modifierConfig["star"])
         {
            this.modifierConfigVec.push(new GemData(Gem.TYPE_STAR,this.modifierConfig["star"]));
         }
         if(this.modifierConfig["rareGem"])
         {
            this.modifierConfigVec.push(new GemData(Gem.TYPE_RAREGEM,this.modifierConfig["rareGem"]));
         }
         return this.modifierConfigVec;
      }
      
      public function GetNumProps() : int
      {
         return this.numProps;
      }
      
      public function GetPropsCreationRate() : int
      {
         return this.propCreationRate;
      }
      
      public function GetIteration() : int
      {
         return this.iteration;
      }
      
      public function GetPropSpeed() : int
      {
         return this.propSpeed;
      }
      
      public function GetCustomPatternType() : int
      {
         switch(this.CustomPatternType)
         {
            case "lefttoright":
               return CustomPickerManager.LEFTTORIGHT;
            case "righttoleft":
               return CustomPickerManager.RIGHTTOLEFT;
            case "toptobottom":
               return CustomPickerManager.TOPTOBOTTOM;
            case "bottomtotop":
               return CustomPickerManager.BOTTOMTOTOP;
            default:
               return CustomPickerManager.LEFTTORIGHT;
         }
      }
      
      private function Parse(param1:Object) : void
      {
         var _loc3_:Vector.<String> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         this.introFrame = Utils.getStringFromObjectKey(param1,"introFrame","");
         this.actionFrame = Utils.getStringFromObjectKey(param1,"actionFrame","");
         this.exitFrame = Utils.getStringFromObjectKey(param1,"exitFrame","");
         var _loc2_:Array = this.introFrame.split("-");
         this.introFrameStart = parseInt(_loc2_[0]);
         this.introFrameEnd = parseInt(_loc2_[1]);
         _loc2_ = this.actionFrame.split("-");
         this.actionFrameStart = parseInt(_loc2_[0]);
         this.actionFrameEnd = parseInt(_loc2_[1]);
         _loc2_ = this.exitFrame.split("-");
         this.exitFrameStart = parseInt(_loc2_[0]);
         this.exitFrameEnd = parseInt(_loc2_[1]);
         this.gemPicker = Utils.getStringFromObjectKey(param1.action.gemPicker,"type","");
         this.gemPickerConfig = Utils.getDictionaryFromObject(Utils.getObjectClone(param1.action.gemPicker.config));
         if(this.gemPickerConfig["CustomConfigType"] !== undefined)
         {
            _loc2_ = this.gemPickerConfig["pattern"];
            if(this.gemPickerConfig["CustomConfigType"] !== undefined)
            {
               this.CustomPatternType = this.gemPickerConfig["CustomConfigType"];
            }
            _loc3_ = null;
            _loc4_ = _loc2_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = (_loc2_[_loc6_] as String).split("");
               _loc3_ = new Vector.<String>();
               _loc5_ = _loc7_.length;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  _loc3_.push(_loc7_[_loc8_]);
                  _loc8_++;
               }
               this.pickerConfigVec.push(_loc3_);
               _loc6_++;
            }
         }
         this.gemModifier = Utils.getStringFromObjectKey(param1.action.gemModifier,"type","");
         this.modifierConfig = Utils.getDictionaryFromObject(Utils.getObjectClone(param1.action.gemModifier.config));
         this.numProps = Utils.getIntFromObjectKey(param1.action,"numProps",0);
         this.propCreationRate = Utils.getIntFromObjectKey(param1.action,"propCreationRate",0);
         this.propSpeed = Utils.getIntFromObjectKey(param1.action,"propSpeed",0);
         this.iteration = Utils.getIntFromObjectKey(param1.action,"iteration",0);
      }
   }
}
