package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.ScoreValue;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   
   public class BarGraph extends Sprite
   {
      
      private static const NUM_BARS:int = 7;
      
      private static const WIDTHS:Array = [[22,22,22,22,22,22,22],[22,22,22,22,22,22,22,22]];
      
      private static const POSITIONS:Array = [[4,37,70,103,136,169,202],[4,33,61,90,119,146,175,202]];
       
      
      public var ticks:Array;
      
      public var tooltip:TooltipPopup;
      
      private var _app:Blitz3App;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _pointBars:Array;
      
      private var _isGrowing:Boolean = true;
      
      public function BarGraph(app:Blitz3App)
      {
         this.ticks = [];
         this._pointBars = [];
         super();
         this._app = app;
         this.tooltip = new TooltipPopup(app);
         this.tooltip.Hide();
      }
      
      public function Init(w:int, h:int) : void
      {
         this._width = w;
         this._height = h;
         this.Reset();
      }
      
      public function Reset() : void
      {
         var bar:BarController = null;
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         this._pointBars.length = 0;
         var numBars:int = NUM_BARS;
         var widths:Array = WIDTHS[0];
         var positions:Array = POSITIONS[0];
         if(this._app.logic.timerLogic.GetGameDuration() > BlitzLogic.BASE_GAME_DURATION)
         {
            widths = WIDTHS[1];
            positions = POSITIONS[1];
            numBars++;
         }
         var spaceWidth:int = this._width / numBars;
         var barOffset:int = spaceWidth / 2;
         var barWidth:int = spaceWidth - 16;
         for(var i:int = 0; i < numBars; i++)
         {
            bar = new BarController(this._app,this.tooltip,widths[i],i == numBars - 1);
            bar.barHeight = this._height;
            bar.barWidth = widths[i];
            bar.x = -4 + positions[i] + widths[i] / 2;
            bar.y = this._height;
            this._pointBars[i] = bar;
            addChild(bar);
         }
      }
      
      public function Update() : void
      {
         var bar:BarController = null;
         if(!this._isGrowing)
         {
            return;
         }
         var numBars:int = this._pointBars.length;
         for(var i:int = 0; i < numBars; i++)
         {
            bar = this._pointBars[i];
            bar.Update();
            if(i < numBars - 1 && bar.GetGrowthPercent() > 0.5)
            {
               this._pointBars[i + 1].StartGrowing();
            }
         }
      }
      
      public function SetScores(values:Vector.<ScoreValue>, maxTime:int) : void
      {
         var value:ScoreValue = null;
         var time:int = 0;
         var isHurrah:Boolean = false;
         var barIndex:int = 0;
         var bar:BarController = null;
         this.Reset();
         var numBars:int = this._pointBars.length - 1;
         var hurrahBar:BarController = this._pointBars[this._pointBars.length - 1];
         for each(value in values)
         {
            time = value.GetTime();
            isHurrah = value.HasTag("LastHurrah");
            barIndex = int(time / maxTime * numBars);
            barIndex = Math.min(barIndex,numBars - 1);
            bar = this._pointBars[barIndex];
            if(isHurrah)
            {
               bar = hurrahBar;
            }
            bar.AddValue(value);
         }
         this.UpdateScale();
      }
      
      public function AddMultiplier(time:int, value:int, color:int) : void
      {
         var timestep:Number = this._app.logic.timerLogic.GetGameDuration() / (this._pointBars.length - 1);
         var fraction:int = int(time / timestep);
         var bar:BarController = this._pointBars[fraction];
         bar.AddMultiplier(value,color);
         this.UpdateScale();
      }
      
      private function UpdateScale() : void
      {
         var cap:int = 0;
         var numTicks:int = 0;
         var i:int = 0;
         var value:int = 0;
         var v:Number = NaN;
         var maxPoints:Number = Number.MIN_VALUE;
         var minPoints:Number = 0;
         var bar:BarController = null;
         for each(bar in this._pointBars)
         {
            value = bar.GetTotalValue();
            maxPoints = Math.max(maxPoints,value);
         }
         cap = Math.ceil(maxPoints / 5000);
         cap = cap % 2 == 1 ? int(cap + 1) : int(cap);
         cap *= 5000;
         for each(bar in this._pointBars)
         {
            bar.SetScale(cap,0);
         }
         numTicks = 2;
         for(i = 0; i <= numTicks; i++)
         {
            v = int(i * cap / numTicks);
            this.ticks[i] = v;
         }
      }
   }
}
