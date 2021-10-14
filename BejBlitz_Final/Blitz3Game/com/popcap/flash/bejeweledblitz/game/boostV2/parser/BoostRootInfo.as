package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   public class BoostRootInfo
   {
       
      
      private var boostUIInfo:BoostUIInfo = null;
      
      private var boostInGameInfo:BoostInGameInfo = null;
      
      public function BoostRootInfo(param1:Object)
      {
         super();
         this.boostUIInfo = new BoostUIInfo(param1);
         this.boostInGameInfo = new BoostInGameInfo(param1);
      }
      
      public function getBoostUIConfig() : BoostUIInfo
      {
         return this.boostUIInfo;
      }
      
      public function getBoostInGameConfig() : BoostInGameInfo
      {
         return this.boostInGameInfo;
      }
   }
}
