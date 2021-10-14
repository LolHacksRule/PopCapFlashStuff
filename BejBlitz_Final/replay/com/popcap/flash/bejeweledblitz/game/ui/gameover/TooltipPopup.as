package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Sprite;
   
   public class TooltipPopup extends Sprite
   {
       
      
      public var legend:LegendPopup;
      
      public var points:PointPopup;
      
      public function TooltipPopup(app:Blitz3App)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.legend = new LegendPopup(app);
         this.points = new PointPopup(app);
         this.legend.visible = false;
         this.points.visible = false;
         addChild(this.legend);
         addChild(this.points);
      }
      
      public function Hide() : void
      {
         this.legend.visible = false;
         this.points.visible = false;
      }
      
      public function ShowLegend() : void
      {
         this.legend.visible = true;
         this.points.visible = false;
      }
      
      public function ShowPoints() : void
      {
         this.legend.visible = false;
         this.points.visible = true;
      }
   }
}
