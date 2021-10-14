package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar.panels
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   
   public class BonusCoinTotalPanel extends CoinTotalPanel implements IDSEventHandler
   {
       
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_PrizeTotal:int;
      
      private var m_FriendBonus:int;
      
      private var m_DailyBonus:int;
      
      public function BonusCoinTotalPanel(dsMgr:DailySpinManager, image:String, countUpFunction:Function = null)
      {
         super(dsMgr,image,countUpFunction);
         this.init();
      }
      
      override public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      override public function display(show:Boolean) : void
      {
         this.visible = show;
         if(show)
         {
            this.startPrizeCounting();
         }
      }
      
      private function setStartCount(sourceVal:int, targetVal:int, callback:Function) : void
      {
         m_CoinCounter.startCounting(sourceVal,targetVal,m_DSMgr.getLocString(DailySpinLoc.LOC_valueSeparator),callback,COUNT_UP_FRAME_SPAN);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,m_CoinCounter);
      }
      
      private function startPrizeCounting() : void
      {
         this.m_PrizeTotal = int(m_DSMgr.getPrizeData().prizeValue);
         this.setStartCount(0,this.m_PrizeTotal,this.finishedPrizeCounting);
      }
      
      private function finishedPrizeCounting() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,m_CoinCounter);
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_COIN_TALLY_COMPLETE);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_BONUS_FRIEND_COUNT_FINISHED,this);
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_BONUS_FRIEND_COUNT_FINISHED,this.startFriendBonusCounting));
      }
      
      private function startFriendBonusCounting() : void
      {
         this.m_FriendBonus = m_DSMgr.paramLoader.getFriendBonus();
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_BONUS_FRIEND_COUNT_FINISHED,this);
         this.m_StateHandlers.removeHandlerForState(DSEvent.DS_EVT_BONUS_FRIEND_COUNT_FINISHED);
         this.setStartCount(this.m_PrizeTotal,this.m_PrizeTotal + this.m_FriendBonus,this.finishedFriendBonusCounting);
      }
      
      private function finishedFriendBonusCounting() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,m_CoinCounter);
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_BONUS_FRIEND_COIN_TALLY_FINISHED);
         m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_BONUS_DAY_COUNT_FINISHED,this);
         this.m_StateHandlers.addHandler(new StateHandler(DSEvent.DS_EVT_BONUS_DAY_COUNT_FINISHED,this.startDailyBonusCounting));
      }
      
      private function startDailyBonusCounting() : void
      {
         this.m_DailyBonus = m_DSMgr.paramLoader.getDailyBonus();
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_BONUS_DAY_COUNT_FINISHED,this);
         this.m_StateHandlers.removeHandlerForState(DSEvent.DS_EVT_BONUS_DAY_COUNT_FINISHED);
         this.setStartCount(this.m_PrizeTotal + this.m_FriendBonus,this.m_PrizeTotal + this.m_FriendBonus + this.m_DailyBonus,this.finishedDayBonusCounting);
      }
      
      private function finishedDayBonusCounting() : void
      {
         m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,m_CoinCounter);
         m_DSMgr.dispatchEvent(DSEvent.DS_EVT_BONUS_FREE_SPIN_COMPLETE);
      }
      
      private function init() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         this.m_PrizeTotal = 0;
         this.m_FriendBonus = 0;
         this.m_DailyBonus = 0;
      }
   }
}
