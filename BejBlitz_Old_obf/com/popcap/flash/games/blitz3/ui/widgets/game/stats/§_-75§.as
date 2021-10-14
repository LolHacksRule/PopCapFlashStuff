package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   
   public class §_-75§ extends Sprite
   {
      
      private static const §_-QO§:Class = §_-7N§;
      
      private static const §_-Tb§:Class = §_-Qg§;
       
      
      private var §_-BB§:§_-25§;
      
      private var §_-09§:Blitz3Game;
      
      private var §_-Si§:Bitmap;
      
      public function §_-75§(param1:Blitz3Game)
      {
         super();
         this.§_-09§ = param1;
         addChild(this.button);
         addChild(this.medal);
         this.button.addEventListener(MouseEvent.CLICK,this.§_-DW§);
      }
      
      public function §_-3K§(param1:int) : void
      {
         var _loc2_:BitmapData = this.§_-09§.§_-8d§.GetMedal(param1);
         if(_loc2_ == null)
         {
            visible = false;
            return;
         }
         visible = true;
         this.medal.bitmapData = _loc2_;
         this.medal.smoothing = true;
      }
      
      public function get button() : §_-25§
      {
         var _loc1_:Matrix = null;
         if(this.§_-BB§ == null)
         {
            this.§_-BB§ = new §_-25§(this.§_-09§);
            this.§_-BB§.§_-G0§.addChild(new §_-QO§());
            this.§_-BB§.§_-5H§.addChild(new §_-Tb§());
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 36;
            _loc1_.ty = 7;
            this.§_-BB§.transform.matrix = _loc1_;
         }
         return this.§_-BB§;
      }
      
      public function get medal() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-Si§ == null)
         {
            this.§_-Si§ = new Bitmap();
            _loc1_ = new Matrix();
            _loc1_.a = 0.720001220703125;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 0.720001220703125;
            _loc1_.tx = -2;
            _loc1_.ty = -2;
            this.§_-Si§.transform.matrix = _loc1_;
         }
         return this.§_-Si§;
      }
      
      private function §_-DW§(param1:MouseEvent) : void
      {
         this.§_-09§.network.PostMedal();
      }
   }
}
