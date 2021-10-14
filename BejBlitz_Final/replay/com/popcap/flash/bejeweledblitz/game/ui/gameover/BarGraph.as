package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzScoreKeeper;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import flash.display.Sprite;
   
   public class BarGraph extends Sprite
   {
      
      private static const NUM_BARS:int = 7;
      
      private static const WIDTHS:Array = [[22,22,22,22,22,22,22],[22,22,22,22,22,22,22,22]];
      
      private static const POSITIONS:Array = [[4,37,70,103,136,169,202],[4,33,61,90,119,146,175,202]];
       
      
      public var ticks:Array;
      
      public var tooltip:TooltipPopup;
      
      private var m_App:Blitz3App;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _pointBars:Array;
      
      public function BarGraph(app:Blitz3App)
      {
         this.ticks = [];
         this._pointBars = [];
         super();
         this.m_App = app;
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
         if(this.m_App.logic.timerLogic.GetGameDuration() > BlitzLogic.BASE_GAME_DURATION)
         {
            widths = WIDTHS[1];
            positions = POSITIONS[1];
            numBars++;
         }
         var spaceWidth:int = this._width / numBars;
         var barOffset:int = spaceWidth * 0.5;
         var barWidth:int = spaceWidth - 16;
         for(var i:int = 0; i < numBars; i++)
         {
            bar = new BarController(this.m_App,this.tooltip,widths[i],i == numBars - 1);
            bar.barHeight = this._height;
            bar.barWidth = widths[i];
            bar.x = -4 + positions[i] + widths[i] * 0.5;
            bar.y = this._height;
            this._pointBars[i] = bar;
            addChild(bar);
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
            isHurrah = value.HasTag(BlitzScoreKeeper.TAG_LASTHURRAH);
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
         this.AddMultipliers();
      }
      
      private function UpdateScale() : void
      {
         var cap:int = 0;
         var numTicks:int = 0;
         var i:int = 0;
         var value:int = 0;
         var v:Number = NaN;
         var maxPoints:Number = Number.MIN_VALUE;
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
      
      private function AddMultipliers() : void
      {
         var bar:BarController = null;
         var useData:Object = null;
         var timestep:Number = NaN;
         var fraction:int = 0;
         var bars:Vector.<BarController> = new Vector.<BarController>();
         for each(useData in this.m_App.logic.multiLogic.used)
         {
            if(useData)
            {
               timestep = this.m_App.logic.timerLogic.GetGameDuration() / (this._pointBars.length - 1);
               fraction = Math.floor(useData.time / timestep);
               if(fraction == this._pointBars.length - 1)
               {
                  fraction--;
               }
               bar = this._pointBars[fraction];
               bar.AddMultiplier(useData.number,useData.color);
               if(bars.indexOf(bar) == -1)
               {
                  bars.push(bar);
               }
            }
         }
         for each(bar in bars)
         {
            bar.LayoutMultipliers();
         }
      }
   }
}
