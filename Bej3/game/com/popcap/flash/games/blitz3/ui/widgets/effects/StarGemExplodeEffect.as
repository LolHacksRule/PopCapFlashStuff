package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   
   public class StarGemExplodeEffect extends SpriteEffect
   {
      
      public static const START_TIME:int = 3;
      
      public static const STOP_TIME:int = 110;
      
      public static const CHANGE_TIME:int = 5;
      
      public static const NUM_ZAPS:int = 4;
       
      
      private var mApp:Blitz3UI;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      private var mColor:int = 0;
      
      private var mTimer:int = 0;
      
      private var mIsDone:Boolean = false;
      
      public function StarGemExplodeEffect(app:Blitz3UI, locus:Gem)
      {
         super();
         this.mApp = app;
         this.mX = locus.x;
         this.mY = locus.y;
         this.mColor = locus.color;
         this.mApp.ui.game.board.gemLayer.lightning.ShowBoltCross(this.mY,this.mX,this.mColor,110);
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
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_GEM_STAR_EXPLODE);
         }
         ++this.mTimer;
      }
      
      override public function Draw(postFX:Boolean) : void
      {
      }
   }
}
