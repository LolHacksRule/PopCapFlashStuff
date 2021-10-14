package com.popcap.flash.bejeweledblitz.dailyspin.app.prize
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class PrizeManager extends Sprite implements IDSEventHandler
   {
       
      
      private const PRIZE_ROLL_DELAY:Number = 65;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_Prizes:Dictionary;
      
      private var m_StateHandlers:StateHandlerList;
      
      private var m_PrizeCount:int;
      
      private var m_PrizesCompletedRollOut:int;
      
      public function PrizeManager(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function handleRollInComplete() : void
      {
         var displayPrize:DisplayPrize = null;
         for each(displayPrize in this.m_Prizes)
         {
            displayPrize.animateRollIn();
         }
         this.m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
      }
      
      private function handleRollOutStart() : void
      {
         var displayPrize:DisplayPrize = null;
         this.setDisplayPrizeState();
         this.addPrizeHandler(DSEvent.DS_EVT_DISPLAY_PRIZE_ROLL_OUT_COMPLETE,this.handlePrizeRollOutComplete);
         for each(displayPrize in this.m_Prizes)
         {
            displayPrize.animateRollOut();
         }
         this.m_DSMgr.playSound(DailySpinSounds.SOUND_SLIDE_SOUND_2);
      }
      
      private function handlePrizeRollOutComplete() : void
      {
         ++this.m_PrizesCompletedRollOut;
         if(this.m_PrizesCompletedRollOut >= this.m_PrizeCount)
         {
            this.m_PrizesCompletedRollOut = 0;
            this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_OUT_START);
         }
      }
      
      private function handleSlotsCompletedSpin() : void
      {
         this.displayPrize();
      }
      
      private function handleSlotsStart() : void
      {
         this.setDisplayPrizeState();
      }
      
      private function setDisplayPrizeState(alphaVal:Number = 1) : void
      {
         var displayPrize:DisplayPrize = null;
         for each(displayPrize in this.m_Prizes)
         {
            displayPrize.reset();
            displayPrize.alpha = alphaVal;
         }
      }
      
      private function displayPrize() : void
      {
         this.setDisplayPrizeState(0.45);
         var prizeId:String = this.m_DSMgr.getPrizeId();
         var winningPrize:DisplayPrize = this.m_Prizes[prizeId] as DisplayPrize;
         winningPrize.displayPrize();
      }
      
      private function addPrizeHandler(event:DSEvent, callback:Function) : void
      {
         this.m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function removePrizeHandler(event:DSEvent) : void
      {
         this.m_DSMgr.removeDSEventHandler(event,this);
         this.m_StateHandlers.removeHandlerForState(event);
      }
      
      private function sortPrizes(prizeA:DisplayPrize, prizeB:DisplayPrize) : Number
      {
         if(prizeA.prizeValue < prizeB.prizeValue)
         {
            return 1;
         }
         if(prizeA.prizeValue > prizeB.prizeValue)
         {
            return -1;
         }
         return 0;
      }
      
      private function init() : void
      {
         this.initPrizeMarquees();
         this.initHandlers();
         this.m_PrizesCompletedRollOut = 0;
      }
      
      private function initPrizeMarquees() : void
      {
         var prize:PrizeData = null;
         var displayPrize:DisplayPrize = null;
         this.m_Prizes = new Dictionary();
         var prizes:Array = new Array();
         var prizeData:Vector.<PrizeData> = this.m_DSMgr.paramLoader.getSlotConfig().getPrizeDataSet();
         this.m_PrizeCount = prizeData.length;
         for(var i:int = prizeData.length - 1; i >= 0; i--)
         {
            prize = prizeData[i];
            displayPrize = new DisplayPrize(this.m_DSMgr,prize);
            prizes.push(displayPrize);
            this.m_Prizes[prize.prizeID] = displayPrize;
            addChild(displayPrize);
         }
         LayoutHelpers.layoutVertical(prizes.slice(0,5),355,new Point(78,30));
         LayoutHelpers.layoutVertical(prizes.slice(5,prizes.length),355,new Point(366,30));
         prizes.sort(this.sortPrizes);
         this.setRollInDelay(prizes.slice(0,5));
         this.setRollInDelay(prizes.slice(5,prizes.length));
      }
      
      private function setRollInDelay(prizes:Array) : void
      {
         var prize:DisplayPrize = null;
         var count:int = 0;
         for each(prize in prizes)
         {
            prize.rollDelay = count++ * this.PRIZE_ROLL_DELAY;
         }
      }
      
      private function initHandlers() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         this.addPrizeHandler(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN,this.handleSlotsCompletedSpin);
         this.addPrizeHandler(DSEvent.DS_EVT_SLOTS_START,this.handleSlotsStart);
         this.addPrizeHandler(DSEvent.DS_EVT_DISPLAY_SLOTS_ROLL_IN_COMPLETE,this.handleRollInComplete);
         this.addPrizeHandler(DSEvent.DS_EVT_START_DISPLAY_ROLL_OUT,this.handleRollOutStart);
      }
   }
}
