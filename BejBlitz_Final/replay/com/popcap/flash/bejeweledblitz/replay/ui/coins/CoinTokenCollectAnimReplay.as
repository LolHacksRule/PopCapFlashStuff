package com.popcap.flash.bejeweledblitz.replay.ui.coins
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnim;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class CoinTokenCollectAnimReplay extends CoinTokenCollectAnim
   {
      
      private static const DURATION:int = 100;
       
      
      private var mTimer:int = 0;
      
      private var mStartY:int = 0;
      
      private var mEndY:int = 0;
      
      public function CoinTokenCollectAnimReplay(app:Blitz3App, coinSprite:CoinSprite)
      {
         var point:Point = null;
         super(app,coinSprite);
         var ui:Sprite = (m_App as Blitz3Replay).ui;
         point = new Point(coinSprite.x,coinSprite.y);
         point = ui.globalToLocal(coinSprite.localToGlobal(point));
         coinSprite.x = point.x;
         coinSprite.y = point.y;
         if(coinSprite.parent == null)
         {
            coinSprite.y += coinSprite.height;
         }
         ui.addChild(coinSprite);
         this.mStartY = coinSprite.y;
         this.mEndY = -80;
      }
      
      override public function Update() : void
      {
         if(isDone)
         {
            return;
         }
         var percent:Number = this.mTimer / DURATION;
         coinSprite.y = this.mStartY + this.mEndY * percent;
         if(this.mTimer == DURATION)
         {
            isDone = true;
         }
         else
         {
            ++this.mTimer;
         }
      }
   }
}
