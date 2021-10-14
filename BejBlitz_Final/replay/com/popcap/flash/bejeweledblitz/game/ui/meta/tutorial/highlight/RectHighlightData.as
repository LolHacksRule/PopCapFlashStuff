package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class RectHighlightData extends HighlightData
   {
       
      
      public var width:Number = 0;
      
      public var height:Number = 0;
      
      public function RectHighlightData(xPos:Number, yPos:Number, w:Number, h:Number, mouseAllowed:Boolean)
      {
         super(xPos,yPos,mouseAllowed);
         this.width = w;
         this.height = h;
      }
      
      override public function DrawHighlight(g:Graphics) : void
      {
         g.clear();
         g.beginFill(16777215,1);
         g.drawRect(x,y,this.width,this.height);
         g.endFill();
      }
      
      override public function GetBounds() : Rectangle
      {
         return new Rectangle(x,y,this.width,this.height);
      }
   }
}
