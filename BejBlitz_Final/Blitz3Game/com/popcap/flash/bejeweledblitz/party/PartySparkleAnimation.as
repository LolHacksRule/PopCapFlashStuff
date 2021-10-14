package com.popcap.flash.bejeweledblitz.party
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class PartySparkleAnimation extends Sprite
   {
       
      
      private var _sparkleV:Vector.<PartySparkle>;
      
      private var _leadSparkleV:Vector.<PartySparkle>;
      
      private var _frameCount:int;
      
      private var _sparkleOriginSprite:Sprite;
      
      private var _app:Blitz3Game;
      
      public var addSparkles:Boolean = true;
      
      public function PartySparkleAnimation(param1:Blitz3Game, param2:Sprite)
      {
         super();
         this._app = param1;
         this._sparkleV = new Vector.<PartySparkle>();
         this._leadSparkleV = new Vector.<PartySparkle>();
         this._sparkleOriginSprite = param2;
      }
      
      public function stopAnimation() : void
      {
         this._sparkleV = null;
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
      
      public function updateAnimation(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PartySparkle = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Point = null;
         ++this._frameCount;
         if(this.addSparkles)
         {
            if(this._frameCount % 2 == 0)
            {
               _loc3_ = 0;
               while(_loc3_ < 4)
               {
                  _loc5_ = Math.random() * 500;
                  _loc6_ = -10;
                  this._sparkleV.push(this.makeSparkle(new Point(_loc5_,_loc6_),false));
                  _loc3_++;
               }
            }
            else if(this._frameCount % 1 == 0)
            {
               _loc3_ = 0;
               while(_loc3_ < 5)
               {
                  _loc7_ = this._sparkleOriginSprite.x + this._sparkleOriginSprite.width * 0.5 + (Math.random() * 60 - 20);
                  _loc8_ = this._sparkleOriginSprite.y + (Math.random() * 10 - 5) + 100;
                  _loc9_ = new Point(_loc7_,_loc8_);
                  this._sparkleV.push(this.makeSparkle(_loc9_,true));
                  _loc3_++;
               }
            }
         }
         for each(_loc4_ in this._sparkleV)
         {
            _loc4_.update();
         }
      }
      
      private function makeSparkle(param1:Point = null, param2:Boolean = false) : PartySparkle
      {
         var _loc3_:int = 0;
         if(param2)
         {
            _loc3_ = 5;
         }
         else
         {
            _loc3_ = Math.floor(Math.random() * 4);
         }
         var _loc4_:PartySparkle = new PartySparkle(this._app,_loc3_);
         if(param1)
         {
            _loc4_.x = param1.x;
            _loc4_.y = param1.y;
         }
         else
         {
            _loc4_.x = this._sparkleOriginSprite.x + this._sparkleOriginSprite.width * 0.5;
            _loc4_.y = this._sparkleOriginSprite.y + this._sparkleOriginSprite.height * 0.5;
         }
         addChild(_loc4_);
         return _loc4_;
      }
   }
}
