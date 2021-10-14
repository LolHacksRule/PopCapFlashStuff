package com.popcap.flash.bejeweledblitz.friendscore.view.messages
{
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class FadingText extends Sprite
   {
      
      public static const FADE_TIME:Number = 0.75;
       
      
      protected var m_TextFields:Vector.<TextField>;
      
      protected var m_CurActive:int;
      
      protected var m_CurInactive:int;
      
      protected var m_Curve:LinearSampleCurvedVal;
      
      protected var m_CurvePos:Number;
      
      protected var m_IsFading:Boolean;
      
      public function FadingText()
      {
         var i:int = 0;
         var text:TextField = null;
         var format:TextFormat = null;
         super();
         this.m_TextFields = new Vector.<TextField>(2);
         for(i = 0; i < 2; i++)
         {
            text = new TextField();
            format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,15,16777215);
            format.align = TextFormatAlign.LEFT;
            text.defaultTextFormat = format;
            text.autoSize = TextFieldAutoSize.LEFT;
            text.embedFonts = true;
            text.selectable = false;
            text.mouseEnabled = false;
            text.htmlText = "";
            text.x = 0;
            text.y = 0;
            text.filters = [new GlowFilter(5701677,1,3,3,6.59),new GlowFilter(8519751,1,5,5,2.03)];
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
         addChild(this.m_TextFields[this.m_CurActive]);
         this.m_TextFields[this.m_CurActive].x = this.m_TextFields[this.m_CurActive].width * -0.5;
         this.m_TextFields[this.m_CurActive].y = this.m_TextFields[this.m_CurActive].height * -0.5;
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
               removeChild(this.m_TextFields[this.m_CurInactive]);
            }
         }
      }
      
      public function FadeTo(nextString:String) : void
      {
         var inactive:TextField = null;
         inactive = this.m_TextFields[this.m_CurInactive];
         addChild(inactive);
         inactive.htmlText = nextString;
         inactive.x = inactive.width * -0.5;
         inactive.y = inactive.height * -0.5;
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
