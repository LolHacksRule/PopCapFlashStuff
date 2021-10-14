package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class CircleHighlightData extends HighlightData
   {
       
      
      public var radius:Number = 0;
      
      public function CircleHighlightData(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:Boolean)
      {
         super(param1,param2,param4,param5);
         this.radius = param3;
      }
      
      override public function DrawHighlight(param1:Graphics) : void
      {
         param1.clear();
         param1.beginFill(16777215,1);
         param1.drawCircle(x,y,this.radius);
         param1.endFill();
      }
      
      override public function GetBounds() : Rectangle
      {
         return new Rectangle(x - this.radius,y - this.radius,this.radius * 2,this.radius * 2);
      }
   }
}
