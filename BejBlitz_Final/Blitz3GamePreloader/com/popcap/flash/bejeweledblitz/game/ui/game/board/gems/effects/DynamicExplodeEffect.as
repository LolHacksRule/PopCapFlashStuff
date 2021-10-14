package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   
   public class DynamicExplodeEffect extends SpriteEffect
   {
       
      
      private var _isDead:Boolean = false;
      
      private var _clip:MovieClip;
      
      public function DynamicExplodeEffect(param1:Blitz3App, param2:GemSprite, param3:String)
      {
         super();
         x = param2.x;
         y = param2.y;
         this._clip = new MovieClip();
         this.addChild(this._clip);
         DynamicRGInterface.attachMovieClip(param3,"Explosion",this._clip);
         if(!DynamicRareGemSound.play(param3,DynamicRareGemSound.EXPLOSION_ID))
         {
            param1.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_FLAME_EXPLODE);
         }
      }
      
      override public function Update() : void
      {
         var _loc1_:MovieClip = null;
         if(this._isDead)
         {
            return;
         }
         if(this._clip.numChildren > 0)
         {
            _loc1_ = this._clip.getChildAt(0) as MovieClip;
            if(_loc1_ != null && _loc1_.totalFrames > 0 && _loc1_.currentFrame >= _loc1_.totalFrames)
            {
               Utils.removeAllChildrenFrom(this._clip);
               Utils.removeAllChildrenFrom(this);
               this._isDead = true;
            }
         }
      }
      
      override public function Draw() : void
      {
      }
      
      override public function IsDone() : Boolean
      {
         return this._isDead;
      }
   }
}
