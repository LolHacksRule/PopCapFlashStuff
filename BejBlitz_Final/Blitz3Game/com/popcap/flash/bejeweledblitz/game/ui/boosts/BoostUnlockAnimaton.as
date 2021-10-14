package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.bejeweledblitz.particles.BoostUnlockParticle;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class BoostUnlockAnimaton extends UnlockAnim
   {
       
      
      private var _app:Blitz3App;
      
      private var _boostId:String;
      
      public function BoostUnlockAnimaton(param1:Blitz3App, param2:String)
      {
         super();
         this._app = param1;
         this._boostId = param2;
         this.Init();
      }
      
      private function Init() : void
      {
         this.boostName.TextBoostername.text = this._app.sessionData.boostV2Manager.getBoostUIInfoFromBoostId(this._boostId).getBoostName();
         var _loc1_:Bitmap = new Bitmap(this._app.sessionData.boostV2Manager.boostV2Icons.getBoostAnimIconByID(this._boostId));
         if(_loc1_ == null)
         {
            trace("ERROR :: BOOST ICON IMAGE IS NULL ");
            this.addEventListener(MouseEvent.CLICK,this.Hide);
            return;
         }
         _loc1_.smoothing = true;
         while(this.BoostIcon.numChildren > 0)
         {
            this.BoostIcon.removeChildAt(0);
         }
         this.BoostIcon.addChild(_loc1_);
         this.addEventListener(MouseEvent.CLICK,this.Hide);
      }
      
      public function Play() : void
      {
         (this._app as Blitz3Game).metaUI.highlight.showPopUp(this,true,false,0.55);
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_UNLOCK);
         if(this._app.isLQMode)
         {
            return;
         }
         var _loc1_:BoostUnlockParticle = new BoostUnlockParticle();
         this.ParticleBoostUnlock1.addChild(_loc1_);
      }
      
      private function Hide(param1:MouseEvent) : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.Hide);
         (this._app as Blitz3Game).metaUI.highlight.hidePopUp();
         this._app.bjbEventDispatcher.SendEvent(BoostV2EventDispatcher.BOOST_UNLOCK_ANIMATION_END,this._boostId);
         if(this._app.isLQMode)
         {
            return;
         }
         this.ParticleBoostUnlock1.removeChildren();
      }
   }
}
