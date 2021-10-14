package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   
   public class StreakBonusTallyPanel extends BonusTallyPanel
   {
       
      
      public function StreakBonusTallyPanel(dsMgr:DailySpinManager, image:String, dispatchEvent:DSEvent)
      {
         super(dsMgr,image,dispatchEvent,DSEvent.DS_EVT_BONUS_FRIEND_COIN_TALLY_FINISHED);
      }
      
      override protected function setContent() : void
      {
         var days:int = m_DSMgr.paramLoader.getDayCount();
         var payoutStreak:int = m_DSMgr.paramLoader.getDailyBonus();
         var max:int = m_DSMgr.paramLoader.getDailyBonusMax();
         var label:String = m_DSMgr.getLocString(DailySpinLoc.LOC_dayCountDayText);
         label = label.replace("%s",MiscHelpers.getValueSuffix(days,m_DSMgr));
         if(payoutStreak >= max)
         {
            label = m_DSMgr.getLocString(DailySpinLoc.LOC_maxDays);
         }
         init(label,payoutStreak);
      }
   }
}
