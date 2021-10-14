package com.popcap.flash.bejeweledblitz.dailyspin
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class DailySpinWidget extends Sprite
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_Handlers:Vector.<IDailySpinWidgetHandler>;
      
      public var autoDisplayed:Boolean = false;
      
      public function DailySpinWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         visible = false;
         this.m_Handlers = new Vector.<IDailySpinWidgetHandler>();
      }
      
      public function Init() : void
      {
         this.m_DSMgr = new DailySpinManager(this.m_App,this);
         this.m_App.network.AddExternalCallback("openDailySpin",this.HandleDailySpinOpen);
         this.m_App.network.AddExternalCallback("closeDailySpin",this.HandleDailySpinClosed);
         this.m_App.RegisterCommand("DailySpinCheat",this.Show);
         addEventListener(Event.ENTER_FRAME,this.update);
      }
      
      public function AddHandler(handler:IDailySpinWidgetHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Show(isAuto:Boolean = false) : void
      {
         if(this.m_App.tutorial.IsEnabled() || visible)
         {
            return;
         }
         this.autoDisplayed = isAuto;
         visible = true;
         mouseChildren = true;
         this.m_App.network.ExternalSetPaused(true);
         this.m_App.ui.addChildAt(this,this.m_App.ui.numChildren - 2);
         this.m_DSMgr.display();
         this.DispatchShown();
      }
      
      public function Hide() : void
      {
         if(this.m_App.ui.contains(this))
         {
            this.m_App.ui.removeChild(this);
         }
         this.m_App.network.ExternalSetPaused(false);
         mouseChildren = false;
         visible = false;
         this.DispatchHidden();
      }
      
      public function IsFullyLoaded() : Boolean
      {
         return this.m_DSMgr.isLoaded;
      }
      
      public function HideSelf() : void
      {
         if(visible)
         {
            this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT);
         }
      }
      
      private function update(e:Event) : void
      {
         this.m_DSMgr.update();
      }
      
      private function HandleDailySpinOpen() : void
      {
         this.Show(false);
      }
      
      private function HandleDailySpinClosed(result:Object) : void
      {
         this.m_App.network.HandleBuyCoins(result["updateBalance"]);
      }
      
      private function DispatchShown() : void
      {
         var handler:IDailySpinWidgetHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleDailySpinShown();
         }
      }
      
      private function DispatchHidden() : void
      {
         var handler:IDailySpinWidgetHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleDailySpinHidden();
         }
      }
   }
}
