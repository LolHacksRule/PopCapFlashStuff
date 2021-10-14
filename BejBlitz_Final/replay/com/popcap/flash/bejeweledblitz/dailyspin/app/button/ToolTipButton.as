package com.popcap.flash.bejeweledblitz.dailyspin.app.button
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.controls.IToolTipHandler;
   
   public class ToolTipButton extends ResizableButton implements IToolTipHandler
   {
       
      
      protected var m_ToolTip:String;
      
      public function ToolTipButton(dsMgr:DailySpinManager, config:IButtonConfig, toolTip:String)
      {
         super(dsMgr,config);
         this.m_ToolTip = toolTip;
      }
      
      public function getToolTip() : String
      {
         return this.m_ToolTip;
      }
   }
}
