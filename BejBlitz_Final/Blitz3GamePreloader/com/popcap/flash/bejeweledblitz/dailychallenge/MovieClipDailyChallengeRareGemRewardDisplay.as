package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemImageWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplay;
   import flash.display.MovieClip;
   
   public class MovieClipDailyChallengeRareGemRewardDisplay implements IDailyChallengeRewardDisplay
   {
       
      
      private var _app:Blitz3App;
      
      private var _textContainer:MovieClip;
      
      private var _imageContainer:MovieClip;
      
      private var _gemId:String;
      
      private var _rareGemManager:RareGemManager;
      
      private var _rareGemWidget:RareGemImageWidget;
      
      private var _loader:DynamicRareGemImageLoader;
      
      public function MovieClipDailyChallengeRareGemRewardDisplay(param1:Blitz3App, param2:MovieClip, param3:MovieClip, param4:String, param5:RareGemManager, param6:RareGemImageWidget, param7:DynamicRareGemImageLoader)
      {
         super();
         this._app = param1;
         this._textContainer = param2;
         this._imageContainer = param3;
         this._gemId = param4;
         this._rareGemManager = param5;
         this._rareGemWidget = param6;
         this._loader = param7;
         this._imageContainer.addChild(this._rareGemWidget);
      }
      
      public function Set() : void
      {
         if(this._textContainer != null)
         {
            this._textContainer.gotoAndStop("rareGem");
         }
         this._imageContainer.gotoAndPlay("loading");
         if(DynamicRareGemWidget.isValidGemId(this._gemId))
         {
            this._loader.load(this._gemId,function():void
            {
            },this.setVisualState);
         }
         else
         {
            this.setVisualState();
         }
      }
      
      private function setVisualState() : void
      {
         if(this._textContainer != null)
         {
            this._textContainer.rewardT.text = this._rareGemManager.GetTaglessRareGemNameWithTitleCasing(this._gemId);
         }
         this._rareGemWidget.reset(this._app.logic.rareGemsLogic.GetRareGemByStringID(this._gemId));
         this._imageContainer.gotoAndStop("none");
      }
   }
}
