package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2Manager;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   
   public interface ISessionData
   {
       
      
      function get userData() : UserData;
      
      function get rareGemManager() : RareGemManager;
      
      function get boostV2Manager() : BoostV2Manager;
   }
}
