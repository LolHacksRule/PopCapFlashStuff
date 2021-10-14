package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class §_-Mt§ extends Sprite
   {
       
      
      private var X2_RGB:Class;
      
      private var X3_RGB:Class;
      
      private var X4_RGB:Class;
      
      private var X5_RGB:Class;
      
      private var X6_RGB:Class;
      
      private var X7_RGB:Class;
      
      private var X8_RGB:Class;
      
      private var §_-gu§:Class;
      
      private var §_-Pv§:Class;
      
      private var §_-Ji§:int;
      
      private var §_-5A§:int;
      
      private var §_-QM§:Class;
      
      private var §_-bz§:Array;
      
      private var §_-5r§:Class;
      
      private var §_-7h§:Class;
      
      private var §_-EX§:Bitmap;
      
      private var §_-W7§:Bitmap;
      
      private var §_-lq§:Class;
      
      private var §_-YA§:Array;
      
      private var §_-L3§:Class;
      
      public function §_-Mt§()
      {
         this.X2_RGB = MultiSprite_X2_RGB;
         this.X3_RGB = MultiSprite_X3_RGB;
         this.X4_RGB = MultiSprite_X4_RGB;
         this.X5_RGB = MultiSprite_X5_RGB;
         this.X6_RGB = MultiSprite_X6_RGB;
         this.X7_RGB = MultiSprite_X7_RGB;
         this.X8_RGB = MultiSprite_X8_RGB;
         this.§_-5r§ = §_-is§;
         this.§_-QM§ = §_-P8§;
         this.§_-7h§ = §_-pV§;
         this.§_-Pv§ = §_-3v§;
         this.§_-gu§ = §_-gt§;
         this.§_-lq§ = §_-B9§;
         this.§_-L3§ = §_-91§;
         this.§_-YA§ = [null,null,(new this.X2_RGB() as Bitmap).bitmapData,(new this.X3_RGB() as Bitmap).bitmapData,(new this.X4_RGB() as Bitmap).bitmapData,(new this.X5_RGB() as Bitmap).bitmapData,(new this.X6_RGB() as Bitmap).bitmapData,(new this.X7_RGB() as Bitmap).bitmapData,(new this.X8_RGB() as Bitmap).bitmapData];
         this.§_-bz§ = [null,(new this.§_-5r§() as Bitmap).bitmapData,(new this.§_-QM§() as Bitmap).bitmapData,(new this.§_-7h§() as Bitmap).bitmapData,(new this.§_-Pv§() as Bitmap).bitmapData,(new this.§_-gu§() as Bitmap).bitmapData,(new this.§_-lq§() as Bitmap).bitmapData,(new this.§_-L3§() as Bitmap).bitmapData];
         super();
         addChild(this.color);
         addChild(this.number);
      }
      
      public function §_-Rs§(param1:int) : void
      {
         this.§_-Ji§ = param1;
         this.§_-EX§.bitmapData = this.§_-bz§[param1];
      }
      
      private function get number() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-W7§ == null)
         {
            this.§_-W7§ = new Bitmap(this.§_-YA§[0]);
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = -13.999;
            _loc1_.ty = -13.499;
            this.§_-W7§.transform.matrix = _loc1_;
         }
         return this.§_-W7§;
      }
      
      public function §_-CQ§() : int
      {
         return this.§_-5A§;
      }
      
      public function §_-b2§() : int
      {
         return this.§_-Ji§;
      }
      
      public function §_-OF§(param1:int) : void
      {
         this.§_-5A§ = param1;
         this.§_-W7§.bitmapData = this.§_-YA§[param1];
      }
      
      private function get color() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-EX§ == null)
         {
            this.§_-EX§ = new Bitmap(this.§_-bz§[0]);
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = -13.999;
            _loc1_.ty = -13.499;
            this.§_-EX§.transform.matrix = _loc1_;
         }
         return this.§_-EX§;
      }
   }
}
