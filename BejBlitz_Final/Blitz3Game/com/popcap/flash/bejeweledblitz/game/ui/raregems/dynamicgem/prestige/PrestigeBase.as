package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.PrizeSelector;
   import flash.display.MovieClip;
   
   public class PrestigeBase
   {
       
      
      protected var _app:Blitz3App;
      
      private var _prizeTextUpdated:Boolean = false;
      
      private var _timePrizeTextUpdated:Boolean = false;
      
      public function PrestigeBase(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function getGenericPrizeSelector(param1:String) : MovieClip
      {
         var _loc2_:PrizeSelector = null;
         _loc2_ = new PrizeSelector(this._app);
         _loc2_.x = (this._app.ui as MainWidgetGame).game.NinePickerAlignment.x;
         _loc2_.y = (this._app.ui as MainWidgetGame).game.NinePickerAlignment.y;
         _loc2_.showMe(param1);
         return _loc2_;
      }
      
      public function forceOutro() : Boolean
      {
         return false;
      }
      
      public function prizeTextUpdated() : Boolean
      {
         return this._prizeTextUpdated;
      }
      
      public function setPrizeTextUpdated() : void
      {
         this._prizeTextUpdated = true;
      }
      
      public function timePrizeTextUpdated() : Boolean
      {
         return this._timePrizeTextUpdated;
      }
      
      public function setTimePrizeTextUpdated() : void
      {
         this._timePrizeTextUpdated = true;
      }
      
      public function onShowPrizesFrame(param1:String) : void
      {
      }
   }
}
