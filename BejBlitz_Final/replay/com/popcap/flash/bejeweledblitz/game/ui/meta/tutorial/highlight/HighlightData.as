package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class HighlightData
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var mouseEnabled:Boolean = true;
      
      public function HighlightData(xPos:Number, yPos:Number, mouseAllowed:Boolean)
      {
         super();
         this.x = xPos;
         this.y = yPos;
         this.mouseEnabled = mouseAllowed;
      }
      
      public function DrawHighlight(g:Graphics) : void
      {
         g.clear();
      }
      
      public function GetBounds() : Rectangle
      {
         return new Rectangle(this.x,this.y,0,0);
      }
   }
}
