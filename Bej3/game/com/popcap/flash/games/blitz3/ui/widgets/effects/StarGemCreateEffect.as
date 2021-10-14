package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.gems.star.StarGemCreateEvent;
   import flash.geom.Point;
   
   public class StarGemCreateEffect extends SpriteEffect
   {
       
      
      private var mEvent:StarGemCreateEvent;
      
      private var mLocus:Gem;
      
      private var mInitialPos:Vector.<Point>;
      
      private var mFinalPos:Point;
      
      private var mIsDone:Boolean = false;
      
      private var mIsInited:Boolean = false;
      
      public function StarGemCreateEffect(event:StarGemCreateEvent)
      {
         super();
         this.mEvent = event;
         this.mLocus = event.locus;
      }
      
      private function init() : void
      {
         var gem:Gem = null;
         this.mFinalPos = new Point(this.mLocus.x,this.mLocus.y);
         this.mInitialPos = new Vector.<Point>();
         var gems:Vector.<Gem> = this.mEvent.gems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            this.mInitialPos[i] = new Point(gem.x,gem.y);
         }
         this.mIsInited = true;
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         var gem:Gem = null;
         var x:Number = NaN;
         var y:Number = NaN;
         if(this.mIsDone == true)
         {
            return;
         }
         if(!this.mIsInited)
         {
            this.init();
         }
         var percent:Number = this.mEvent.percent;
         if(percent >= 1)
         {
            this.mIsDone = true;
            return;
         }
         this.mFinalPos.x = this.mLocus.x;
         this.mFinalPos.y = this.mLocus.y;
         var gems:Vector.<Gem> = this.mEvent.gems;
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            x = this.mInitialPos[i].x;
            x += (this.mFinalPos.x - this.mInitialPos[i].x) * percent;
            y = this.mInitialPos[i].y;
            y += (this.mFinalPos.y - this.mInitialPos[i].y) * percent;
            gem.x = x;
            gem.y = y;
         }
      }
      
      override public function Draw(postFX:Boolean) : void
      {
      }
   }
}
