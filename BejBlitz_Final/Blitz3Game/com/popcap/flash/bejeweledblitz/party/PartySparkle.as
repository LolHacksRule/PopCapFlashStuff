package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinSprite;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class PartySparkle extends Sprite
   {
       
      
      private var fallSpeed:int = 1;
      
      public var sparkleTrails:int = 0;
      
      public function PartySparkle(param1:Blitz3Game, param2:int)
      {
         var _loc3_:CoinSprite = null;
         super();
         if(param2 == 0)
         {
            this.createCircle(16711680);
         }
         else if(param2 == 1)
         {
            this.createCircle(65535);
         }
         else if(param2 == 2)
         {
            this.createCircle(16777215);
         }
         else if(param2 == 3)
         {
            this.createCircle(16776960);
         }
         else
         {
            _loc3_ = new CoinSprite(param1,1);
            this.createImage(_loc3_);
            this.fallSpeed = Math.random() * 5 + 8;
         }
      }
      
      private function createCircle(param1:uint) : void
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(param1);
         var _loc3_:int = Math.random() * 3 + 2;
         _loc2_.graphics.drawCircle(Math.random() * 3,Math.random() * 3,_loc3_);
         this.fallSpeed = _loc3_ + Math.random() * 3;
         addChild(_loc2_);
      }
      
      public function update() : void
      {
         this.y += this.fallSpeed;
      }
      
      private function createImage(param1:DisplayObject) : void
      {
         param1.scaleX = 0.5;
         param1.scaleY = 0.5;
         this.fallSpeed = 4;
         addChild(param1);
      }
   }
}
