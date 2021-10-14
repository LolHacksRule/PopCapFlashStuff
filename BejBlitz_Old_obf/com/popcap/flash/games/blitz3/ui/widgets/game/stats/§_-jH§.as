package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class §_-jH§ extends Sprite
   {
      
      public static const §_-jO§:int = 8;
      
      public static const §_-Xx§:Number = 3;
      
      public static const §_-aQ§:int = 100;
      
      public static const §_-Bc§:int = 16777215;
      
      public static const §_-Cd§:int = 47087;
      
      public static const §_-TO§:Number = 10;
       
      
      protected var §_-C6§:int;
      
      protected var §_-Qa§:int;
      
      protected var §_-Sr§:Number;
      
      protected var §_-G9§:Array;
      
      protected var §_-dZ§:int;
      
      protected var §_-ev§:Number;
      
      protected var §_-Gg§:int;
      
      public function §_-jH§(param1:Number = 10, param2:Number = 3, param3:int = 8, param4:int = 100)
      {
         var _loc6_:Shape = null;
         var _loc7_:Number = NaN;
         super();
         this.§_-ev§ = param1;
         this.§_-Sr§ = param2;
         this.§_-Gg§ = param3;
         this.§_-Qa§ = param4 / this.§_-Gg§;
         this.§_-G9§ = [];
         var _loc5_:int = 0;
         while(_loc5_ < this.§_-Gg§)
         {
            _loc6_ = new Shape();
            this.§_-B0§(_loc6_);
            _loc7_ = 2 * Math.PI * (_loc5_ / this.§_-Gg§);
            _loc6_.x = this.§_-ev§ + this.§_-Sr§ + this.§_-ev§ * Math.cos(_loc7_);
            _loc6_.y = this.§_-ev§ + this.§_-Sr§ + this.§_-ev§ * Math.sin(_loc7_);
            this.§_-G9§.push(_loc6_);
            addChild(_loc6_);
            _loc5_++;
         }
      }
      
      public function Update() : void
      {
         --this.§_-dZ§;
         if(this.§_-dZ§ <= 0)
         {
            this.§_-B0§(this.§_-G9§[this.§_-C6§]);
            this.§_-dZ§ = this.§_-Qa§;
            ++this.§_-C6§;
            this.§_-C6§ %= this.§_-Gg§;
            this.§_-gi§(this.§_-G9§[this.§_-C6§]);
         }
      }
      
      protected function §_-gi§(param1:Shape) : void
      {
         param1.graphics.clear();
         param1.graphics.beginFill(§_-Cd§);
         param1.graphics.drawCircle(0,0,this.§_-Sr§);
         param1.graphics.endFill();
      }
      
      protected function §_-B0§(param1:Shape) : void
      {
         param1.graphics.clear();
         param1.graphics.beginFill(§_-Bc§);
         param1.graphics.drawCircle(0,0,this.§_-Sr§);
         param1.graphics.endFill();
      }
      
      public function Reset() : void
      {
         this.§_-C6§ = 0;
         this.§_-dZ§ = this.§_-Qa§;
         this.§_-gi§(this.§_-G9§[0]);
         var _loc1_:int = 1;
         while(_loc1_ < this.§_-Gg§)
         {
            this.§_-B0§(this.§_-G9§[1]);
            _loc1_++;
         }
      }
      
      public function Init() : void
      {
         this.Reset();
      }
   }
}
