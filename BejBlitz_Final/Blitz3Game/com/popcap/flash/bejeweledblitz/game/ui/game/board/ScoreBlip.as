package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreData;
   import com.popcap.flash.framework.misc.CurvedVal;
   import com.popcap.flash.framework.misc.LinearCurvedVal;
   import com.popcap.flash.framework.misc.LinearListCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ScoreBlip extends TextField
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
      
      private var _glow:GlowFilter;
      
      public var scale:Number = 1.0;
      
      public var yDelta:Number = 0;
      
      private var _life:int = 0;
      
      private var _scaleBase:Number = 1.0;
      
      private var _scaleFactor:Number = 1.0;
      
      private var _isCycled:Boolean = false;
      
      private var _redCurve:CurvedVal = null;
      
      private var _greenCurve:CurvedVal = null;
      
      private var _blueCurve:CurvedVal = null;
      
      private var _veloVariable:Number = 0.0;
      
      private var _colorOffset:Number = 0;
      
      private var _scoreData:ScoreData;
      
      private var _isLQMode:Boolean = false;
      
      public function ScoreBlip(param1:ScoreData, param2:Boolean)
      {
         super();
         this._isLQMode = param2;
         this._scoreData = param1;
         mouseEnabled = false;
         this._redCurve = new LinearCurvedVal();
         this._greenCurve = new LinearCurvedVal();
         this._blueCurve = new LinearCurvedVal();
         defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,20,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         autoSize = TextFieldAutoSize.CENTER;
         selectable = false;
         mouseEnabled = false;
         embedFonts = true;
         width = 100;
         height = 24;
         if(!this._isLQMode)
         {
            this._glow = new GlowFilter(0,1,3,3,10,2,false,true);
         }
         this._veloVariable = Math.random() * FLOAT_VELOCITY;
         this._colorOffset = Math.random() * 100;
         this.SetColor(this._scoreData.color,this._scoreData.isFlashy);
         this.Init(param1);
         cacheAsBitmap = true;
      }
      
      public function Init(param1:ScoreData) : void
      {
         this._life = 100;
         htmlText = param1.value.toString();
      }
      
      public function Update() : void
      {
         if(this._life == 0)
         {
            parent.removeChild(this);
            return;
         }
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         if(!this._isLQMode)
         {
            if(this._isCycled)
            {
               _loc1_ = 1 - this._life / 50 % 1;
               _loc2_ = (_loc1_ + this._colorOffset) % 1;
               this._glow.color = this.GetColor(_loc2_);
               filters = [this._glow];
            }
            else
            {
               _loc1_ = (this._life + this._colorOffset) / 50;
               _loc2_ = Math.abs(Math.sin(_loc1_ * Math.PI));
               this._glow.color = this.GetColor(_loc2_);
               filters = [this._glow];
            }
         }
         if(this._life < 25)
         {
            this._scaleBase = this._life / 25;
         }
         else
         {
            this._scaleBase = 1;
         }
         this._scaleFactor = 1;
         if(this._isCycled)
         {
            this._scaleFactor += 0.2;
         }
         var _loc3_:Number = this._scaleBase * this._scaleFactor;
         scaleX = _loc3_;
         scaleY = _loc3_;
         if(this._life > 0)
         {
            --this._life;
         }
         this.yDelta += FLOAT_VELOCITY + this._veloVariable;
         if(this._isCycled)
         {
            this.yDelta += FLOAT_VELOCITY;
         }
         y = this.yDelta + this._scoreData.y * 40 + 20 + height * -0.5;
         x = this._scoreData.x * 40 + 20 + width * -0.5;
      }
      
      private function SetColor(param1:int, param2:Boolean = false) : void
      {
         this._isCycled = param2;
         switch(param1)
         {
            case Gem.COLOR_RED:
               this._redCurve.setOutRange(255,192);
               this._greenCurve.setOutRange(64,0);
               this._blueCurve.setOutRange(64,0);
               this._colorOffset = 0 / 7;
               break;
            case Gem.COLOR_ORANGE:
               this._redCurve.setOutRange(255,192);
               this._greenCurve.setOutRange(160,96);
               this._blueCurve.setOutRange(64,0);
               this._colorOffset = 1 / 7;
               break;
            case Gem.COLOR_YELLOW:
               this._redCurve.setOutRange(255,192);
               this._greenCurve.setOutRange(255,192);
               this._blueCurve.setOutRange(64,0);
               this._colorOffset = 2 / 7;
               break;
            case Gem.COLOR_GREEN:
               this._redCurve.setOutRange(64,0);
               this._greenCurve.setOutRange(255,192);
               this._blueCurve.setOutRange(64,0);
               this._colorOffset = 3 / 7;
               break;
            case Gem.COLOR_BLUE:
               this._redCurve.setOutRange(64,0);
               this._greenCurve.setOutRange(160,96);
               this._blueCurve.setOutRange(255,192);
               this._colorOffset = 4 / 7;
               break;
            case Gem.COLOR_PURPLE:
               this._redCurve.setOutRange(255,192);
               this._greenCurve.setOutRange(64,0);
               this._blueCurve.setOutRange(255,192);
               this._colorOffset = 5 / 7;
               break;
            case Gem.COLOR_WHITE:
               this._redCurve.setOutRange(255,192);
               this._greenCurve.setOutRange(255,192);
               this._blueCurve.setOutRange(255,192);
               this._colorOffset = 6 / 7;
               break;
            default:
               this._redCurve.setOutRange(255,192);
               this._greenCurve.setOutRange(255,192);
               this._blueCurve.setOutRange(255,192);
               this._colorOffset = 7 / 7;
         }
         if(param2)
         {
            this._redCurve = RED_CYCLE;
            this._greenCurve = GREEN_CYCLE;
            this._blueCurve = BLUE_CYCLE;
         }
         textColor = 16777215;
         if(!this._isLQMode)
         {
            this._glow.color = this.GetColor(0);
            filters = [this._glow];
         }
      }
      
      private function GetColor(param1:Number) : int
      {
         if(this._isCycled)
         {
            return int(RED_CYCLE.getOutValue(param1)) << 16 | int(GREEN_CYCLE.getOutValue(param1)) << 8 | int(BLUE_CYCLE.getOutValue(param1)) << 0;
         }
         return 0 | int(this._redCurve.getOutValue(param1)) << 16 | int(this._greenCurve.getOutValue(param1)) << 8 | int(this._blueCurve.getOutValue(param1)) << 0;
      }
   }
}
