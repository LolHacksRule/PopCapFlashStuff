package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   
   public class BarSprite extends Sprite
   {
       
      
      private var top:Shape;
      
      private var bottom:Shape;
      
      private var middle:Shape;
      
      public function BarSprite(width:int, baseColor:int, glowColor1:int, glowColor2:int)
      {
         super();
         mouseChildren = false;
         this.top = new Shape();
         this.top.graphics.beginFill(baseColor);
         this.top.graphics.drawRoundRectComplex(0,0,width,2,2,2,0,0);
         this.top.graphics.endFill();
         this.bottom = new Shape();
         this.bottom.graphics.beginFill(baseColor);
         this.bottom.graphics.drawRoundRectComplex(0,0,width,2,0,0,2,2);
         this.bottom.graphics.endFill();
         this.middle = new Shape();
         this.middle.graphics.beginFill(baseColor);
         this.middle.graphics.drawRect(0,0,width,1);
         this.middle.graphics.endFill();
         addChild(this.bottom);
         addChild(this.top);
         addChild(this.middle);
         filters = [new GlowFilter(glowColor1,1,16,16,2,1,true,false),new GlowFilter(glowColor2,1,4,4,2,1,true,false)];
      }
      
      public function SetHeight(height:int) : void
      {
         this.bottom.y = 0;
         this.middle.y = -height;
         this.middle.scaleY = height;
         this.top.y = -height - this.top.height;
      }
   }
}
