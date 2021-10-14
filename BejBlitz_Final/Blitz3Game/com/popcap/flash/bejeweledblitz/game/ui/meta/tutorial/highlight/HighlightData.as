package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class HighlightData
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var mouseEnabled:Boolean = true;
      
      public var fillWholeBackground:Boolean = false;
      
      public function HighlightData(param1:Number, param2:Number, param3:Boolean, param4:Boolean)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.mouseEnabled = param3;
         this.fillWholeBackground = param4;
      }
      
      public function DrawHighlight(param1:Graphics) : void
      {
         param1.clear();
      }
      
      public function GetBounds() : Rectangle
      {
         return new Rectangle(this.x,this.y,0,0);
      }
   }
}
