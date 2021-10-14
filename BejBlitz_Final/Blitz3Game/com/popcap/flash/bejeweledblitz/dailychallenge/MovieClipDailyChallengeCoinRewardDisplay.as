package com.popcap.flash.bejeweledblitz.dailychallenge
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.IDailyChallengeRewardDisplay;
   import flash.display.MovieClip;
   
   public class MovieClipDailyChallengeCoinRewardDisplay implements IDailyChallengeRewardDisplay
   {
      
      public static const TINY_COIN_LABEL:String = "coins_1";
      
      public static const SMALL_COIN_LABEL:String = "coins_2";
      
      public static const MEDIUM_COIN_LABEL:String = "coins_3";
      
      public static const LARGE_COIN_LABEL:String = "coins_4";
      
      public static const _coinThresholds:Vector.<DailyChallengeCoinThreshold> = new <DailyChallengeCoinThreshold>[new DailyChallengeCoinThreshold(TINY_COIN_LABEL,0,5000),new DailyChallengeCoinThreshold(SMALL_COIN_LABEL,5000,10000),new DailyChallengeCoinThreshold(MEDIUM_COIN_LABEL,10000,20000),new DailyChallengeCoinThreshold(LARGE_COIN_LABEL,20000,int.MAX_VALUE)];
       
      
      private var _textContainer:MovieClip;
      
      private var _imageContainer:MovieClip;
      
      private var _coinAmount:int;
      
      public function MovieClipDailyChallengeCoinRewardDisplay(param1:MovieClip, param2:MovieClip, param3:int)
      {
         super();
         this._textContainer = param1;
         this._imageContainer = param2;
         this._coinAmount = param3;
      }
      
      public function Set() : void
      {
         this._textContainer.rewardT.text = Utils.commafy(this._coinAmount);
         this._imageContainer.gotoAndStop(this.selectLabel());
      }
      
      private function selectLabel() : String
      {
         var _loc2_:DailyChallengeCoinThreshold = null;
         var _loc1_:String = TINY_COIN_LABEL;
         for each(_loc2_ in _coinThresholds)
         {
            if(_loc2_.inRange(this._coinAmount))
            {
               _loc1_ = _loc2_.label;
               break;
            }
         }
         return _loc1_;
      }
   }
}
