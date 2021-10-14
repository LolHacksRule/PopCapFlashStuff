package com.popcap.flash.bejeweledblitz.dailyspin.app.titlebar
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   import flashx.textLayout.formats.TextAlign;
   
   public class FreeSpinCountDownTimer extends Sprite implements IDSEventHandler
   {
       
      
      private const SMALL_WIDTH:Number = 70;
      
      private const LARGE_WIDTH:Number = 145;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_CountDownText:TextField;
      
      private var m_TimeAssets:Array;
      
      private var m_AssetContainer:Sprite;
      
      private var m_NextSpin:int;
      
      public function FreeSpinCountDownTimer(dsMgr:DailySpinManager)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.init();
      }
      
      public function showNextFreeSpinTimer() : void
      {
         this.m_CountDownText.htmlText = this.m_DSMgr.getLocString(DailySpinLoc.LOC_nextSpin);
         this.m_TimeAssets[1].width = this.LARGE_WIDTH;
         LayoutHelpers.layoutHorizontalByEdge(this.m_TimeAssets);
         LayoutHelpers.Center(this.m_CountDownText,this.m_AssetContainer,0,1);
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this);
      }
      
      public function showFreeSpin() : void
      {
         this.m_CountDownText.htmlText = this.m_DSMgr.getLocString(DailySpinLoc.LOC_titleFreeSpin);
         this.m_TimeAssets[1].width = this.SMALL_WIDTH;
         LayoutHelpers.layoutHorizontalByEdge(this.m_TimeAssets);
         LayoutHelpers.Center(this.m_CountDownText,this.m_AssetContainer,0,1);
      }
      
      public function handleEvent(e:DSEvent) : void
      {
         this.updateCountdown();
      }
      
      private function createCountdownTimerAsset(assetName:String) : Bitmap
      {
         var asset:Bitmap = this.m_DSMgr.getBitmapAsset(assetName);
         asset.pixelSnapping = PixelSnapping.NEVER;
         this.m_AssetContainer.addChild(asset);
         return asset;
      }
      
      private function updateCountdown() : void
      {
         var d:int = this.m_NextSpin - getTimer();
         var hrs:int = d <= 0 ? int(0) : int(Math.floor(d / (60 * 60 * 1000)));
         var mins:int = d <= 0 ? int(0) : int(Math.floor((d - hrs * (60 * 60 * 1000)) / (60 * 1000)));
         var secs:int = d <= 0 ? int(0) : int(Math.round((d - 60 * 1000 * (mins + hrs * 60)) / 1000));
         this.m_CountDownText.htmlText = this.m_DSMgr.getLocString(DailySpinLoc.LOC_nextSpin) + " " + (hrs < 10 ? "0" : "") + hrs.toString() + ":" + (mins < 10 ? "0" : "") + mins.toString() + ":" + (secs < 10 ? "0" : "") + secs.toString();
      }
      
      private function init() : void
      {
         var freeSpin:Boolean = this.m_DSMgr.networkHandler.isDailySpinAvailable();
         this.initAssetSlices();
         this.initCountdownText(freeSpin);
         this.m_NextSpin = this.m_DSMgr.paramLoader.getIntParam("nextSpinDelta") * 1000;
      }
      
      private function initAssetSlices() : void
      {
         this.m_AssetContainer = new Sprite();
         this.m_TimeAssets = [this.createCountdownTimerAsset(DailySpinImages.IMAGE_TITLE_BAR_NEXT_SPIN_CAP_LEFT),this.createCountdownTimerAsset(DailySpinImages.IMAGE_TITLE_BAR_NEXT_SPIN_MIDDLE),this.createCountdownTimerAsset(DailySpinImages.IMAGE_TITLE_BAR_NEXT_CAP_RIGHT)];
         addChild(this.m_AssetContainer);
      }
      
      private function initCountdownText(freeSpin:Boolean) : void
      {
         var fmt:TextFormat = new TextFormat();
         fmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         fmt.align = TextAlign.CENTER;
         fmt.color = 16777215;
         this.m_CountDownText = MiscHelpers.createTextField("",fmt);
         this.m_CountDownText.multiline = false;
         addChild(this.m_CountDownText);
      }
   }
}
