package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.bej3.blitz.ScoreValue;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BarController extends Sprite
   {
       
      
      public var barWidth:int = 0;
      
      public var barHeight:int = 0;
      
      public var baseBar:BarSprite;
      
      public var bonusBar:BarSprite;
      
      private var _totalValue:int = 0;
      
      private var _baseValue:int = 0;
      
      private var _speedValue:int = 0;
      
      private var _tooltip:TooltipPopup;
      
      private var _multipliers:Array;
      
      private var _isHurrah:Boolean = false;
      
      private var _app:Blitz3App;
      
      public function BarController(app:Blitz3App, tooltip:TooltipPopup, w:int, isHurrah:Boolean = false)
      {
         this._multipliers = [];
         super();
         this._app = app;
         this._tooltip = tooltip;
         var base:int = 13369497;
         var glow1:int = 14964965;
         var glow2:int = 16225279;
         this._isHurrah = isHurrah;
         if(isHurrah)
         {
            base = 2986450;
            glow1 = 52223;
            glow2 = 10092543;
         }
         this.baseBar = new BarSprite(w,base,glow1,glow2);
         this.bonusBar = new BarSprite(w,15641361,16446275,16776135);
         this.baseBar.x = -(w / 2);
         this.bonusBar.x = -(w / 2);
         if(this._isHurrah)
         {
            this.baseBar.addEventListener(MouseEvent.ROLL_OVER,this.StyleHurrahPopup);
         }
         else
         {
            this.baseBar.addEventListener(MouseEvent.ROLL_OVER,this.StyleBasePopup);
         }
         this.bonusBar.addEventListener(MouseEvent.ROLL_OVER,this.StyleBonusPopup);
         this.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         addChild(this.bonusBar);
         addChild(this.baseBar);
      }
      
      public function Update() : void
      {
      }
      
      public function StartGrowing() : void
      {
      }
      
      public function GetGrowthPercent() : Number
      {
         return 1;
      }
      
      public function AddValue(value:ScoreValue) : void
      {
         this._totalValue += value.GetValue();
         if(value.HasTag("Speed"))
         {
            this._speedValue += value.GetValue();
         }
         else
         {
            this._baseValue += value.GetValue();
         }
      }
      
      public function AddMultiplier(value:int, color:int) : void
      {
         var multiplier:MultiSprite = new MultiSprite();
         multiplier.SetNumber(value);
         multiplier.SetColor(color);
         addChild(multiplier);
         multiplier.addEventListener(MouseEvent.ROLL_OVER,this.StyleMultiTip);
         multiplier.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         this._multipliers.push(multiplier);
      }
      
      public function SetScale(max:int, min:int) : void
      {
         var multi:MultiSprite = null;
         var basePercent:Number = Math.max(0,(this._baseValue - min) / (max - min));
         var speedPercent:Number = Math.max(0,(this._speedValue - min) / (max - min));
         var baseHeight:int = basePercent * this.barHeight;
         var speedHeight:int = speedPercent * this.barHeight;
         this.baseBar.SetHeight(baseHeight);
         this.bonusBar.SetHeight(speedHeight);
         this.bonusBar.y = -baseHeight;
         var numMultis:int = this._multipliers.length;
         for(var i:int = 0; i < numMultis; i++)
         {
            multi = this._multipliers[i];
            multi.y = this.bonusBar.y - speedHeight - multi.height / 2;
            multi.x = 6 * i - (numMultis - 1) * 3;
         }
      }
      
      public function GetTotalValue() : int
      {
         return this._totalValue;
      }
      
      private function StyleHurrahPopup(e:MouseEvent) : void
      {
         this._tooltip.x = parent.x + this.x - this.baseBar.width / 2 + 4;
         this._tooltip.y = parent.y + this.y - this.baseBar.height + 4;
         this._tooltip.points.label.htmlText = this._app.locManager.GetLocString("UI_GAMESTATS_LAST_HURRAH");
         this._tooltip.points.SetBubble(PointPopup.HURRAH_BUBBLE);
         this._tooltip.points.SetPoints(this._baseValue);
         this._tooltip.ShowPoints();
      }
      
      private function StyleBasePopup(e:MouseEvent) : void
      {
         this._tooltip.x = parent.x + this.x - this.baseBar.width / 2 + 4;
         this._tooltip.y = parent.y + this.y - this.baseBar.height + 4;
         this._tooltip.points.label.htmlText = this._app.locManager.GetLocString("UI_GAMESTATS_POINTS");
         this._tooltip.points.SetBubble(PointPopup.BASE_BUBBLE);
         this._tooltip.points.SetPoints(this._baseValue);
         this._tooltip.ShowPoints();
      }
      
      private function StyleBonusPopup(e:MouseEvent) : void
      {
         this._tooltip.x = parent.x + this.x - this.bonusBar.width / 2 + 4;
         this._tooltip.y = parent.y + this.y - this.baseBar.height - this.bonusBar.height + 4;
         this._tooltip.points.label.htmlText = this._app.locManager.GetLocString("UI_GAMESTATS_SPEED");
         this._tooltip.points.SetBubble(PointPopup.BONUS_BUBBLE);
         this._tooltip.points.SetPoints(this._speedValue);
         this._tooltip.ShowPoints();
      }
      
      private function StyleMultiTip(e:MouseEvent) : void
      {
         var multi:MultiSprite = e.target as MultiSprite;
         this._tooltip.x = parent.x + this.x + multi.x;
         this._tooltip.y = parent.y + this.y + multi.y;
         var tipText:String = this._app.locManager.GetLocString("UI_GAMESTATS_MULTIPLIED");
         tipText = tipText.replace("%s",multi.GetNumber());
         this._tooltip.legend.label.htmlText = tipText;
         this._tooltip.ShowLegend();
      }
      
      private function HideTooltip(e:MouseEvent) : void
      {
         this._tooltip.Hide();
      }
   }
}
