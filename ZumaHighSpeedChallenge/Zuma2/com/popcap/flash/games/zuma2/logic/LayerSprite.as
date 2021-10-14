package com.popcap.flash.games.zuma2.logic
{
   import flash.display.Sprite;
   
   public class LayerSprite extends Sprite
   {
       
      
      public var mForeground:Sprite;
      
      public var mBackground:Sprite;
      
      public var mBalls:Sprite;
      
      public function LayerSprite()
      {
         super();
         this.mBackground = new Sprite();
         addChild(this.mBackground);
         this.mBalls = new Sprite();
         addChild(this.mBalls);
         this.mForeground = new Sprite();
         addChild(this.mForeground);
      }
      
      public function Clear() : void
      {
         removeChild(this.mBackground);
         removeChild(this.mBalls);
         removeChild(this.mForeground);
         this.mBackground = new Sprite();
         addChild(this.mBackground);
         this.mBalls = new Sprite();
         addChild(this.mBalls);
         this.mForeground = new Sprite();
         addChild(this.mForeground);
      }
   }
}
