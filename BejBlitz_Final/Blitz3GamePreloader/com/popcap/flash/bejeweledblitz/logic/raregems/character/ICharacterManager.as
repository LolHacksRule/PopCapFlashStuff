package com.popcap.flash.bejeweledblitz.logic.raregems.character
{
   public interface ICharacterManager
   {
       
      
      function CanShowCharacter() : Boolean;
      
      function IsValid() : Boolean;
      
      function ShowCharacter() : void;
      
      function Setup() : void;
      
      function Disable() : void;
      
      function GetPercentage() : int;
      
      function IsPlyingOnScreen() : Boolean;
      
      function ShouldShowProgress() : Boolean;
      
      function Update() : void;
      
      function GetCharacterConfig() : ICharacterConfig;
   }
}
