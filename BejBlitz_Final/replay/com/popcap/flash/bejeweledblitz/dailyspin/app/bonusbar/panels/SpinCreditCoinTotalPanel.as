package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   
   public class SpinCreditCoinTotalPanel extends CoinTotalPanel
   {
       
      
      private var m_Credits:int;
      
      public function SpinCreditCoinTotalPanel(dsMgr:DailySpinManager, image:String, countUpFunction:Function = null)
      {
         super(dsMgr,image,countUpFunction);
         this.init();
      }
      
      override protected function finishedCounting() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,m_CoinCounter);
         if(m_DSMgr.paramLoader.getSpinCredits() < 1)
         {
            m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SPIN_CREDITS_CONSUMED);
         }
         else
         {
            m_DSMgr.dispatchEvent(DSEvent.DS_EVT_COIN_TALLY_COMPLETE);
         }
      }
      
      private function init() : void
      {
         this.m_Credits = m_DSMgr.paramLoader.getIntParam("credits");
      }
   }
}
