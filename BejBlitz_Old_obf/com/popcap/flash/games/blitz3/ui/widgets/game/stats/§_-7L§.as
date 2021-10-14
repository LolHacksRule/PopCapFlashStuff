package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class §_-7L§ extends Sprite
   {
      
      public static const §_-6T§:int = 2;
      
      public static const §_-XV§:int = 0;
      
      public static const §_-0x§:int = 1;
       
      
      private var §_-Gr§:TextField;
      
      private var §_-oI§:Class;
      
      private var §_-bY§:Class;
      
      private var §_-09§:§_-0Z§;
      
      private var §_-OA§:Array;
      
      private var §_-d7§:Bitmap;
      
      private var §_-74§:TextField;
      
      private var §_-f§:Class;
      
      public function §_-7L§(param1:§_-0Z§)
      {
         this.§_-bY§ = §_-T1§;
         this.§_-f§ = §_-mL§;
         this.§_-oI§ = §_-5z§;
         this.§_-OA§ = [new this.§_-bY§(),new this.§_-f§(),new this.§_-oI§()];
         super();
         this.§_-09§ = param1;
         mouseEnabled = false;
         mouseChildren = false;
         addChild(this.§_-Oh§);
         addChild(this.score);
         addChild(this.§_-WJ§);
      }
      
      public function get §_-Oh§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-d7§ == null)
         {
            this.§_-d7§ = new Bitmap();
            _loc1_ = new Matrix();
            _loc1_.a = -1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 0;
            _loc1_.ty = -21.999;
            this.§_-d7§.transform.matrix = _loc1_;
         }
         return this.§_-d7§;
      }
      
      public function §_-Pj§(param1:int) : void
      {
         var _loc2_:String = §_-Ze§.§_-2P§(param1);
         this.§_-Gr§.text = _loc2_;
      }
      
      public function §_-BM§(param1:int) : void
      {
         if(param1 >= this.§_-OA§.length)
         {
            return;
         }
         var _loc2_:Bitmap = this.§_-OA§[param1];
         var _loc3_:BitmapData = _loc2_.bitmapData;
         this.§_-Oh§.bitmapData = _loc3_;
      }
      
      public function get score() : TextField
      {
         var _loc1_:TextFormat = null;
         if(this.§_-Gr§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 16;
            _loc1_.color = 16777215;
            _loc1_.align = "center";
            this.§_-Gr§ = new TextField();
            this.§_-Gr§.defaultTextFormat = _loc1_;
            this.§_-Gr§.embedFonts = true;
            this.§_-Gr§.text = "1,000,000";
            this.§_-Gr§.x = -109.5;
            this.§_-Gr§.y = -1.55;
            this.§_-Gr§.width = 99.45;
            this.§_-Gr§.height = 27.05;
            this.§_-Gr§.selectable = false;
            this.§_-Gr§.filters = [new GlowFilter(1191748,1,2,2,4,1,false,false)];
         }
         return this.§_-Gr§;
      }
      
      public function get §_-WJ§() : TextField
      {
         var _loc1_:TextFormat = null;
         if(this.§_-74§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 14;
            _loc1_.color = 16777215;
            _loc1_.align = "center";
            this.§_-74§ = new TextField();
            this.§_-74§.defaultTextFormat = _loc1_;
            this.§_-74§.embedFonts = true;
            this.§_-74§.text = this.§_-09§.§_-JC§.GetLocString("UI_GAMESTATS_LAST_HURRAH_POPUP");
            this.§_-74§.x = -110.5;
            this.§_-74§.y = -17.55;
            this.§_-74§.width = 101.45;
            this.§_-74§.height = 24.15;
            this.§_-74§.selectable = false;
            this.§_-74§.filters = [new GlowFilter(1191748,1,2,2,4,1,false,false)];
         }
         return this.§_-74§;
      }
   }
}
