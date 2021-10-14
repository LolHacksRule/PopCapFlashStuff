package com.popcap.flash.bejeweledblitz.dailyspin.app.rotator
{
   public class RotatorPanelSequence
   {
       
      
      private var m_Panels:Vector.<IRotatorPanel>;
      
      private var m_CurrentPanelIdx:int;
      
      private var m_Cycle:Boolean;
      
      public function RotatorPanelSequence()
      {
         super();
         this.m_Panels = new Vector.<IRotatorPanel>();
         this.m_CurrentPanelIdx = 0;
         this.m_Cycle = false;
      }
      
      public function set cycle(shouldCycle:Boolean) : void
      {
         this.m_Cycle = shouldCycle;
      }
      
      public function getPanels() : Vector.<IRotatorPanel>
      {
         return this.m_Panels;
      }
      
      public function addPanel(panel:IRotatorPanel) : void
      {
         this.m_Panels.push(panel);
      }
      
      public function getCurrentPanel() : IRotatorPanel
      {
         return this.m_Panels[this.m_CurrentPanelIdx];
      }
      
      public function getNextPanel() : IRotatorPanel
      {
         if(this.m_CurrentPanelIdx + 1 >= this.m_Panels.length)
         {
            if(this.m_Cycle)
            {
               this.m_CurrentPanelIdx = 0;
               return this.m_Panels[this.m_CurrentPanelIdx];
            }
            return null;
         }
         return this.m_Panels[++this.m_CurrentPanelIdx];
      }
   }
}
