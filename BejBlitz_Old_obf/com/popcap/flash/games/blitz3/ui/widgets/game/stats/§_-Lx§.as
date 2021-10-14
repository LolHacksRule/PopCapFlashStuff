package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class §_-Lx§ extends Sprite
   {
       
      
      protected var §_-dF§:§_-jH§;
      
      protected var §_-4m§:Shape;
      
      protected var §_-3c§:TextField;
      
      public function §_-Lx§(param1:§_-0Z§)
      {
         super();
         this.§_-dF§ = new §_-jH§();
         this.§_-dF§.x = 2;
         this.§_-dF§.y = 2;
         this.§_-3c§ = new TextField();
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.color = 16777215;
         _loc2_.size = 18;
         _loc2_.font = Blitz3Fonts.§_-Un§;
         this.§_-3c§.defaultTextFormat = _loc2_;
         this.§_-3c§.embedFonts = true;
         this.§_-3c§.autoSize = TextFieldAutoSize.LEFT;
         this.§_-3c§.selectable = false;
         this.§_-3c§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.§_-3c§.text = param1.§_-JC§.GetLocString("UI_SUBMIT_SCORE");
         this.§_-3c§.x = this.§_-dF§.x + this.§_-dF§.width + 2;
         this.§_-3c§.y = this.§_-dF§.y + this.§_-dF§.height / 2 - this.§_-3c§.height / 2;
         addChild(this.§_-dF§);
         addChild(this.§_-3c§);
         this.§_-4m§ = new Shape();
         this.§_-4m§.graphics.beginFill(0,0.5);
         this.§_-4m§.graphics.drawRoundRect(0,0,width + 2,height,20);
         this.§_-4m§.graphics.endFill();
         addChildAt(this.§_-4m§,0);
      }
      
      public function Init() : void
      {
         this.§_-dF§.Init();
      }
      
      public function Reset() : void
      {
         this.§_-dF§.Reset();
      }
      
      public function Update() : void
      {
         this.§_-dF§.Update();
      }
   }
}
