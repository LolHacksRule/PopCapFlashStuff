package com.popcap.flash.bejeweledblitz.dailyspin.anim
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.FrameTicker;
   import flash.display.DisplayObject;
   
   public class BlinkAnim implements IDSEventHandler
   {
       
      
      private var m_Obj:DisplayObject;
      
      private var m_MinAlpha:Number;
      
      private var m_MaxAlpha:Number;
      
      private var m_Ticker:FrameTicker;
      
      public function BlinkAnim()
      {
         super();
         this.m_Ticker = new FrameTicker();
      }
      
      public function init(targetObj:DisplayObject, blinkDelayFrames:int, minAlpha:Number = 0, maxAlpha:Number = 1) : void
      {
         this.m_Obj = targetObj;
         this.m_MinAlpha = minAlpha;
         this.m_MaxAlpha = maxAlpha;
         this.m_Ticker.init(blinkDelayFrames,this.updateBlink);
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_Ticker.update();
      }
      
      private function updateBlink() : void
      {
         this.m_Obj.alpha = this.m_Obj.alpha > this.m_MinAlpha ? Number(this.m_MinAlpha) : Number(this.m_MaxAlpha);
      }
   }
}
