package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PrizeSelector extends PrizeSelectorClip implements IPrizeSelector
   {
      
      private static const _MAX_PRIZES:uint = 9;
       
      
      private var _app:Blitz3App;
      
      private var _rareGemID:String = "";
      
      private var _btnArray:Vector.<PrizeSelectorButton>;
      
      private var _btnCover:GenericButtonClip;
      
      private var _isEnded:Boolean = false;
      
      public function PrizeSelector(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._btnArray = new Vector.<PrizeSelectorButton>();
      }
      
      public function isEnded() : Boolean
      {
         return this._isEnded;
      }
      
      public function showMe(param1:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc5_:PrizeSelectorButton = null;
         this._rareGemID = param1;
         Utils.removeAllChildrenFrom(this.txtClip.center);
         this.txtClip.gotoAndStop("dynamic");
         DynamicRGInterface.attachMovieClip(param1,"Prizetext",this.txtClip.center);
         this.gotoAndPlay("on");
         var _loc4_:uint = 0;
         while(_loc4_ < _MAX_PRIZES)
         {
            _loc3_ = this.getChildByName("prize" + _loc4_) as MovieClip;
            _loc5_ = new PrizeSelectorButton(this._app,this,_loc3_);
            this._btnArray.push(_loc5_);
            if(_loc4_ >= DynamicRareGemWidget.getPrizesLength())
            {
               _loc5_.hideMe();
            }
            else
            {
               _loc5_.init(this._rareGemID,_loc4_,false);
            }
            _loc4_++;
         }
      }
      
      public function prizePress(param1:uint) : void
      {
         var _loc7_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc2_:uint = DynamicRareGemWidget.getWinningPrizeIndex();
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < DynamicRareGemWidget.getPrizesLength())
         {
            if(_loc4_ != _loc2_)
            {
               _loc3_.push(_loc4_);
            }
            _loc4_++;
         }
         Utils.randomizeArray(_loc3_);
         var _loc5_:uint = DynamicRareGemWidget.getGrandPrizeIndex();
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(_loc8_ < _MAX_PRIZES)
         {
            _loc7_ = _loc3_[_loc6_];
            if(_loc8_ != param1)
            {
               _loc9_ = DynamicRareGemWidget.getPrizeType(_loc7_);
               _loc10_ = DynamicRareGemWidget.getPrizeAmount(_loc7_);
               this._btnArray[_loc8_].setText(_loc9_,_loc10_);
               this._btnArray[_loc8_].showRevealOther(_loc7_ == _loc5_);
               _loc6_++;
               this._btnArray[_loc8_].tweenHideSelf(false,_loc8_);
            }
            _loc8_++;
         }
         this._btnArray[param1].tweenHideSelf(true,param1);
      }
      
      public function monkeyPrizePress(param1:uint) : void
      {
      }
      
      public function showRain(param1:String) : void
      {
         param1 = Utils.getFirstUppercase(param1);
         DynamicRareGemSound.play(param1,DynamicRareGemSound.PRIZEEND_ID);
         if(DynamicRareGemWidget.isGrandPrize())
         {
            DynamicRareGemSound.play(param1,DynamicRareGemSound.PRIZEGRANDSELECT_ID);
            this.rainClip.gotoAndStop("dynamicWin");
         }
         else
         {
            DynamicRareGemSound.play(param1,DynamicRareGemSound.PRIZESELECT_ID);
            this.rainClip.gotoAndStop("dynamic");
         }
         this.addEventListener(Event.ENTER_FRAME,this.onEnterRain,false,0,true);
         this.gotoAndPlay("rain");
      }
      
      public function hideRain() : void
      {
         this.rainClip.gotoAndStop("off");
      }
      
      private function onEnterRain(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Bitmap = null;
         if(this.rainClip.dynamic13 != null && this.rainClip.dynamic13.container != null && this.rainClip.dynamic13.container.container != null && this.rainClip.dynamic13.container.container.center != null)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterRain);
            _loc2_ = 0;
            while(_loc2_ <= 13)
            {
               _loc3_ = this.rainClip["dynamic" + _loc2_].container.container.center;
               Utils.removeAllChildrenFrom(_loc3_);
               (_loc4_ = new Bitmap()).bitmapData = DynamicRGInterface.getImage(this._rareGemID,"Gameicon").bitmapData.clone();
               _loc4_.smoothing = true;
               _loc4_.x = -_loc4_.width / 2;
               _loc4_.y = -_loc4_.height / 2;
               _loc3_.addChild(_loc4_);
               _loc2_++;
            }
         }
      }
   }
}
