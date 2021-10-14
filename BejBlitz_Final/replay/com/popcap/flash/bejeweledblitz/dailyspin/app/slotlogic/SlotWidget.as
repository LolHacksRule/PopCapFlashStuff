package com.popcap.flash.bejeweledblitz.dailyspin.app.slotlogic
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.SlotsView;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.prize.PrizeData;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SlotWidget extends Sprite implements IDSEventHandler
   {
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_Slots:SlotsView;
      
      public function SlotWidget(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function spinSlots(result:Number) : void
      {
         this.m_Slots.spinSlots(result);
         this.m_DSMgr.getSoundResource(DailySpinSounds.SOUND_SLOTS_SPINNING).loop();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         var result:Number = this.getSpinValueFromPrize(this.m_DSMgr.paramLoader.getStringParam("spin"));
         this.spinSlots(result);
      }
      
      private function slotsStart(e:Event) : void
      {
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SLOTS_START);
      }
      
      private function slotsStop(e:Event) : void
      {
         this.m_DSMgr.getSoundResource(DailySpinSounds.SOUND_SLOTS_SPINNING).stop();
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN);
      }
      
      private function reelComplete(e:Event) : void
      {
         this.m_DSMgr.playSound(DailySpinSounds.SOUND_SLOTS_REEL_STOP);
      }
      
      private function getSpinValueFromPrize(prizeID:String) : Number
      {
         var prize:PrizeData = null;
         var prizeData:Vector.<PrizeData> = this.m_DSMgr.paramLoader.getSlotConfig().getPrizeDataSet();
         var result:Number = 0;
         for each(prize in prizeData)
         {
            if(prize.prizeID == prizeID)
            {
               break;
            }
            result += prize.prizeWeight;
         }
         return result;
      }
      
      private function init() : void
      {
         var startX:Number = NaN;
         var startY:Number = NaN;
         var slotsFrame:Bitmap = null;
         this.m_Slots = new SlotsView(this.m_DSMgr.getSlotLoader());
         addChild(this.m_Slots);
         startX = (Dimensions.GAME_WIDTH - this.width) * 0.5;
         startY = (Dimensions.GAME_HEIGHT - this.height - 49) * 0.5;
         slotsFrame = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_SLOTS_FRAME);
         slotsFrame.x = startX - 15;
         slotsFrame.y = startY - 10;
         addChild(slotsFrame);
         this.graphics.beginFill(16777215);
         this.graphics.drawRect(startX - 2,startY,this.width - 25,this.height - 25);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_SPIN_SLOTS,this);
         this.addEventListener(SlotsView.EVT_SLOTS_START_SPIN,this.slotsStart);
         this.addEventListener(SlotsView.EVT_SLOTS_STOP_SPIN,this.slotsStop);
         this.addEventListener(SlotsView.EVT_SLOT_REEL_COMPLETE_SPIN,this.reelComplete);
      }
   }
}
