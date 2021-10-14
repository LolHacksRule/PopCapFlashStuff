package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BarController extends Sprite
   {
       
      
      public var barWidth:int = 0;
      
      public var barHeight:int = 0;
      
      private var baseBar:BarSprite;
      
      private var bonusBar:BarSprite;
      
      private var _totalValue:int = 0;
      
      private var _baseValue:int = 0;
      
      private var _speedValue:int = 0;
      
      private var _numMultis:int = 0;
      
      private var _tooltip:TooltipPopup;
      
      private var _isHurrah:Boolean = false;
      
      private var m_App:Blitz3App;
      
      public function BarController(app:Blitz3App, tooltip:TooltipPopup, w:int, isHurrah:Boolean = false)
      {
         super();
         this.m_App = app;
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
         this.baseBar.x = -(w * 0.5);
         this.bonusBar.x = -(w * 0.5);
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
      
      public function SetScale(max:int, min:int) : void
      {
         var basePercent:Number = Math.max(0,(this._baseValue - min) / (max - min));
         var speedPercent:Number = Math.max(0,(this._speedValue - min) / (max - min));
         var baseHeight:int = basePercent * this.barHeight;
         var speedHeight:int = speedPercent * this.barHeight;
         this.baseBar.SetHeight(baseHeight);
         this.bonusBar.SetHeight(speedHeight);
         this.bonusBar.y = -baseHeight;
      }
      
      public function GetTotalValue() : int
      {
         return this._totalValue;
      }
      
      public function AddMultiplier(value:int, color:int) : void
      {
         var multiplier:MultiSprite = new MultiSprite(this.m_App);
         multiplier.SetNumber(value);
         multiplier.SetColor(color);
         multiplier.addEventListener(MouseEvent.ROLL_OVER,this.StyleMultiTip);
         multiplier.addEventListener(MouseEvent.ROLL_OUT,this.HideTooltip);
         addChild(multiplier);
         ++this._numMultis;
      }
      
      public function LayoutMultipliers() : void
      {
         var child:DisplayObject = null;
         var multiIndex:int = 0;
         for(var i:int = 0; i < numChildren; i++)
         {
            child = getChildAt(i);
            if(child is MultiSprite)
            {
               child.y = this.bonusBar.y - this.bonusBar.height - child.height * 0.5;
               child.x = 6 * multiIndex - (this._numMultis - 1) * 3;
               multiIndex++;
            }
         }
      }
      
      private function StyleHurrahPopup(e:MouseEvent) : void
      {
         this._tooltip.x = parent.x + this.x - this.baseBar.width * 0.5 + 4;
         this._tooltip.y = parent.y + this.y - this.baseBar.height + 4;
         this._tooltip.points.SetContent(PointPopup.HURRAH_BUBBLE,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_LAST_HURRAH),this._baseValue);
         this._tooltip.ShowPoints();
      }
      
      private function StyleBasePopup(e:MouseEvent) : void
      {
         this._tooltip.x = parent.x + this.x - this.baseBar.width * 0.5 + 4;
         this._tooltip.y = parent.y + this.y - this.baseBar.height + 4;
         this._tooltip.points.SetContent(PointPopup.BASE_BUBBLE,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_POINTS),this._baseValue);
         this._tooltip.ShowPoints();
      }
      
      private function StyleBonusPopup(e:MouseEvent) : void
      {
         this._tooltip.x = parent.x + this.x - this.bonusBar.width * 0.5 + 4;
         this._tooltip.y = parent.y + this.y - this.baseBar.height - this.bonusBar.height + 4;
         this._tooltip.points.SetContent(PointPopup.BONUS_BUBBLE,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_SPEED),this._speedValue);
         this._tooltip.ShowPoints();
      }
      
      private function StyleMultiTip(e:MouseEvent) : void
      {
         var multi:MultiSprite = null;
         multi = e.target as MultiSprite;
         this._tooltip.x = parent.x + this.x + multi.x;
         this._tooltip.y = parent.y + this.y + multi.y;
         var tipText:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_GAMESTATS_MULTIPLIED);
         tipText = tipText.replace("%s",multi.GetNumber());
         this._tooltip.legend.SetLabel(tipText);
         this._tooltip.ShowLegend();
      }
      
      private function HideTooltip(e:MouseEvent) : void
      {
         this._tooltip.Hide();
      }
   }
}
