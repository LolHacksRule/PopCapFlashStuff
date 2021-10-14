package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class CompoundHighlightData extends HighlightData
   {
       
      
      private var mouseBounds:Rectangle;
      
      private var rectShapes:Vector.<Rectangle>;
      
      public function CompoundHighlightData(param1:Vector.<Rectangle>, param2:Rectangle, param3:Boolean, param4:Boolean)
      {
         this.rectShapes = param1;
         this.mouseBounds = param2;
         super(this.mouseBounds.x,this.mouseBounds.y,param3,param4);
      }
      
      override public function DrawHighlight(param1:Graphics) : void
      {
         param1.clear();
         if(this.rectShapes.length == 2)
         {
            param1.beginFill(16777215,1);
            param1.drawRect(0,0,510,419);
            param1.drawRect(0,419,172,132);
         }
         else if(this.rectShapes.length == 3)
         {
            param1.beginFill(16777215,1);
            param1.drawRect(0,0,510,419);
            param1.drawRect(510,0,345,419);
            param1.drawRect(0,419,172,132);
         }
         param1.endFill();
      }
      
      override public function GetBounds() : Rectangle
      {
         return new Rectangle(this.mouseBounds.x,this.mouseBounds.y,this.mouseBounds.width,this.mouseBounds.height);
      }
   }
}
