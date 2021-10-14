package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class CircleHighlightData extends HighlightData
   {
       
      
      public var radius:Number = 0;
      
      public function CircleHighlightData(xPos:Number, yPos:Number, r:Number, mouseAllowed:Boolean)
      {
         super(xPos,yPos,mouseAllowed);
         this.radius = r;
      }
      
      override public function DrawHighlight(g:Graphics) : void
      {
         g.clear();
         g.beginFill(16777215,1);
         g.drawCircle(x,y,this.radius);
         g.endFill();
      }
      
      override public function GetBounds() : Rectangle
      {
         return new Rectangle(x - this.radius,y - this.radius,this.radius * 2,this.radius * 2);
      }
   }
}
