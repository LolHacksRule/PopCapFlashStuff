package com.popcap.flash.bejeweledblitz.dailyspin.app.titlebar
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.Rotator;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.rotator.RotatorPanelSequence;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.state.StateHandlerList;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class TitleBar extends Sprite implements IDSEventHandler
   {
       
      
      private const AD_PANEL_WIDTH:Number = 165;
      
      private const AD_PANEL_HEIGHT:Number = 68;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_BG:Bitmap;
      
      private var m_FreeSpinTimer:FreeSpinCountDownTimer;
      
      private var m_AdRotator:Rotator;
      
      private var m_Ads:Vector.<AdPanel>;
      
      private var m_AdCount:int;
      
      private var m_StateHandlers:StateHandlerList;
      
      public function TitleBar(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_StateHandlers.handleState(event);
      }
      
      private function handlePanelLoad() : void
      {
         ++this.m_AdCount;
         if(this.m_AdCount == this.m_Ads.length)
         {
            this.initAdRotator();
         }
      }
      
      private function setNextFreeSpinTimer() : void
      {
         var timerX:Number = this.m_FreeSpinTimer.x + this.m_FreeSpinTimer.width * 0.5;
         var timerY:Number = this.m_FreeSpinTimer.y + this.m_FreeSpinTimer.height * 0.5;
         this.m_FreeSpinTimer.showNextFreeSpinTimer();
         LayoutHelpers.CenterXY(this.m_FreeSpinTimer,timerX,timerY);
      }
      
      private function centerPanelOnRotator(panel:AdPanel, rotator:Rotator) : void
      {
         LayoutHelpers.CenterXY(panel,rotator.layoutCenter.x,rotator.layoutCenter.y);
      }
      
      private function addTitleBarHandler(event:DSEvent, callback:Function) : void
      {
         this.m_DSMgr.addDSEventHandler(event,this);
         this.m_StateHandlers.addHandler(new StateHandler(event,callback));
      }
      
      private function removeTitleBarHandler(event:DSEvent) : void
      {
         this.m_DSMgr.removeDSEventHandler(event,this);
         this.m_StateHandlers.removeHandlerForState(event);
      }
      
      private function init() : void
      {
         this.initHandlers();
         this.m_BG = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_TITLE_BAR_BG);
         this.m_AdCount = 0;
         addChild(this.m_BG);
         var ads:Array = this.m_DSMgr.paramLoader.getTitleAds();
         if(ads && ads.length > 0)
         {
            this.initTitleBarWithAds(ads);
         }
         else
         {
            this.initTitleBar();
         }
      }
      
      private function initHandlers() : void
      {
         this.m_StateHandlers = new StateHandlerList();
         if(this.m_DSMgr.networkHandler.isDailySpinAvailable())
         {
            this.addTitleBarHandler(DSEvent.DS_EVT_BONUS_FREE_SPIN_COMPLETE,this.setNextFreeSpinTimer);
            this.addTitleBarHandler(DSEvent.DS_EVT_CONFIG_PURCHASE_SPIN,this.setNextFreeSpinTimer);
            this.addTitleBarHandler(DSEvent.DS_EVT_CONFIG_SPIN_CREDITS,this.setNextFreeSpinTimer);
         }
      }
      
      private function initTitleBar() : void
      {
         var headline:Bitmap = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_TITLE_BAR_HEADLINE_LARGE);
         LayoutHelpers.Center(headline,this.m_BG,0,-15);
         addChild(headline);
         var jewelIcon:Bitmap = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_TITLE_BAR_JEWEL_ICON);
         LayoutHelpers.Center(jewelIcon,this.m_BG,0,5);
         addChild(jewelIcon);
         this.m_FreeSpinTimer = new FreeSpinCountDownTimer(this.m_DSMgr);
         LayoutHelpers.Center(this.m_FreeSpinTimer,this,0,25);
         addChild(this.m_FreeSpinTimer);
         if(this.m_DSMgr.networkHandler.isDailySpinAvailable())
         {
            this.m_FreeSpinTimer.showFreeSpin();
         }
         else
         {
            this.m_FreeSpinTimer.showNextFreeSpinTimer();
         }
         LayoutHelpers.Center(this.m_FreeSpinTimer,jewelIcon,0,20);
      }
      
      private function initTitleBarWithAds(ads:Array) : void
      {
         var headline:Bitmap = null;
         var jewelIcon:Bitmap = null;
         var ad:Object = null;
         var adPanel:AdPanel = null;
         this.addTitleBarHandler(DSEvent.DS_EVT_TITLE_BAR_AD_IMAGE_LOADED,this.handlePanelLoad);
         this.m_Ads = new Vector.<AdPanel>();
         headline = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_TITLE_BAR_HEADLINE_SMALL);
         headline.x = 13;
         headline.y = 11;
         addChild(headline);
         jewelIcon = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_TITLE_BAR_JEWEL_ICON);
         jewelIcon.x = 16;
         LayoutHelpers.CenterVertical(jewelIcon,this.m_BG,5);
         addChild(jewelIcon);
         this.m_FreeSpinTimer = new FreeSpinCountDownTimer(this.m_DSMgr);
         addChild(this.m_FreeSpinTimer);
         if(this.m_DSMgr.networkHandler.isDailySpinAvailable())
         {
            this.m_FreeSpinTimer.showFreeSpin();
         }
         else
         {
            this.m_FreeSpinTimer.showNextFreeSpinTimer();
         }
         LayoutHelpers.Center(this.m_FreeSpinTimer,jewelIcon,0,20);
         for each(ad in ads)
         {
            adPanel = new AdPanel(this.m_DSMgr,ad["imageURL"],ad["link"]);
            this.m_Ads.push(adPanel);
         }
      }
      
      private function initAdRotator() : void
      {
         var adPanel:AdPanel = null;
         var rotatorY:Number = this.m_BG.height * 0.5 - 2;
         this.m_AdRotator = new Rotator(this.m_DSMgr,new Point(272,rotatorY));
         var sequence:RotatorPanelSequence = new RotatorPanelSequence();
         var count:int = 0;
         for each(adPanel in this.m_Ads)
         {
            if(adPanel.width != this.AD_PANEL_WIDTH && adPanel.height != this.AD_PANEL_HEIGHT)
            {
               throw new Error("Error: Advertisement Image at URL = " + adPanel.imageUrl + " - must have dimensions (width, height) = (165, 68)");
            }
            sequence.addPanel(adPanel);
            adPanel.visible = false;
            if(count++ % 2 == 0)
            {
               adPanel.setDisplayEvent(DSEvent.DS_EVT_SLOTS_START);
            }
            else
            {
               adPanel.setDisplayEvent(DSEvent.DS_EVT_SLOTS_COMPLETED_SPIN);
            }
            this.centerPanelOnRotator(adPanel,this.m_AdRotator);
            addChild(adPanel);
         }
         sequence.cycle = this.m_Ads.length > 1 ? Boolean(true) : Boolean(false);
         this.m_AdRotator.setSequence(sequence);
         addChild(this.m_AdRotator);
      }
   }
}
