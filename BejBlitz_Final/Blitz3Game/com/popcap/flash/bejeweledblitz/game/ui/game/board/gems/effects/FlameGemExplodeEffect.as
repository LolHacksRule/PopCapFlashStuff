package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   
   public class FlameGemExplodeEffect extends SpriteEffect
   {
       
      
      private var _isDead:Boolean = false;
      
      private var _explosionImage:ImageInst;
      
      private var _explosionBitmap:Bitmap;
      
      private var _frameCount:int;
      
      private const ANIMATION_RATE:uint = 4;
      
      public function FlameGemExplodeEffect(param1:Blitz3App, param2:GemSprite)
      {
         super();
         this._frameCount = 0;
         this._explosionImage = param1.ImageManager.getImageInst(Blitz3GameImages.IMAGE_FLAME_GEM_EXPLOSION);
         this._explosionBitmap = new Bitmap(this._explosionImage.pixels);
         this._explosionBitmap.x = this._explosionBitmap.width * -0.5 + param2.x;
         this._explosionBitmap.y = this._explosionBitmap.height * -0.5 + param2.y;
         addChild(this._explosionBitmap);
         var _loc3_:RGLogic = param1.logic.rareGemsLogic.currentRareGem;
         if(_loc3_ != null && SoundPlayer.isPlaying(_loc3_.getStringID() + "DynamicSound" + DynamicRareGemSound.EXPLOSION_ID))
         {
            param1.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_FLAME_EXPLODE,1,Blitz3App.REDUCED_EXPLOSION_VOLUME);
         }
         else
         {
            param1.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_FLAME_EXPLODE);
         }
      }
      
      override public function Update() : void
      {
         if(this._isDead)
         {
            return;
         }
         ++this._frameCount;
         this._explosionImage.mFrame = Math.floor(this._frameCount / this.ANIMATION_RATE);
         if(this._explosionImage.mFrame == this._explosionImage.mSource.mNumFrames)
         {
            this._isDead = true;
         }
      }
      
      override public function Draw() : void
      {
         if(this._isDead)
         {
            return;
         }
         this._explosionBitmap.bitmapData = this._explosionImage.pixels;
      }
      
      override public function IsDone() : Boolean
      {
         return this._isDead;
      }
   }
}
