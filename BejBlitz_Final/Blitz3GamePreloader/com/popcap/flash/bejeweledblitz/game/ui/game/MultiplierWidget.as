package com.popcap.flash.bejeweledblitz.game.ui.game
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.multi.IMultiplierGemLogicHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class MultiplierWidget implements IMultiplierGemLogicHandler
   {
       
      
      private var _app:Blitz3App;
      
      private var _multiplierMC:MovieClip;
      
      private var _multiplierLabel:TextField;
      
      private var _multBonus:int = 0;
      
      private var _oldMultBonus:int = 0;
      
      private var _oldMultiCoins:int = 0;
      
      public function MultiplierWidget(param1:Blitz3App, param2:MovieClip)
      {
         super();
         this._app = param1;
         this._multiplierMC = param2;
         this._multiplierLabel = this._multiplierMC.txtmuliplayer;
         this._app.logic.multiLogic.AddHandler(this);
      }
      
      public function init() : void
      {
         this.reset();
      }
      
      private function checkFrame() : void
      {
         this._multiplierMC.gotoAndStop(this._multiplierMC.totalFrames);
         this._multiplierMC.txtmuliplayer.text = "x" + (this._multBonus + this._app.logic.coinTokenLogic.getMultiCoins()).toString();
      }
      
      public function Update() : void
      {
         this._multBonus = this._app.logic.GetMultiplierBonus();
         if(this._multBonus > 0)
         {
            if(this._oldMultBonus != this._multBonus)
            {
               this._multiplierMC.gotoAndStop("add");
               this._multiplierMC.Addtext.txtAdd.text = "x" + this._multBonus.toString();
               this._multiplierMC.play();
               this._oldMultBonus = this._multBonus;
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BACKGROUND_CHANGE);
            }
         }
         else if(this._oldMultBonus != this._multBonus && this._multBonus == 0)
         {
            this._oldMultBonus = 0;
            this._multiplierMC.gotoAndStop("normal");
            this._multiplierMC.txtmuliplayer.text = "x" + this._app.logic.coinTokenLogic.getMultiCoins();
         }
         else if(this._oldMultiCoins != this._app.logic.coinTokenLogic.getMultiCoins())
         {
            this._multiplierMC.txtmuliplayer.text = "x" + this._app.logic.coinTokenLogic.getMultiCoins();
            this._oldMultiCoins = this._app.logic.coinTokenLogic.getMultiCoins();
         }
      }
      
      public function reset() : void
      {
         this._multiplierMC.txtmuliplayer.text = "x1";
      }
      
      public function getMultiplierLabel() : TextField
      {
         return this._multiplierLabel;
      }
      
      public function getRect(param1:DisplayObject) : Rectangle
      {
         return this._multiplierMC.getRect(param1);
      }
      
      public function HandleMultiplierSpawned(param1:Gem) : void
      {
      }
      
      public function HandleMultiplierCollected() : void
      {
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BACKGROUND_CHANGE);
      }
   }
}
