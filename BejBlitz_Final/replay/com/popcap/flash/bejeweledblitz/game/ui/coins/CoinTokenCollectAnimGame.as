package com.popcap.flash.bejeweledblitz.game.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class CoinTokenCollectAnimGame extends CoinTokenCollectAnim
   {
      
      private static const TRAVEL_DURATION:int = 100;
       
      
      private var mTimer:int = 0;
      
      private var mPhase:int = 0;
      
      private var mStartX:int;
      
      private var mStartY:int;
      
      private var mEndX:int;
      
      private var mEndY:int;
      
      public function CoinTokenCollectAnimGame(app:Blitz3App, coinSprite:CoinSprite)
      {
         var coinBank:Sprite = null;
         var point:Point = null;
         super(app,coinSprite);
         coinBank = (m_App as Blitz3Game).navigation.CoinsLabel;
         point = new Point(coinSprite.x,coinSprite.y);
         point = coinBank.globalToLocal(coinSprite.localToGlobal(point));
         coinSprite.x = point.x;
         coinSprite.y = point.y;
         coinBank.addChild(coinSprite);
         this.mStartX = coinSprite.x;
         this.mStartY = coinSprite.y;
         this.mEndX = -this.mStartX + coinSprite.width * 0.5 + 6;
         this.mEndY = -this.mStartY + coinSprite.height * 0.5;
      }
      
      override public function Update() : void
      {
         var percent:Number = NaN;
         if(isDone)
         {
            return;
         }
         percent = this.mTimer / TRAVEL_DURATION;
         coinSprite.x = this.mStartX + this.mEndX * percent;
         coinSprite.y = this.mStartY + this.mEndY * percent;
         if(percent >= 1)
         {
            isDone = true;
            m_App.sessionData.userData.AddCoins(coinSprite.value);
         }
         else
         {
            ++this.mTimer;
         }
      }
   }
}
