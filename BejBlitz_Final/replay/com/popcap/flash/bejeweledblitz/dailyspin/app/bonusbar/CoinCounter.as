package com.popcap.flash.bejeweledblitz.dailyspin.app.bonusbar
{
   import com.popcap.flash.bejeweledblitz.dailyspin.anim.CountUpAnim;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.DailySpinManager;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.FrameTicker;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.LayoutHelpers;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import com.popcap.flash.framework.resources.sounds.SoundResource;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.dailyspin.resources.DailySpinSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flashx.textLayout.formats.TextAlign;
   
   public class CoinCounter extends Sprite implements IDSEventHandler
   {
       
      
      private const PADDING_BETWEEN_COIN_TOTAL_TEXT_AND_COIN_ICON:int = 10;
      
      private var m_DSMgr:DailySpinManager;
      
      private var m_CoinText:TextField;
      
      private var m_CoinIcon:Bitmap;
      
      private var m_CountUpAnim:CountUpAnim;
      
      private var m_Callback:Function;
      
      private var m_MaxWidth:Number;
      
      private var m_CenterPoint:Point;
      
      private var m_Prefix:String;
      
      private var m_Sound:SoundResource;
      
      private var m_SoundTicker:FrameTicker;
      
      public function CoinCounter(dsMgr:DailySpinManager, maxWidth:Number, fontSize:int, coinIcon:Bitmap, centerPoint:Point, prefix:String = "")
      {
         super();
         this.m_DSMgr = dsMgr;
         this.m_MaxWidth = maxWidth;
         this.m_CenterPoint = centerPoint;
         this.m_Prefix = prefix;
         this.init(fontSize,coinIcon);
      }
      
      public function startCounting(sourceVal:int, targetVal:int, numericalSeparator:String, callback:Function = null, frameSpan:int = 20) : void
      {
         this.m_CountUpAnim.init(this.m_CoinText,sourceVal,targetVal,numericalSeparator,frameSpan,callback,this.m_MaxWidth,this.m_Prefix);
      }
      
      public function setDisplayValue(value:String) : void
      {
         this.m_CoinText.text = value;
         this.updateLayout();
      }
      
      private function updateLayout() : void
      {
         this.m_CoinText.x = 0;
         this.m_CoinIcon.x = this.m_CoinText.textWidth + this.PADDING_BETWEEN_COIN_TOTAL_TEXT_AND_COIN_ICON;
         LayoutHelpers.CenterVertical(this.m_CoinIcon,this.m_CoinText,-3);
         LayoutHelpers.CenterXY(this,this.m_CenterPoint.x,this.m_CenterPoint.y);
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_CountUpAnim.handleEvent(event);
         this.m_SoundTicker.update();
         this.updateLayout();
      }
      
      private function playSound() : void
      {
         this.m_Sound.play(1);
      }
      
      private function init(fontSize:int, coinIcon:Bitmap) : void
      {
         var fmt:TextFormat = new TextFormat();
         fmt.font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         fmt.color = 16777215;
         fmt.size = fontSize;
         fmt.align = TextAlign.CENTER;
         this.m_CoinText = MiscHelpers.createTextField("0",fmt);
         this.m_CoinText.y = 0;
         this.m_CoinText.x = 0;
         addChild(this.m_CoinText);
         this.m_CoinIcon = coinIcon;
         this.m_CoinIcon.x = this.m_CoinText.width + 5;
         LayoutHelpers.CenterVertical(this.m_CoinIcon,this.m_CoinText,-2);
         addChild(this.m_CoinIcon);
         this.m_CountUpAnim = new CountUpAnim();
         this.m_Sound = this.m_DSMgr.getSoundResource(DailySpinSounds.SOUND_COIN_COUNTER);
         this.m_SoundTicker = new FrameTicker();
         this.m_SoundTicker.init(2,this.playSound);
      }
   }
}
