package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.token
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.RareGemTokenSprite;
   import com.popcap.flash.bejeweledblitz.logic.tokens.RareGemToken;
   import flash.geom.Point;
   
   public class TimeTokenSpriteBehavior extends DefaultTokenSpriteBehavior implements TokenSpriteBehavior
   {
       
      
      var _targetPt:Point;
      
      public function TimeTokenSpriteBehavior(param1:RareGemToken, param2:RareGemTokenSprite, param3:Function, param4:Point)
      {
         super(param1,param2,param3);
         this._targetPt = param4;
      }
      
      override public function onLastHurrahCollection() : void
      {
         _onComplete(_sprite,_token);
         _sprite.visible = false;
      }
      
      override public function onGameCollection() : void
      {
         Tweener.addTween(_sprite,{
            "x":this._targetPt.x,
            "y":this._targetPt.y,
            "time":1,
            "onComplete":_onComplete,
            "onCompleteParams":[_sprite,_token],
            "transition":"linear"
         });
      }
   }
}
