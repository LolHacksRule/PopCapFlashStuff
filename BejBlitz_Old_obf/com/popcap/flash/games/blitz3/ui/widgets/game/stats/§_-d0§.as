package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class §_-d0§ extends Sprite
   {
       
      
      private var §_-d7§:Bitmap;
      
      private var §_-L§:Class;
      
      private var §_-74§:TextField;
      
      public function §_-d0§()
      {
         this.§_-L§ = §_-V2§;
         super();
         addChild(this.§_-Oh§);
         addChild(this.§_-WJ§);
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function get §_-WJ§() : TextField
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Matrix = null;
         if(this.§_-74§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 13;
            _loc1_.color = 16777215;
            _loc1_.align = "center";
            this.§_-74§ = new TextField();
            this.§_-74§.defaultTextFormat = _loc1_;
            this.§_-74§.embedFonts = true;
            this.§_-74§.text = "This is the message for hypers, powers, etc.";
            this.§_-74§.x = -184;
            this.§_-74§.y = -18.5;
            this.§_-74§.width = 172;
            this.§_-74§.height = 42;
            this.§_-74§.selectable = false;
            this.§_-74§.multiline = true;
            this.§_-74§.wordWrap = true;
            _loc2_ = new Matrix();
            _loc2_.a = 1;
            _loc2_.b = 0;
            _loc2_.c = 0;
            _loc2_.d = 1;
            _loc2_.tx = -185.999;
            _loc2_.ty = -20.499;
            this.§_-74§.transform.matrix = _loc2_;
            this.§_-74§.filters = [new GlowFilter(1191748,1,2,2,4,1,false,false)];
         }
         return this.§_-74§;
      }
      
      public function get §_-Oh§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-d7§ == null)
         {
            this.§_-d7§ = new this.§_-L§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = -189.999;
            _loc1_.ty = -22.499;
            this.§_-d7§.transform.matrix = _loc1_;
         }
         return this.§_-d7§;
      }
   }
}
