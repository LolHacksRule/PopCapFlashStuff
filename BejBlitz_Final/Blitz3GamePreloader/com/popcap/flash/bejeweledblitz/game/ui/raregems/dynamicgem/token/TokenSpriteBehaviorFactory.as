package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.token
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.RareGemTokenSprite;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.RareGemToken;
   import flash.geom.Point;
   
   public class TokenSpriteBehaviorFactory
   {
       
      
      private var _app:Blitz3App;
      
      public function TokenSpriteBehaviorFactory(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function generate(param1:RareGemToken, param2:RareGemTokenSprite, param3:Function, param4:Point = null) : TokenSpriteBehavior
      {
         var _loc5_:String = this._app.logic.rareGemsLogic.currentRareGem.getTokenGemEffectType();
         switch(_loc5_)
         {
            case RGLogic.TOKEN_GEM_EFFECT_TIME:
               return new TimeTokenSpriteBehavior(param1,param2,param3,param4);
            case RGLogic.TOKEN_GEM_EFFECT_COINS:
               return new CoinTokenSpriteBehavior(param1,param2,param3);
            case RGLogic.TOKEN_GEM_EFFECT_GIFT:
               return new GiftTokenSpriteBehavior(param1,param2,param3);
            default:
               return new DefaultTokenSpriteBehavior(param1,param2,param3);
         }
      }
   }
}
