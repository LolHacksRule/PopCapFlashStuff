package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   
   public class RectHighlightData extends HighlightData
   {
       
      
      public var width:Number = 0;
      
      public var height:Number = 0;
      
      public function RectHighlightData(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean, param6:Boolean)
      {
         super(param1,param2,param5,param6);
         this.width = param3;
         this.height = param4;
      }
      
      override public function DrawHighlight(param1:Graphics) : void
      {
         param1.clear();
         param1.beginFill(16777215,1);
         param1.drawRect(x,y,this.width,this.height);
         param1.endFill();
      }
      
      override public function GetBounds() : Rectangle
      {
         return new Rectangle(x,y,this.width,this.height);
      }
   }
}
