package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   public interface IPlayerDataHandler
   {
       
      
      function HandleStarMedalAwarded(param1:PlayerData, param2:int) : void;
      
      function HandleMedalBucketFilled(param1:PlayerData, param2:int) : void;
   }
}
