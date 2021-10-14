package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemCreateEvent;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.geom.Point;
   
   public class StarGemCreateEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      private var mEvent:StarGemCreateEvent;
      
      private var mLocus:Gem;
      
      private var mInitialPos:Vector.<Point>;
      
      private var mFinalPos:Point;
      
      private var mIsDone:Boolean = false;
      
      public function StarGemCreateEffect(app:Blitz3App, event:StarGemCreateEvent)
      {
         super();
         this.m_App = app;
         this.mEvent = event;
         this.mLocus = this.mEvent.GetLocus();
         this.init();
      }
      
      private function init() : void
      {
         var gem:Gem = null;
         this.mFinalPos = new Point(this.mLocus.x,this.mLocus.y);
         this.mInitialPos = new Vector.<Point>();
         var gems:Vector.<Gem> = this.mEvent.GetGems();
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            this.mInitialPos[i] = new Point(gem.x,gem.y);
         }
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_APPEAR);
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
         var percent:Number = this.mEvent.GetPercent();
         if(percent >= 1)
         {
            this.mIsDone = true;
            return;
         }
         var gems:Vector.<Gem> = this.mEvent.GetGems();
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
   }
}
