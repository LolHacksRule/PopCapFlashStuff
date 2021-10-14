package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class RareGemTokenPrizeSelector extends TokenRareGemPrizeSelectorClip implements IPrizeSelector
   {
       
      
      private var _app:Blitz3App;
      
      private var _rareGemID:String = "";
      
      private var _prizeSelectorButton:PrizeSelectorButton;
      
      private var _isEnded:Boolean = false;
      
      public function RareGemTokenPrizeSelector(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function isEnded() : Boolean
      {
         return this._isEnded;
      }
      
      public function showMe(param1:String) : void
      {
      }
      
      public function prizePress(param1:uint) : void
      {
         this._prizeSelectorButton.tweenHideSelf(true,0);
      }
      
      public function showRain(param1:String) : void
      {
         this._rareGemID = param1;
         if(DynamicRareGemWidget.isGrandPrize())
         {
            this.rainClip.gotoAndStop("dynamicWin");
            this.addEventListener(Event.ENTER_FRAME,this.onEnterRain);
         }
         else
         {
            this.rainClip.gotoAndStop("dynamic");
            this.addEventListener(Event.ENTER_FRAME,this.onEnterRain);
         }
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
