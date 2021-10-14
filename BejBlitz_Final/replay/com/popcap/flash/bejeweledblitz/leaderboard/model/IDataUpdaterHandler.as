package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   public interface IDataUpdaterHandler
   {
       
      
      function HandleBasicLoadBegin() : void;
      
      function HandleBasicLoadComplete() : void;
      
      function HandleBasicLoadError() : void;
      
      function HandleExtendedLoadBegin(param1:String, param2:String) : void;
      
      function HandleExtendedLoadComplete(param1:String, param2:String) : void;
      
      function HandleExtendedLoadError() : void;
      
      function HandleScoreUpdated(param1:int) : void;
   }
}
