package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.IServerIO;
   
   public class ServerIODailyChallengeConfigProvider implements IDailyChallengeConfigProvider
   {
       
      
      private var _serverIO:IServerIO;
      
      public function ServerIODailyChallengeConfigProvider(param1:IServerIO)
      {
         super();
         this._serverIO = param1;
      }
      
      public function fetchDailyChallenge(param1:Function, param2:* = null) : void
      {
         this._serverIO.registerCallback("receiveDailyChallengeConfig",param1,param2);
         this._serverIO.sendToServer("getDailyChallengeConfig");
      }
   }
}
