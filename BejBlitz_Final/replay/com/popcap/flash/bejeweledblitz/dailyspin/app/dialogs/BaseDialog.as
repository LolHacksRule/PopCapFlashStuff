package com.popcap.flash.bejeweledblitz.dailyspin.app.dialogs
{
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.MoveAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BaseDialog extends Sprite implements IDSEventHandler
   {
      
      protected static var DISPLAY_ANIM_FRAME_SPAN:int = 30;
       
      
      protected var m_DSMgr:DailySpinManager;
      
      protected var m_StateHandlers:StateHandlerList;
      
      protected var m_DisplayAnim:MoveAnim;
      
      protected var m_OffScreenPosition:Point;
      
      protected var m_OnScreenPosition:Point;
      
      public function BaseDialog(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function init() : void
      {
         this.m_DisplayAnim = new MoveAnim();
         this.m_StateHandlers = new StateHandlerList();
      }
   }
}
