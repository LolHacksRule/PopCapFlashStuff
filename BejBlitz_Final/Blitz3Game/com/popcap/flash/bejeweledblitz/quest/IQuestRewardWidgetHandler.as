package com.popcap.flash.bejeweledblitz.quest
{
   public interface IQuestRewardWidgetHandler
   {
       
      
      function CanShowQuestReward() : Boolean;
      
      function HandleQuestRewardClosed(param1:String) : void;
      
      function HandleQuestRewardOpened() : void;
   }
}
