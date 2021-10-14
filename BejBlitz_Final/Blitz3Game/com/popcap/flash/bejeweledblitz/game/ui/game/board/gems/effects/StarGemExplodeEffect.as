package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
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
      
      public function StarGemExplodeEffect(param1:Blitz3App, param2:Gem)
      {
         super();
         this.m_App = param1;
         this.mX = param2.x;
         this.mY = param2.y;
         this.mColor = param2.color;
         (this.m_App.ui as MainWidgetGame).game.board.gemLayer.starGemLayer.ShowBoltCross(this.mY,this.mX,this.mColor,STOP_TIME);
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         var _loc1_:RGLogic = null;
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
            _loc1_ = this.m_App.logic.rareGemsLogic.currentRareGem;
            if(_loc1_ != null && SoundPlayer.isPlaying(_loc1_.getStringID() + "DynamicSound" + DynamicRareGemSound.EXPLOSION_ID))
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_EXPLODE,1,Blitz3App.REDUCED_EXPLOSION_VOLUME);
            }
            else
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_EXPLODE);
            }
         }
         ++this.mTimer;
      }
   }
}
