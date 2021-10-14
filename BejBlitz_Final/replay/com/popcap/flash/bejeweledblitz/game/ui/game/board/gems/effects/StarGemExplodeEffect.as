package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   
   public class StarGemExplodeEffect extends SpriteEffect
   {
      
      public static const STOP_TIME:int = 110;
       
      
      private var m_App:Blitz3App;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      private var mColor:int = 0;
      
      private var mTimer:int = 0;
      
      private var mIsDone:Boolean = false;
      
      public function StarGemExplodeEffect(app:Blitz3App, locus:Gem)
      {
         super();
         this.m_App = app;
         this.mX = locus.x;
         this.mY = locus.y;
         this.mColor = locus.color;
         this.m_App.ui.game.board.gemLayer.starGemLayer.ShowBoltCross(this.mY,this.mX,this.mColor,STOP_TIME);
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         if(this.mIsDone)
         {
            return;
         }
         if(this.mTimer >= STOP_TIME)
         {
            this.mIsDone = true;
         }
         if(this.mTimer == 0)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_EXPLODE);
         }
         ++this.mTimer;
      }
   }
}
