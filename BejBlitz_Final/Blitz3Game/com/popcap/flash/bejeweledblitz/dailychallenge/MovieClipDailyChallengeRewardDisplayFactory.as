package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemImageWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplay;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplayFactory;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class MovieClipDailyChallengeRewardDisplayFactory implements IDailyChallengeRewardDisplayFactory
   {
       
      
      private var _app:Blitz3App;
      
      private var _rareGemManager:RareGemManager;
      
      private var _textContainerMC:MovieClip;
      
      private var _imageContainerMC:MovieClip;
      
      public function MovieClipDailyChallengeRewardDisplayFactory(param1:Blitz3App, param2:RareGemManager, param3:MovieClip, param4:MovieClip)
      {
         super();
         this._app = param1;
         this._rareGemManager = param2;
         this._textContainerMC = param3;
         this._imageContainerMC = param4;
      }
      
      public function CreateCoinRewardDisplay(param1:int) : IDailyChallengeRewardDisplay
      {
         this.clearPreviousRareGemWidgets();
         return new MovieClipDailyChallengeCoinRewardDisplay(this._textContainerMC,this._imageContainerMC,param1);
      }
      
      public function CreateRareGemRewardDisplay(param1:String) : IDailyChallengeRewardDisplay
      {
         this.clearPreviousRareGemWidgets();
         var _loc2_:DynamicRareGemImageLoader = new DynamicRareGemImageLoader(this._app);
         var _loc3_:RareGemImageWidget = new RareGemImageWidget(this._app,_loc2_,"small",50,70,1,1);
         return new MovieClipDailyChallengeRareGemRewardDisplay(this._app,this._textContainerMC,this._imageContainerMC,param1,this._rareGemManager,_loc3_,_loc2_);
      }
      
      private function clearPreviousRareGemWidgets() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = this._imageContainerMC.numChildren - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this._imageContainerMC.getChildAt(_loc2_);
            if(this._imageContainerMC.getChildAt(_loc2_) is RareGemImageWidget)
            {
               this._imageContainerMC.removeChildAt(_loc2_);
            }
            _loc2_--;
         }
      }
   }
}
