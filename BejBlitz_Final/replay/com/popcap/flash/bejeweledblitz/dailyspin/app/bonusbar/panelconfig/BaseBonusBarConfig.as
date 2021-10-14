package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.RotatorPanelSequence;
   
   public class BaseBonusBarConfig implements IBonusBarConfig
   {
       
      
      protected var m_DSMgr:DailySpinManager;
      
      protected var m_LeftRotatorSequence:RotatorPanelSequence;
      
      protected var m_MiddleRotatorSequence:RotatorPanelSequence;
      
      protected var m_RightRotatorSequence:RotatorPanelSequence;
      
      public function BaseBonusBarConfig(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_LeftRotatorSequence = new RotatorPanelSequence();
         this.m_MiddleRotatorSequence = new RotatorPanelSequence();
         this.m_RightRotatorSequence = new RotatorPanelSequence();
      }
      
      public function getLeftRotatorSequence() : RotatorPanelSequence
      {
         return this.m_LeftRotatorSequence;
      }
      
      public function getMiddleRotatorSequence() : RotatorPanelSequence
      {
         return this.m_MiddleRotatorSequence;
      }
      
      public function getRightRotatorSequence() : RotatorPanelSequence
      {
         return this.m_RightRotatorSequence;
      }
   }
}
