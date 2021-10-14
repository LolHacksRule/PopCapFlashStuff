package com.popcap.flash.bejeweledblitz.friendscore.view.meter
{
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class CoinEffect extends Sprite
   {
      
      private static const NUM_COINS:int = 6;
      
      private static const SPEED:Number = 60;
      
      private static const DURATION:Number = 0.5;
       
      
      private var m_App:App;
      
      private var m_Coins:Vector.<DisplayObject>;
      
      private var m_CoinsVels:Vector.<Point>;
      
      private var m_Timer:Number;
      
      private var m_IsComplete:Boolean;
      
      private var m_AlphaCurve:LinearSampleCurvedVal;
      
      public function CoinEffect(app:App)
      {
         super();
         this.m_App = app;
         this.m_Coins = new Vector.<DisplayObject>();
         this.m_CoinsVels = new Vector.<Point>();
         this.CreateCoins();
         this.m_Timer = 0;
         this.m_IsComplete = false;
         this.m_AlphaCurve = new LinearSampleCurvedVal();
         this.m_AlphaCurve.setInRange(0,DURATION);
         this.m_AlphaCurve.setOutRange(1,0);
         this.m_AlphaCurve.addPoint(0.85,1);
         visible = false;
      }
      
      public function Init() : void
      {
         var coin:DisplayObject = null;
         for each(coin in this.m_Coins)
         {
            addChild(coin);
         }
         this.InitializeVelocities();
      }
      
      public function Update(dt:Number) : void
      {
         if(this.m_Timer <= 0)
         {
            this.HandleComplete();
            return;
         }
         this.m_Timer -= dt;
         this.UpdateCoins(dt);
         alpha = this.m_AlphaCurve.getOutValue(DURATION - this.m_Timer);
      }
      
      public function Start() : void
      {
         visible = true;
         this.m_Timer = DURATION;
      }
      
      private function CreateCoins() : void
      {
         var container:Sprite = null;
         var image:Bitmap = null;
         for(var i:int = 0; i < NUM_COINS; i++)
         {
            container = new Sprite();
            image = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN));
            image.smoothing = true;
            image.width = 10;
            image.height = 10;
            image.x = -image.width;
            image.y = -image.height;
            container.addChild(image);
            this.m_Coins.push(container);
            this.m_CoinsVels.push(new Point());
         }
      }
      
      private function InitializeVelocities() : void
      {
         var angle:Number = NaN;
         var point:Point = null;
         for(var i:int = 0; i < NUM_COINS; i++)
         {
            angle = i * 2 * Math.PI / NUM_COINS;
            point = this.m_CoinsVels[i];
            point.x = SPEED * Math.cos(angle);
            point.y = SPEED * Math.sin(angle);
         }
      }
      
      private function UpdateCoins(dt:Number) : void
      {
         var coin:DisplayObject = null;
         var vel:Point = null;
         for(var i:int = 0; i < NUM_COINS; i++)
         {
            coin = this.m_Coins[i];
            vel = this.m_CoinsVels[i];
            coin.x += dt * vel.x;
            coin.y += dt * vel.y;
         }
      }
      
      private function HandleComplete() : void
      {
         if(!this.m_IsComplete)
         {
            visible = false;
            this.m_IsComplete = true;
         }
      }
   }
}
