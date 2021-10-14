package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.token
{
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.RareGemTokenSprite;
   import com.popcap.flash.bejeweledblitz.logic.tokens.RareGemToken;
   
   public class DefaultTokenSpriteBehavior implements TokenSpriteBehavior
   {
       
      
      protected var _token:RareGemToken;
      
      protected var _sprite:RareGemTokenSprite;
      
      protected var _onComplete:Function;
      
      public function DefaultTokenSpriteBehavior(param1:RareGemToken, param2:RareGemTokenSprite, param3:Function)
      {
         super();
         this._token = param1;
         this._sprite = param2;
         this._onComplete = param3;
      }
      
      public function onGameCollection() : void
      {
         this._onComplete(this._sprite,this._token);
      }
      
      public function onLastHurrahCollection() : void
      {
         this._sprite.visible = false;
      }
   }
}
