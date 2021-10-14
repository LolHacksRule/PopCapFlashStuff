package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   
   public class §_-S3§ extends Sprite
   {
       
      
      private var §_-Hk§:Sprite;
      
      private var bottom:Sprite;
      
      private var top:Sprite;
      
      public function §_-S3§(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         mouseChildren = false;
         this.top = new Sprite();
         this.top.graphics.beginFill(param2);
         this.top.graphics.drawRoundRectComplex(0,0,param1,2,2,2,0,0);
         this.top.graphics.endFill();
         this.bottom = new Sprite();
         this.bottom.graphics.beginFill(param2);
         this.bottom.graphics.drawRoundRectComplex(0,0,param1,2,0,0,2,2);
         this.bottom.graphics.endFill();
         this.§_-Hk§ = new Sprite();
         this.§_-Hk§.graphics.beginFill(param2);
         this.§_-Hk§.graphics.drawRect(0,0,param1,1);
         this.§_-Hk§.graphics.endFill();
         addChild(this.bottom);
         addChild(this.top);
         addChild(this.§_-Hk§);
         filters = [new GlowFilter(param3,1,16,16,2,1,true,false),new GlowFilter(param4,1,4,4,2,1,true,false)];
      }
      
      public function §_-Dt§(param1:int) : void
      {
         this.bottom.y = 0;
         this.§_-Hk§.y = -param1;
         this.§_-Hk§.scaleY = param1;
         this.top.y = -param1 - this.top.height;
      }
   }
}
