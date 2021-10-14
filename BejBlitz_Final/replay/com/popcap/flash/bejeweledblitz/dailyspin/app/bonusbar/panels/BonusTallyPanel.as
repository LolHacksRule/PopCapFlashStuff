package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.CoinCounter;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class BonusTallyPanel extends BonusBarPanel implements IDSEventHandler
   {
       
      
      private var m_BonusLabel:TextField;
      
      private var m_CoinCounter:CoinCounter;
      
      private var m_Value:int;
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_Dispatchvent:DSEvent;
      
      public function BonusTallyPanel(dsMgr:DailySpinManager, image:String, dispatchEvent:DSEvent, displayEvent:DSEvent = null)
      {
         super(dsMgr,image);
         this.m_StateHandlers = new StateHandlerList();
         this.m_Dispatchvent = dispatchEvent;
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_SLOTS_START,this);
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_SLOTS_START,this.onSlotsStart));
         m_DSMgr.addDSEventHandler(displayEvent,this);
         if(displayEvent != null)
         {
            this.setDisplayEvent(displayEvent);
         }
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      override public function display(show:Boolean) : void
      {
         if(visible == show)
         {
            return;
         }
         visible = show;
         if(show)
         {
            this.m_CoinCounter.startCounting(0,this.getBonusValue(),m_DSMgr.getLocString(DailySpinLoc.LOC_valueSeparator),this.finishedCounting);
            m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_CoinCounter);
         }
      }
      
      override public function setDisplayEvent(event:DSEvent) : void
      {
         super.setDisplayEvent(event);
         this.m_StateHandlers.addHandler(new StateHandler(event,this.onDisplay));
      }
      
      public function init(label:String, value:int) : void
      {
         this.m_Value = value;
         this.initBonusLabel(label);
         this.initCoinCounter();
      }
      
      public function getBonusValue() : int
      {
         return this.m_Value;
      }
      
      protected function setContent() : void
      {
      }
      
      private function finishedCounting() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_CoinCounter);
         m_DSMgr.dispatchEvent(this.m_Dispatchvent);
      }
      
      private function onSlotsStart() : void
      {
         this.setContent();
      }
      
      private function onDisplay() : void
      {
         this.display(true);
      }
      
      private function initBonusLabel(label:String) : void
      {
         var fmt:TextFormat = new TextFormat();
         fmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         fmt.color = 15724851;
         this.m_BonusLabel = MiscHelpers.createTextField(label,fmt);
         LayoutHelpers.Center(this.m_BonusLabel,m_BGImage,0,-8);
         addChild(this.m_BonusLabel);
      }
      
      private function initCoinCounter() : void
      {
         this.m_CoinCounter = new CoinCounter(m_DSMgr,m_BGImage.width * 0.8,15,m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_BONUS_BAR_COIN_BLINK_ICON),new Point(width * 0.5,32),"+");
         LayoutHelpers.Center(this.m_CoinCounter,m_BGImage,0,8);
         addChild(this.m_CoinCounter);
      }
   }
}
