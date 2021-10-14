package com.popcap.flash.bejeweledblitz.dailyspin.anim
{
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.DSEvent;
   import com.popcap.flash.bejeweledblitz.dailyspin.app.event.IDSEventHandler;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CoinBubbleAnim extends Sprite implements IDSEventHandler
   {
       
      
      private const MAX_ALPHA_FALL_OFF:Number = 0.7;
      
      private var m_Coins:Vector.<Bitmap>;
      
      private var m_CoinContainer:Sprite;
      
      private var m_Mask:Sprite;
      
      private var m_AnimDuration:int;
      
      private var m_ElapstedFrames:int;
      
      private var m_CoinSpeed:Number;
      
      private var m_Callback:Function;
      
      public function CoinBubbleAnim()
      {
         super();
         this.init();
      }
      
      public function initAnim(icon:Bitmap, numCoins:int, animWidth:Number, animHeight:Number, animDuration:Number = 2000, coinSpeed:Number = 3, callback:Function = null, xOffset:Number = 0, yOffset:Number = 0) : void
      {
         var coin:Bitmap = null;
         this.m_AnimDuration = animDuration;
         this.m_CoinSpeed = coinSpeed;
         this.m_Callback = callback;
         this.m_ElapstedFrames = 0;
         this.initCoins(numCoins,icon);
         this.m_Mask.graphics.beginFill(16711680);
         this.m_Mask.graphics.drawRect(xOffset,yOffset,animWidth - 2 * xOffset,animHeight - 2 * yOffset);
         this.m_Mask.cacheAsBitmap = true;
         this.m_CoinContainer.mask = this.m_Mask;
         for each(coin in this.m_Coins)
         {
            this.randomizeCoinPosition(coin,animWidth,animHeight,0);
         }
      }
      
      public function handleEvent(event:DSEvent) : void
      {
         this.update();
      }
      
      private function update() : void
      {
         var coin:Bitmap = null;
         if(this.m_ElapstedFrames++ >= this.m_AnimDuration)
         {
            this.m_ElapstedFrames = 0;
            if(this.m_Callback != null)
            {
               this.m_Callback();
            }
            return;
         }
         for each(coin in this.m_Coins)
         {
            coin.y -= this.m_CoinSpeed;
            if(coin.y < -coin.height)
            {
               this.randomizeCoinPosition(coin,this.m_Mask.width,this.m_Mask.height,this.m_Mask.height);
            }
         }
      }
      
      private function randomizeCoinPosition(coin:Bitmap, animWidth:Number, animHeight:Number, yOffset:Number) : void
      {
         var xPos:Number = Math.random() * animWidth - coin.width;
         coin.x = xPos < 0 ? Number(0) : Number(xPos);
         coin.y = Math.random() * animHeight + yOffset;
         coin.alpha = 1 - Math.random() * this.MAX_ALPHA_FALL_OFF;
      }
      
      private function init() : void
      {
         this.m_CoinContainer = new Sprite();
         this.m_Mask = new Sprite();
         addChild(this.m_Mask);
         addChild(this.m_CoinContainer);
      }
      
      private function initCoins(numCoins:int, icon:Bitmap) : void
      {
         var coin:Bitmap = null;
         this.m_Coins = new Vector.<Bitmap>();
         for(var i:int = 0; i < numCoins; i++)
         {
            coin = new Bitmap(icon.bitmapData);
            this.m_Coins.push(coin);
            this.m_CoinContainer.addChild(coin);
         }
      }
   }
}
