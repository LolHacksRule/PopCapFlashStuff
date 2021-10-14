package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.BlinkingIconPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.CoinTotalPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.SpinCreditCoinTotalPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.SpinCreditPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.TextPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.YouWinPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.geom.Point;
   
   public class BonusBarSpinCreditConfig extends BaseBonusBarConfig
   {
       
      
      public function BonusBarSpinCreditConfig(dsMgr:DailySpinManager)
      {
         super(dsMgr);
         this.initLeftRotatorPanels();
         this.initMiddleRotatorPanels();
         this.initRightRotatorPanels();
      }
      
      private function initLeftRotatorPanels() : void
      {
         var totalBalance:TextPanel = new TextPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_ROTATOR_BG,m_DSMgr.getLocString(DailySpinLoc.LOC_totalBalance));
         totalBalance.setDisplayEvent(DSEvent.DS_EVT_COIN_TALLY_COMPLETE);
         m_LeftRotatorSequence.addPanel(totalBalance);
         var blinkGemPanel:BlinkingIconPanel = new BlinkingIconPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_PANEL_SPINNING_DRESSING_LEFT,DailySpinImages.IMAGE_BONUS_BAR_SMALL_GEM,new Point(8,9));
         blinkGemPanel.setDisplayEvent(DSEvent.DS_EVT_SPIN_SLOTS);
         m_LeftRotatorSequence.addPanel(blinkGemPanel);
         m_LeftRotatorSequence.cycle = true;
      }
      
      private function initMiddleRotatorPanels() : void
      {
         var userTotal:int = m_DSMgr.paramLoader.getIntParam("coinBalance");
         var countTotalFunction:Function = function():void
         {
            var gameBalance:int = m_DSMgr.m_App.sessionData.userData.GetCoins();
            this.startCounting(0,gameBalance);
         };
         var ctp:CoinTotalPanel = new CoinTotalPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG,countTotalFunction,[DSEvent.DS_EVT_USER_TOTAL_BALANCE_TALLY_COMPLETE]);
         ctp.setDisplayEvent(DSEvent.DS_EVT_COIN_TALLY_COMPLETE);
         ctp.setDisplayValue(userTotal);
         m_MiddleRotatorSequence.addPanel(ctp);
         var spinning:TextPanel = new TextPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG,m_DSMgr.getLocString(DailySpinLoc.LOC_centerSpinning));
         spinning.setDisplayEvent(DSEvent.DS_EVT_SPIN_SLOTS);
         m_MiddleRotatorSequence.addPanel(spinning);
         var youWin:YouWinPanel = new YouWinPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG);
         youWin.setDisplayEvent(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN);
         m_MiddleRotatorSequence.addPanel(youWin);
         var countPrizeBonusFunction:Function = function():void
         {
            this.startCounting(0,m_DSMgr.getPrizeData().prizeValue);
         };
         var spinCreditsTotal:SpinCreditCoinTotalPanel = new SpinCreditCoinTotalPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG,countPrizeBonusFunction);
         spinCreditsTotal.setDisplayEvent(DSEvent.DS_EVT_YOU_WIN_ANIM_COMPLETE);
         spinCreditsTotal.delayFlip = false;
         m_MiddleRotatorSequence.addPanel(spinCreditsTotal);
         m_MiddleRotatorSequence.cycle = true;
      }
      
      private function initRightRotatorPanels() : void
      {
         var spinCredits:SpinCreditPanel = new SpinCreditPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_ROTATOR_BG);
         spinCredits.setDisplayEvent(DSEvent.DS_EVT_COIN_TALLY_COMPLETE);
         m_RightRotatorSequence.addPanel(spinCredits);
         var blinkCoinPanelBack:BlinkingIconPanel = new BlinkingIconPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_PANEL_SPINNING_DRESSING_RIGHT,DailySpinImages.IMAGE_BONUS_BAR_COIN_BLINK_ICON,new Point(64,9));
         blinkCoinPanelBack.setDisplayEvent(DSEvent.DS_EVT_SPIN_SLOTS);
         m_RightRotatorSequence.addPanel(blinkCoinPanelBack);
         m_RightRotatorSequence.cycle = true;
      }
   }
}
