package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panelconfig
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.RotatorPanelSequence;
   
   public interface IBonusBarConfig
   {
       
      
      function getLeftRotatorSequence() : RotatorPanelSequence;
      
      function getMiddleRotatorSequence() : RotatorPanelSequence;
      
      function getRightRotatorSequence() : RotatorPanelSequence;
   }
}
