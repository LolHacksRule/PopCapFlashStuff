package com.popcap.flash.bejeweledblitz.game.quests
{
   public interface IQuestManagerHandler
   {
       
      
      function HandleQuestComplete(param1:Quest) : void;
      
      function HandleQuestsUpdated(param1:Boolean) : void;
      
      function HandleQuestExpire(param1:Quest) : void;
   }
}
