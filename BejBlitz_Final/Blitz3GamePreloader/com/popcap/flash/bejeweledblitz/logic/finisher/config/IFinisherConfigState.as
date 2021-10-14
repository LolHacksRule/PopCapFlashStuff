package com.popcap.flash.bejeweledblitz.logic.finisher.config
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.GemData;
   
   public interface IFinisherConfigState
   {
       
      
      function GetIntroFrame() : String;
      
      function GetActionFrame() : String;
      
      function GetEndFrame() : String;
      
      function GetIntroFrameStart() : int;
      
      function GetIntroFrameEnd() : int;
      
      function GetActionFrameStart() : int;
      
      function GetActionFrameEnd() : int;
      
      function GetEndFrameStart() : int;
      
      function GetEndFrameEnd() : int;
      
      function GetGemPickerType() : int;
      
      function GetGemPickerConfig() : Vector.<Vector.<String>>;
      
      function GetGemModifierType() : int;
      
      function GetGemModifierConfig() : Vector.<GemData>;
      
      function GetNumProps() : int;
      
      function GetPropsCreationRate() : int;
      
      function GetIteration() : int;
      
      function GetPropSpeed() : int;
      
      function GetCustomPatternType() : int;
   }
}
