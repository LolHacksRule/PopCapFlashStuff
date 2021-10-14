package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.CoinCounter;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.controls.IToolTipHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.geom.Point;
   
   public class CoinTotalPanel extends BonusBarPanel implements IToolTipHandler, IDSEventHandler, IUserDataHandler
   {
      
      protected static const COUNT_UP_FRAME_SPAN:int = 20;
      
      protected static const COIN_COUNTER_FONT_SIZE:int = 23;
       
      
      protected var m_CoinCounter:CoinCounter;
      
      private var m_CountUpFunction:Function;
      
      private var m_CountCompleteEvents:Array;
      
      private var m_ToolTip:String;
      
      private var m_DisplayFunction:Function;
      
      private var m_StateHandlers:StateHandlerList;
      
      public function CoinTotalPanel(dsMgr:DailySpinManager, image:String, countUpFunction:Function = null, countCompleteEvents:Array = null)
      {
         super(dsMgr,image);
         this.m_CountUpFunction = countUpFunction;
         this.m_CountCompleteEvents = countCompleteEvents;
         this.init();
      }
      
      public function startCounting(sourceVal:int, targetVal:int) : void
      {
         this.m_CoinCounter.startCounting(sourceVal,targetVal,m_DSMgr.getLocString(DailySpinLoc.LOC_valueSeparator),this.finishedCounting,COUNT_UP_FRAME_SPAN);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_CoinCounter);
      }
      
      public function setDisplayValue(value:int) : void
      {
         var localizedSeparator:String = m_DSMgr.getLocString(DailySpinLoc.LOC_valueSeparator);
         var val:String = MiscHelpers.insertNumericalSeparator(value,localizedSeparator);
         this.m_CoinCounter.setDisplayValue(val);
      }
      
      public function getToolTip() : String
      {
         return this.m_ToolTip;
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         this.setUserBalance();
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
      }
      
      override public function display(show:Boolean) : void
      {
         this.visible = show;
         this.m_DisplayFunction(show);
      }
      
      protected function finishedCounting() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_CoinCounter);
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_COIN_TALLY_COMPLETE);
         if(this.m_CountCompleteEvents)
         {
            this.dispatchCompleteEvents();
         }
      }
      
      private function dispatchCompleteEvents() : void
      {
         var event:DSEvent = null;
         for each(event in this.m_CountCompleteEvents)
         {
            m_DSMgr.dispatchEvent(event);
         }
      }
      
      private function displayNormal(show:Boolean) : void
      {
         if(show && this.m_CountUpFunction != null)
         {
            this.m_CountUpFunction();
         }
      }
      
      private function displayFirstTime(show:Boolean) : void
      {
         this.m_DisplayFunction = this.displayNormal;
      }
      
      private function setDisplayFunction() : void
      {
         this.m_DisplayFunction = this.displayFirstTime;
      }
      
      private function setUserBalance() : void
      {
         this.setDisplayValue(m_DSMgr.m_App.sessionData.userData.GetCoins());
      }
      
      private function addCoinTotalHandler(event:DSEvent, callback:Function) : void
      {
         m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function removeCoinTotalHandler(event:DSEvent) : void
      {
         m_DSMgr.removeDSEventHandler(event,this);
         this.m_StateHandlers.removeHandlerForState(event);
      }
      
      private function init() : void
      {
         this.m_CoinCounter = new CoinCounter(m_DSMgr,m_BGImage.width * 0.65,COIN_COUNTER_FONT_SIZE,m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_BONUS_BAR_LARGE_COIN_ICON),new Point(this.width * 0.5,this.height * 0.5));
         this.m_CoinCounter.mouseEnabled = false;
         addChild(this.m_CoinCounter);
         LayoutHelpers.Center(this.m_CoinCounter,m_BGImage);
         this.m_ToolTip = m_DSMgr.getLocString(DailySpinLoc.LOC_infoTotal);
         this.m_StateHandlers = new StateHandlerList();
         this.m_DisplayFunction = this.displayFirstTime;
         this.addCoinTotalHandler(DSEvent.DS_EVT_CONFIG_FREE_SPIN,this.setDisplayFunction);
         this.addCoinTotalHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_IN_START,this.setUserBalance);
         m_DSMgr.m_App.sessionData.userData.AddHandler(this);
      }
   }
}
