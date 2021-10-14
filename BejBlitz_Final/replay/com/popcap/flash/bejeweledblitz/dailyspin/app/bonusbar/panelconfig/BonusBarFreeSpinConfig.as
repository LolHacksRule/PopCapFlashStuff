package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.BlinkingIconPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.BonusCoinTotalPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.CoinTotalPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.FriendBonusTallyPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.StreakBonusTallyPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.TextPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels.YouWinPanel;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.geom.Point;
   
   public class BonusBarFreeSpinConfig extends BaseBonusBarConfig
   {
       
      
      public function BonusBarFreeSpinConfig(dsMgr:DailySpinManager)
      {
         super(dsMgr);
         this.initLeftRotatorPanels();
         this.initMiddleRotatorPanels();
         this.initRightRotatorPanels();
      }
      
      private function initLeftRotatorPanels() : void
      {
         m_LeftRotatorSequence.addPanel(new TextPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_ROTATOR_BG,m_DSMgr.getLocString(DailySpinLoc.LOC_centerStartLeft)));
         var blinkGemPanel:BlinkingIconPanel = new BlinkingIconPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_PANEL_SPINNING_DRESSING_LEFT,DailySpinImages.IMAGE_BONUS_BAR_SMALL_GEM,new Point(8,9));
         blinkGemPanel.setDisplayEvent(DSEvent.DS_EVT_SPIN_SLOTS);
         m_LeftRotatorSequence.addPanel(blinkGemPanel);
         var friendBonus:FriendBonusTallyPanel = new FriendBonusTallyPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_ROTATOR_BG,DSEvent.DS_EVT_BONUS_FRIEND_COUNT_FINISHED);
         m_LeftRotatorSequence.addPanel(friendBonus);
      }
      
      private function initMiddleRotatorPanels() : void
      {
         var userTotal:int = m_DSMgr.m_App.sessionData.userData.GetCoins();
         var ctp:CoinTotalPanel = new CoinTotalPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG);
         m_MiddleRotatorSequence.addPanel(ctp);
         var spinning:TextPanel = new TextPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG,m_DSMgr.getLocString(DailySpinLoc.LOC_centerSpinning));
         spinning.setDisplayEvent(DSEvent.DS_EVT_SPIN_SLOTS);
         m_MiddleRotatorSequence.addPanel(spinning);
         var youWin:YouWinPanel = new YouWinPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG);
         youWin.setDisplayEvent(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN);
         m_MiddleRotatorSequence.addPanel(youWin);
         var countPrizeBonusFunction:Function = function():void
         {
            this.startCounting(0,int(m_DSMgr.getPrizeData().prizeValue));
         };
         var prizeTotal:BonusCoinTotalPanel = new BonusCoinTotalPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_COIN_TOTAL_BG,countPrizeBonusFunction);
         prizeTotal.setDisplayEvent(DSEvent.DS_EVT_YOU_WIN_ANIM_COMPLETE);
         prizeTotal.delayFlip = false;
         m_MiddleRotatorSequence.addPanel(prizeTotal);
      }
      
      private function initRightRotatorPanels() : void
      {
         m_RightRotatorSequence.addPanel(new TextPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_ROTATOR_BG,m_DSMgr.getLocString(DailySpinLoc.LOC_centerStartRight)));
         var blinkCoinPanel:BlinkingIconPanel = new BlinkingIconPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_PANEL_SPINNING_DRESSING_RIGHT,DailySpinImages.IMAGE_BONUS_BAR_COIN_BLINK_ICON,new Point(64,9));
         blinkCoinPanel.setDisplayEvent(DSEvent.DS_EVT_SPIN_SLOTS);
         m_RightRotatorSequence.addPanel(blinkCoinPanel);
         var dailyBonus:StreakBonusTallyPanel = new StreakBonusTallyPanel(m_DSMgr,DailySpinImages.IMAGE_BONUS_BAR_ROTATOR_BG,DSEvent.DS_EVT_BONUS_DAY_COUNT_FINISHED);
         dailyBonus.delayFlip = false;
         m_RightRotatorSequence.addPanel(dailyBonus);
      }
   }
}
