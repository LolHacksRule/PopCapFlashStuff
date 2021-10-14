package com.popcap.flash.bejeweledblitz.dailyspin.app.prize
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.MoveAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MathHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinImages;
   import com.popcap.flash.games.dailyspin.resources.DailySpinLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flashx.textLayout.formats.TextAlign;
   
   public class DisplayPrize extends Sprite
   {
      
      private static const SYMBOL_SCALE:Number = 0.15;
      
      private static const TARGET_DISTANCE:Number = 75;
       
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_PrizeLights:PrizeLights;
      
      private var m_PrizeData:PrizeData;
      
      private var m_RollAnim:MoveAnim;
      
      private var m_RollDelay:Number;
      
      public function DisplayPrize(dsMgr:DailySpinManager, prizeData:PrizeData)
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_PrizeData = prizeData;
         this.init();
      }
      
      public function get prizeSound() : String
      {
         return this.m_PrizeData.prizeSound;
      }
      
      public function get prizeValue() : Number
      {
         return this.m_PrizeData.prizeValue;
      }
      
      public function set rollDelay(delay:Number) : void
      {
         this.m_RollDelay = delay;
      }
      
      public function displayPrize() : void
      {
         this.m_DSMgr.playSound(this.m_PrizeData.prizeSound);
         this.m_PrizeLights.play(true);
         this.alpha = 1;
      }
      
      public function reset() : void
      {
         this.m_PrizeLights.play(false);
      }
      
      public function animateMarqueeLights(play:Boolean) : void
      {
         this.m_PrizeLights.play(play);
      }
      
      public function animateRollIn() : void
      {
         var target:Point = new Point(0,this.y);
         target.x = this.x < Dimensions.GAME_WIDTH * 0.5 ? Number(this.x - TARGET_DISTANCE) : Number(this.x + TARGET_DISTANCE);
         this.initRoll(target,this.rollInComplete);
      }
      
      public function animateRollOut() : void
      {
         var target:Point = new Point(0,this.y);
         target.x = this.x < Dimensions.GAME_WIDTH * 0.5 ? Number(this.x + TARGET_DISTANCE) : Number(this.x - TARGET_DISTANCE);
         this.initRoll(target,this.rollOutComplete);
      }
      
      private function rollStart(e:Event) : void
      {
         this.m_DSMgr.addDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_RollAnim);
      }
      
      private function rollInComplete() : void
      {
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_RollAnim);
      }
      
      private function rollOutComplete() : void
      {
         this.m_DSMgr.removeDSEventHandler(DSEvent.DS_EVT_UPDATE,this.m_RollAnim);
         this.m_DSMgr.dispatchEvent(DSEvent.DS_EVT_DISPLAY_PRIZE_ROLL_OUT_COMPLETE);
      }
      
      private function initRoll(target:Point, onRollComplete:Function) : void
      {
         this.m_RollAnim.init(this,target,15,MathHelpers.easeInOutCubic,onRollComplete);
         var delay:Timer = new Timer(this.m_RollDelay,1);
         delay.addEventListener(TimerEvent.TIMER,this.rollStart);
         delay.start();
      }
      
      private function getSymbolScale(symbol:Bitmap, symbolSpan:Number) : Number
      {
         var totalWidth:Number = symbol.width * 3;
         return 0;
      }
      
      private function getSymbolBitmap(symbolId:String) : Bitmap
      {
         if(symbolId == "SYMBOL_NONE")
         {
            return this.m_DSMgr.getBitmapAsset("IMAGE_DAILYSPIN_" + symbolId);
         }
         if(symbolId == "SYMBOL_ANY")
         {
            return this.m_DSMgr.getBitmapAsset("IMAGE_DAILYSPIN_" + symbolId);
         }
         return this.m_DSMgr.getSlotLoader().getCopyOfSymbolImage(symbolId);
      }
      
      private function init() : void
      {
         var valueText:TextField = null;
         var symbolName:String = null;
         var symbol:Bitmap = null;
         var bg:Bitmap = this.m_DSMgr.getBitmapAsset(DailySpinImages.IMAGE_PRIZE_BG);
         addChild(bg);
         var symbolContainer:Sprite = new Sprite();
         var symbols:Array = new Array();
         for(var i:int = 0; i < this.m_PrizeData.prizeSymbols.length; i++)
         {
            symbolName = this.m_PrizeData.prizeSymbols[i] as String;
            symbol = this.getSymbolBitmap(symbolName);
            if(symbol.width > bg.width)
            {
               symbol.scaleX = SYMBOL_SCALE;
               symbol.scaleY = SYMBOL_SCALE;
            }
            symbols.push(symbol);
            symbolContainer.addChild(symbol);
         }
         LayoutHelpers.layoutHorizontal(symbols,bg.width * 0.8);
         LayoutHelpers.Center(symbolContainer,bg,0,-2);
         addChild(symbolContainer);
         var format:TextFormat = new TextFormat();
         format.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         format.color = 16777215;
         format.align = TextAlign.CENTER;
         format.size = 10;
         format.bold = false;
         var valLabel:String = MiscHelpers.insertNumericalSeparator(this.m_PrizeData.prizeValue,this.m_DSMgr.getLocString(DailySpinLoc.LOC_valueSeparator));
         valueText = MiscHelpers.createTextField(valLabel,format);
         LayoutHelpers.CenterHorizontal(valueText,bg);
         valueText.y = bg.height - valueText.height - 8;
         addChild(valueText);
         this.m_PrizeLights = new PrizeLights(this.m_DSMgr);
         addChild(this.m_PrizeLights);
         this.m_RollAnim = new MoveAnim();
      }
   }
}
