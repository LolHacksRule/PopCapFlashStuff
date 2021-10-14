package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.token
{
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.RareGemTokenSprite;
   import com.popcap.flash.bejeweledblitz.logic.tokens.RareGemToken;
   
   public class GiftTokenSpriteBehavior extends DefaultTokenSpriteBehavior implements TokenSpriteBehavior
   {
       
      
      public function GiftTokenSpriteBehavior(param1:RareGemToken, param2:RareGemTokenSprite, param3:Function)
      {
         super(param1,param2,param3);
      }
      
      override public function onLastHurrahCollection() : void
      {
         _onComplete(_sprite,_token);
      }
   }
}
