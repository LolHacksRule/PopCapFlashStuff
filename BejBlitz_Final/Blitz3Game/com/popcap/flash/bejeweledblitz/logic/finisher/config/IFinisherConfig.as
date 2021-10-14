package com.popcap.flash.bejeweledblitz.logic.finisher.config
{
   public interface IFinisherConfig
   {
       
      
      function GetID() : String;
      
      function GetAssetID() : String;
      
      function IsBlockingFinisher() : Boolean;
      
      function GetIntroFrame() : IFinisherFrame;
      
      function GetExitFrame() : IFinisherFrame;
      
      function GetCost() : ICost;
      
      function GetLabel() : String;
      
      function GetDescription() : String;
      
      function GetLoopState() : int;
      
      function GetExtraTime() : int;
      
      function ShouldShowFinisher() : Boolean;
      
      function GetNumfinisherState() : int;
      
      function GetStateAt(param1:int) : IFinisherConfigState;
      
      function GetWeight() : int;
      
      function SelectNextAnimation() : void;
      
      function GetPropVisibility() : Boolean;
   }
}
