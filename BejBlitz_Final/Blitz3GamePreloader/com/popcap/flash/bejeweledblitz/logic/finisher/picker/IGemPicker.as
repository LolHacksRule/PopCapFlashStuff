package com.popcap.flash.bejeweledblitz.logic.finisher.picker
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public interface IGemPicker
   {
       
      
      function addPattern(param1:Vector.<String>) : void;
      
      function GetGem() : Gem;
      
      function GetName() : String;
      
      function PostAddingPattern() : void;
      
      function Release() : void;
   }
}
