package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.framework.misc.CurvedVal;
   import com.popcap.flash.framework.misc.LinearCurvedVal;
   import com.popcap.flash.framework.misc.LinearListCurvedVal;
   import com.popcap.flash.games.bej3.Gem;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ScoreBlipSprite extends Sprite
   {
      
      public static const FLOAT_VELOCITY:Number = -0.2;
      
      private static const RED_CYCLE:LinearListCurvedVal = new LinearListCurvedVal();
      
      private static const GREEN_CYCLE:LinearListCurvedVal = new LinearListCurvedVal();
      
      private static const BLUE_CYCLE:LinearListCurvedVal = new LinearListCurvedVal();
      
      {
         RED_CYCLE.values = Vector.<int>([255,192,255,0,0,255,255]);
         GREEN_CYCLE.values = Vector.<int>([0,96,255,255,0,0,255]);
         BLUE_CYCLE.values = Vector.<int>([0,0,0,0,255,255,255]);
      }
      
      private var mText:TextField;
      
      private var mGlow:GlowFilter;
      
      public var scale:Number = 1.0;
      
      private var mValue:int = 0;
      
      private var mLife:int = 0;
      
      private var mScaleBase:Number = 1.0;
      
      private var mScaleFactor:Number = 1.0;
      
      private var mIsCycled:Boolean = false;
      
      private var mRedCurve:CurvedVal = null;
      
      private var mGreenCurve:CurvedVal = null;
      
      private var mBlueCurve:CurvedVal = null;
      
      private var mVeloVariable:Number = 0.0;
      
      private var mColorOffset:Number = 0;
      
      public function ScoreBlipSprite()
      {
         super();
         mouseEnabled = false;
         this.mRedCurve = new LinearCurvedVal();
         this.mGreenCurve = new LinearCurvedVal();
         this.mBlueCurve = new LinearCurvedVal();
         var format:TextFormat = new TextFormat();
         format.font = Blitz3Fonts.BLITZ_STANDARD;
         format.size = 20;
         format.align = TextFormatAlign.CENTER;
         this.mGlow = new GlowFilter(0,1,3,3,10,2,false,true);
         this.mText = new TextField();
         this.mText.embedFonts = true;
         this.mText.textColor = 16777215;
         this.mText.defaultTextFormat = format;
         this.mText.width = 100;
         this.mText.height = 24;
         this.mText.x = -(this.mText.width / 2);
         this.mText.y = -(this.mText.height / 2) - 4;
         this.mVeloVariable = Math.random() * FLOAT_VELOCITY;
         this.mColorOffset = Math.random() * 100;
         addChild(this.mText);
         cacheAsBitmap = true;
      }
      
      public function SetValue(value:int) : void
      {
         this.mValue = value;
         this.mText.htmlText = this.mValue.toString();
      }
      
      public function SetLife(value:int) : void
      {
         this.mLife = value;
      }
      
      public function SetColor(color:int, cycleColors:Boolean = false) : void
      {
         this.mIsCycled = cycleColors;
         switch(color)
         {
            case Gem.COLOR_RED:
               this.mRedCurve.setOutRange(255,192);
               this.mGreenCurve.setOutRange(64,0);
               this.mBlueCurve.setOutRange(64,0);
               this.mColorOffset = 0 / 7;
               break;
            case Gem.COLOR_ORANGE:
               this.mRedCurve.setOutRange(255,192);
               this.mGreenCurve.setOutRange(160,96);
               this.mBlueCurve.setOutRange(64,0);
               this.mColorOffset = 1 / 7;
               break;
            case Gem.COLOR_YELLOW:
               this.mRedCurve.setOutRange(255,192);
               this.mGreenCurve.setOutRange(255,192);
               this.mBlueCurve.setOutRange(64,0);
               this.mColorOffset = 2 / 7;
               break;
            case Gem.COLOR_GREEN:
               this.mRedCurve.setOutRange(64,0);
               this.mGreenCurve.setOutRange(255,192);
               this.mBlueCurve.setOutRange(64,0);
               this.mColorOffset = 3 / 7;
               break;
            case Gem.COLOR_BLUE:
               this.mRedCurve.setOutRange(64,0);
               this.mGreenCurve.setOutRange(160,96);
               this.mBlueCurve.setOutRange(255,192);
               this.mColorOffset = 4 / 7;
               break;
            case Gem.COLOR_PURPLE:
               this.mRedCurve.setOutRange(255,192);
               this.mGreenCurve.setOutRange(64,0);
               this.mBlueCurve.setOutRange(255,192);
               this.mColorOffset = 5 / 7;
               break;
            case Gem.COLOR_WHITE:
               this.mRedCurve.setOutRange(255,192);
               this.mGreenCurve.setOutRange(255,192);
               this.mBlueCurve.setOutRange(255,192);
               this.mColorOffset = 6 / 7;
               break;
            default:
               this.mRedCurve.setOutRange(255,192);
               this.mGreenCurve.setOutRange(255,192);
               this.mBlueCurve.setOutRange(255,192);
               this.mColorOffset = 7 / 7;
         }
         if(cycleColors)
         {
            this.mRedCurve = RED_CYCLE;
            this.mGreenCurve = GREEN_CYCLE;
            this.mBlueCurve = BLUE_CYCLE;
         }
         this.mText.textColor = 16777215;
         this.mGlow.color = this.GetColor(0);
         filters = [this.mGlow];
      }
      
      public function GetValue() : int
      {
         return this.mValue;
      }
      
      private function GetColor(time:Number) : int
      {
         if(this.mIsCycled)
         {
            return int(RED_CYCLE.getOutValue(time)) << 16 | int(GREEN_CYCLE.getOutValue(time)) << 8 | int(BLUE_CYCLE.getOutValue(time)) << 0;
         }
         return int(0 | int(this.mRedCurve.getOutValue(time)) << 16 | int(this.mGreenCurve.getOutValue(time)) << 8 | int(this.mBlueCurve.getOutValue(time)) << 0);
      }
      
      public function Update() : void
      {
         if(this.mLife == 0)
         {
            return;
         }
         var pct:Number = 0;
         var t:Number = 0;
         if(this.mIsCycled)
         {
            pct = 1 - this.mLife / 50 % 1;
            t = (pct + this.mColorOffset) % 1;
            this.mGlow.color = this.GetColor(t);
            filters = [this.mGlow];
         }
         else
         {
            pct = (this.mLife + this.mColorOffset) / 50;
            t = Math.abs(Math.sin(pct * Math.PI));
            this.mGlow.color = this.GetColor(t);
            filters = [this.mGlow];
         }
         if(this.mLife > 0)
         {
            --this.mLife;
         }
         if(this.mLife < 25)
         {
            this.mScaleBase = this.mLife / 25;
         }
         else
         {
            this.mScaleBase = 1;
         }
         this.mScaleFactor = 1;
         if(this.mIsCycled)
         {
            this.mScaleFactor += 0.2;
         }
         var scale:Number = this.mScaleBase * this.mScaleFactor;
         scaleX = scale;
         scaleY = scale;
         y += FLOAT_VELOCITY + this.mVeloVariable;
         if(this.mIsCycled)
         {
            y += FLOAT_VELOCITY;
         }
      }
   }
}
