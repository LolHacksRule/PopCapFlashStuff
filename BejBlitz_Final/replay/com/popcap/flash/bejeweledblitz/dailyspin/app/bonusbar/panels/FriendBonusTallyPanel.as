package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   
   public class FriendBonusTallyPanel extends BonusTallyPanel
   {
       
      
      public function FriendBonusTallyPanel(dsMgr:DailySpinManager, image:String, dispatchEvent:DSEvent)
      {
         super(dsMgr,image,dispatchEvent,DSEvent.DS_EVT_COIN_TALLY_COMPLETE);
      }
      
      override protected function setContent() : void
      {
         var friends:int = m_DSMgr.paramLoader.getFriendCount();
         var friendPayout:int = m_DSMgr.paramLoader.getFriendBonus();
         var max:int = m_DSMgr.paramLoader.getFriendBonusMax();
         var label:String = String(friends) + " " + m_DSMgr.getLocString(DailySpinLoc.LOC_bonusBarFriendText);
         if(friendPayout >= max)
         {
            label = m_DSMgr.getLocString(DailySpinLoc.LOC_bonusMax);
         }
         init(label,friendPayout);
      }
   }
}
