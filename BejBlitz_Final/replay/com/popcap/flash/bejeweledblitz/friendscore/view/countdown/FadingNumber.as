package com.popcap.flash.bejeweledblitz.friendscore.view.countdown
{
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class FadingNumber extends Sprite
   {
      
      public static const FADE_TIME:Number = 0.75;
       
      
      protected var m_TextFields:Vector.<TextField>;
      
      protected var m_CurActive:int;
      
      protected var m_CurInactive:int;
      
      protected var m_Curve:LinearSampleCurvedVal;
      
      protected var m_CurvePos:Number;
      
      protected var m_IsFading:Boolean;
      
      public function FadingNumber()
      {
         var i:int = 0;
         var text:TextField = null;
         var format:TextFormat = null;
         super();
         this.m_TextFields = new Vector.<TextField>(2);
         for(i = 0; i < 2; i++)
         {
            text = new TextField();
            format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,17.5,2960685);
            format.align = TextFormatAlign.LEFT;
            text.defaultTextFormat = format;
            text.autoSize = TextFieldAutoSize.LEFT;
            text.embedFonts = true;
            text.selectable = false;
            text.mouseEnabled = false;
            text.htmlText = "00";
            text.x = 0;
            text.y = 0;
            this.m_TextFields[i] = text;
         }
         this.m_CurActive = 0;
         this.m_CurInactive = 1;
         this.m_TextFields[this.m_CurInactive].alpha = 0;
         this.m_Curve = new LinearSampleCurvedVal();
         this.m_Curve.setInRange(0,FADE_TIME);
         this.m_Curve.setOutRange(1,0);
         this.m_CurvePos = 0;
         this.m_IsFading = false;
      }
      
      public function Init() : void
      {
         var text:TextField = null;
         for each(text in this.m_TextFields)
         {
            addChild(text);
         }
      }
      
      public function Update(dt:Number) : void
      {
         if(this.m_IsFading)
         {
            this.m_CurvePos += dt;
            this.m_TextFields[this.m_CurActive].alpha = this.m_Curve.getOutValue(this.m_CurvePos);
            this.m_TextFields[this.m_CurInactive].alpha = 1 - this.m_Curve.getOutValue(this.m_CurvePos);
            if(this.m_CurvePos >= FADE_TIME)
            {
               this.m_IsFading = false;
               this.SwapActive();
            }
         }
      }
      
      public function FadeTo(nextNumber:int) : void
      {
         var content:String = "" + nextNumber;
         if(nextNumber < 10)
         {
            content = "0" + content;
         }
         this.m_TextFields[this.m_CurInactive].htmlText = content;
         this.m_IsFading = true;
         this.m_CurvePos = 0;
      }
      
      protected function SwapActive() : void
      {
         var tmp:int = this.m_CurActive;
         this.m_CurActive = this.m_CurInactive;
         this.m_CurInactive = tmp;
      }
   }
}
