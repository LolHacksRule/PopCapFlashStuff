package com.popcap.flash.bejeweledblitz.dailyspin.anim
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.FrameTicker;
   import com.popcap.flash.bejeweledblitz.dailyspin.misc.MiscHelpers;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class CountUpAnim implements IDSEventHandler
   {
       
      
      private var m_TextObj:TextField;
      
      private var m_Ticker:FrameTicker;
      
      private var m_SourceVal:int;
      
      private var m_TargetVal:int;
      
      private var m_CountInterval:int;
      
      private var m_Callback:Function;
      
      private var m_MaxTextWidth:Number;
      
      private var m_Separator:String;
      
      private var m_Prefix:String;
      
      public function CountUpAnim()
      {
         super();
         this.m_Ticker = new FrameTicker();
      }
      
      public function init(textObj:TextField, sourceVal:int, targetVal:int, numericalSeparator:String, frameSpan:int, callback:Function = null, maxTextWidth:Number = 0, prefix:String = "") : void
      {
         this.m_TextObj = textObj;
         this.m_SourceVal = sourceVal;
         this.m_TargetVal = targetVal;
         this.m_Callback = callback;
         this.m_MaxTextWidth = maxTextWidth;
         this.m_Separator = numericalSeparator;
         this.m_Prefix = prefix;
         this.m_CountInterval = Math.floor(Math.abs(targetVal - sourceVal) / frameSpan) + int(Math.random() * 10);
         this.m_Ticker.init(0,this.updateCount);
      }
      
      public function get currentCount() : int
      {
         return this.m_SourceVal;
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.m_Ticker.update();
      }
      
      private function updateCount() : void
      {
         this.m_SourceVal += this.m_CountInterval;
         if(this.m_SourceVal >= this.m_TargetVal)
         {
            this.m_SourceVal = this.m_TargetVal;
            this.setLabel();
            if(this.m_Callback != null)
            {
               this.m_Callback();
            }
            return;
         }
         this.setLabel();
      }
      
      private function setLabel() : void
      {
         if(this.m_MaxTextWidth > 0 && this.m_TextObj.textWidth > this.m_MaxTextWidth)
         {
            this.fitLabel();
         }
         this.m_TextObj.htmlText = this.m_Prefix + MiscHelpers.insertNumericalSeparator(this.m_SourceVal,this.m_Separator);
      }
      
      private function fitLabel() : void
      {
         var fmt:TextFormat = this.m_TextObj.getTextFormat();
         var size:Number = fmt.size as Number;
         var width:Number = this.m_TextObj.textWidth;
         while(width >= this.m_MaxTextWidth)
         {
            fmt.size = --size;
            this.m_TextObj.defaultTextFormat = fmt;
            this.m_TextObj.text = this.m_Prefix + MiscHelpers.insertNumericalSeparator(this.m_SourceVal,this.m_Separator);
            width = this.m_TextObj.textWidth;
         }
      }
   }
}
