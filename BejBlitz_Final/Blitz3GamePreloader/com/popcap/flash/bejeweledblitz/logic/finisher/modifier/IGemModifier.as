package com.popcap.flash.bejeweledblitz.logic.finisher.modifier
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.finisher.GemData;
   
   public interface IGemModifier
   {
       
      
      function AddGemData(param1:GemData) : void;
      
      function ConvertGem(param1:Gem) : void;
      
      function GetName() : String;
      
      function Release() : void;
   }
}
