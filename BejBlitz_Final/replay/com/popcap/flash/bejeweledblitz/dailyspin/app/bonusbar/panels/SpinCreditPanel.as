package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   
   public class SpinCreditPanel extends TextPanel
   {
       
      
      private var m_Label:String;
      
      public function SpinCreditPanel(dsMgr:DailySpinManager, image:String)
      {
         this.m_Label = dsMgr.getLocString(DailySpinLoc.LOC_spinCredits);
         super(dsMgr,image,this.m_Label.replace("%i",dsMgr.paramLoader.getSpinCredits()));
      }
      
      override public function display(show:Boolean) : void
      {
         this.visible = show;
         if(show)
         {
            setText(this.m_Label.replace("%i",m_DSMgr.paramLoader.getSpinCredits()));
         }
      }
   }
}
