package com.popcap.flash.games.blitz3.ui.widgets.anims
{
   import com.popcap.flash.framework.events.EventBus;
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   
   public class CoinTokenCollectAnim
   {
       
      
      private var mIsDone:Boolean = false;
      
      private var mRiseAnim:CoinTokenRiseAnim;
      
      private var mTravelAnim:CoinTokenTravelAnim;
      
      private var mFallAnim:CoinTokenFallAnim;
      
      private var mIndex:int = 0;
      
      private var mAnims:Array;
      
      public function CoinTokenCollectAnim(coinSprite:CoinSprite, endX:int, endY:int)
      {
         super();
         this.mRiseAnim = new CoinTokenRiseAnim(coinSprite,25);
         this.mTravelAnim = new CoinTokenTravelAnim(coinSprite,endX,endY,50);
         this.mFallAnim = new CoinTokenFallAnim(coinSprite,50);
         this.mAnims = [this.mRiseAnim,this.mTravelAnim,this.mFallAnim];
      }
      
      public function Start() : void
      {
         EventBus.GetGlobal().Dispatch("CoinTokenCollectAnimStartEvent");
      }
      
      public function Update() : void
      {
         if(this.mIsDone)
         {
            return;
         }
         this.mAnims[this.mIndex].Update();
         if(this.mAnims[this.mIndex].IsDone())
         {
            ++this.mIndex;
         }
         if(this.mIndex == this.mAnims.length)
         {
            this.mIsDone = true;
            EventBus.GetGlobal().Dispatch("CoinTokenCollectAnimCompleteEvent");
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
