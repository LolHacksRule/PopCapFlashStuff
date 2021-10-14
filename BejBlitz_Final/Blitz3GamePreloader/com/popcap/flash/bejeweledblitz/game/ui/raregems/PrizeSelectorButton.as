package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PrizeSelectorButton
   {
       
      
      private var _app:Blitz3App;
      
      private var _rareGemID:String = "";
      
      private var _prizeAmount:int = 0;
      
      private var _prizeShardsAmount:int = 0;
      
      private var _controller:IPrizeSelector;
      
      private var _clip:MovieClip;
      
      private var _btnIndex:uint = 0;
      
      private var _btn:GenericButtonClip;
      
      public function PrizeSelectorButton(param1:Blitz3App, param2:IPrizeSelector, param3:MovieClip)
      {
         super();
         this._app = param1;
         this._controller = param2;
         this._clip = param3;
         this._clip.addEventListener(Event.ENTER_FRAME,this.onAdded,false,0,true);
         this._rareGemID = param1.logic.rareGemsLogic.currentRareGem.getStringID();
      }
      
      public function hideMe() : void
      {
         this._clip.visible = false;
      }
      
      public function init(param1:String, param2:uint, param3:Boolean) : void
      {
         this._rareGemID = param1;
         if(param3)
         {
            this._clip.visible = false;
            this.prizePress();
         }
         else
         {
            this._clip.visible = true;
            this._clip.scaleX = 1;
            this._clip.scaleY = 1;
            this._clip.alpha = 1;
            this._btnIndex = param2;
            Utils.removeAllChildrenFrom(this._clip.baseClip.center);
            Utils.removeAllChildrenFrom(this._clip.revealSelectedClip.center);
            Utils.removeAllChildrenFrom(this._clip.revealOtherClip.center);
            Utils.removeAllChildrenFrom(this._clip.winClip.center);
            this._clip.baseClip.gotoAndStop("dynamic");
            this._clip.revealSelectedClip.gotoAndStop("dynamic");
            this._clip.revealOtherClip.gotoAndStop("dynamic");
            this._clip.winClip.gotoAndStop("dynamic");
            this.attachDynamicBitmapTo(param1,"Prizebase",this._clip.baseClip.center);
            this.attachDynamicBitmapTo(param1,"Prizeselected",this._clip.revealSelectedClip.center);
            this.attachDynamicBitmapTo(param1,"Prizeother",this._clip.revealOtherClip.center);
            this.attachDynamicBitmapTo(param1,"Prizegolden",this._clip.winClip.center);
         }
         this.showUp();
      }
      
      public function setText(param1:String, param2:Object) : void
      {
         this._prizeAmount = param2[CurrencyManager.TYPE_COINS];
         var _loc3_:String = Utils.commafy(this._prizeAmount);
         this._prizeShardsAmount = param2[CurrencyManager.TYPE_SHARDS];
         var _loc4_:String = Utils.commafy(this._prizeShardsAmount);
         this.centerCoinText(this._clip.revealSelectedClip,_loc3_,_loc4_);
         this.centerCoinText(this._clip.revealOtherClip,_loc3_,_loc4_);
         this.centerCoinText(this._clip.winClip,_loc3_,_loc4_);
      }
      
      public function showUp() : void
      {
         this._clip.gotoAndStop("up");
      }
      
      public function showOver() : void
      {
         this._clip.gotoAndPlay("over");
      }
      
      public function showOut() : void
      {
         this._clip.gotoAndPlay("out");
      }
      
      public function showRevealOther(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(this._btn && this._btn.isActive())
         {
            this._btn.deactivate();
            _loc2_ = "";
            if(param1)
            {
               _loc2_ = "Win";
            }
            this._clip.gotoAndPlay("revealOther" + _loc2_);
         }
      }
      
      public function tweenHideSelf(param1:Boolean, param2:int) : void
      {
         Tweener.removeTweens(this._clip);
         var _loc3_:Number = 3;
         var _loc4_:Function = Utils.emptyMethod;
         if(param1)
         {
            _loc3_ += 2;
            if(this._app)
            {
               _loc4_ = (this._app.ui as MainWidgetGame).game.dynamicGem.showOutro;
            }
            Tweener.addTween(this._clip,{
               "time":2.5,
               "onComplete":this.showCoinAnimation
            });
         }
         else
         {
            _loc3_ += param2 * 0.05;
         }
         Tweener.addTween(this._clip,{
            "time":0.2,
            "scaleX":1.13,
            "scaleY":1.13,
            "delay":_loc3_
         });
         Tweener.addTween(this._clip,{
            "time":0.2,
            "scaleX":0.01,
            "scaleY":0.01,
            "alpha":0,
            "delay":_loc3_ + 0.2,
            "onComplete":_loc4_
         });
      }
      
      private function attachDynamicBitmapTo(param1:String, param2:String, param3:MovieClip) : void
      {
         var _loc4_:Bitmap;
         (_loc4_ = new Bitmap()).bitmapData = DynamicRGInterface.getImage(param1,param2).bitmapData.clone();
         _loc4_.smoothing = true;
         _loc4_.x = -_loc4_.width / 2;
         _loc4_.y = -_loc4_.height / 2;
         param3.addChild(_loc4_);
      }
      
      private function showCoinAnimation() : void
      {
         this.awardCoins(this._prizeAmount,5,0.3);
      }
      
      private function awardCoins(param1:Number, param2:int, param3:Number) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc4_:int = Math.floor(param1 / param2);
         var _loc5_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            _loc5_.push(_loc4_);
            _loc6_++;
         }
         _loc5_[_loc5_.length - 1] += param1 % _loc4_;
         if(this._prizeShardsAmount > 0)
         {
            _loc7_ = Math.floor(this._prizeShardsAmount / param2);
            _loc8_ = new Array();
            _loc6_ = 0;
            while(_loc6_ < param2)
            {
               _loc8_.push(_loc7_);
               _loc6_++;
            }
            _loc8_[_loc8_.length - 1] += this._prizeShardsAmount % _loc7_;
         }
         if(!this._app)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            Tweener.addTween(this._clip,{
               "time":param3 * _loc6_,
               "onComplete":this._app.logic.coinTokenLogic.spawnCoinOnClip,
               "onCompleteParams":[_loc5_[_loc6_],this._clip.coinStartReferenceClip]
            });
            if(this._prizeShardsAmount > 0)
            {
               Tweener.addTween(this._clip,{
                  "time":param3 * _loc6_,
                  "onComplete":this._app.sessionData.userData.currencyManager.spawnCurrencyOnClip,
                  "onCompleteParams":[_loc8_[_loc6_],this._clip.coinStartReferenceClip,CurrencyManager.TYPE_SHARDS]
               });
            }
            _loc6_++;
         }
      }
      
      private function onAdded(param1:Event) : void
      {
         if(this._clip.btn != null)
         {
            this._clip.removeEventListener(Event.ENTER_FRAME,this.onAdded);
            this._btn = new GenericButtonClip(this._app,this._clip.btn);
            this._btn.setRollOver(this.showOver);
            this._btn.setRollOut(this.showOut);
            this._btn.setPress(this.prizePress);
            this._btn.setShowGraphics(false);
            this._btn.setStopPropagation(true);
            this._btn.activate();
         }
      }
      
      private function prizePress() : void
      {
         this.setText(DynamicRareGemWidget.getWinningPrizeType(),DynamicRareGemWidget.getPrizeAmount(DynamicRareGemWidget.getWinningPrizeIndex()));
         this.showRevealSelected();
         this._controller.prizePress(this._btnIndex);
         this._controller.showRain(this._rareGemID);
      }
      
      public function monkeyPrizePress() : void
      {
      }
      
      private function showRevealSelected() : void
      {
         if(this._btn)
         {
            this._btn.deactivate();
         }
         var _loc1_:String = "";
         if(DynamicRareGemWidget.isGrandPrize())
         {
            _loc1_ = "Win";
         }
         this._clip.gotoAndPlay("revealSelected" + _loc1_);
      }
      
      private function centerCoinText(param1:MovieClip, param2:String, param3:String) : void
      {
         param1.txtPrize.htmlText = param2;
         param1.txtlightseed.htmlText = param3;
         var _loc4_:Number = param1.coinClip.width + param1.txtPrize.textWidth * param1.txtPrize.scaleX;
         param1.coinClip.x = param1.centerClip.x - _loc4_ / 2 + param1.coinClip.width / 2 - 3;
         param1.txtPrize.x = param1.coinClip.x + param1.coinClip.width / 2;
         _loc4_ = param1.lightseedClip.width + param1.txtlightseed.textWidth * param1.txtlightseed.scaleX;
         param1.lightseedClip.x = param1.centerClip.x - _loc4_ / 2 + param1.lightseedClip.width / 2 - 3;
         param1.txtlightseed.x = param1.lightseedClip.x + param1.lightseedClip.width / 2;
      }
   }
}
