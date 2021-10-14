package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRewardTierInfo;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentRewardType;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.games.blitz3.leaderboard.RewardViewListBox;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TournamentInfoRewardListBox extends RewardViewListBox
   {
      
      protected static const _MAX_RELOAD_SECONDS:Number = 5;
      
      protected static const _RELOAD_TIME:Number = _MAX_RELOAD_SECONDS * 1000;
      
      protected static var _scoreStartY:Number;
       
      
      private var _app:Blitz3Game;
      
      private var _isDestroyed:Boolean = false;
      
      private var _tourRewardInfo:TournamentRewardTierInfo;
      
      private var _rewardImg:Bitmap;
      
      private var _rankRangeText:TextField;
      
      public function TournamentInfoRewardListBox(param1:Blitz3Game, param2:TournamentRewardTierInfo)
      {
         super();
         this._app = param1;
         this._tourRewardInfo = param2;
         this._rewardImg = new Bitmap();
         this._rewardImg.scaleX = 100 / 121;
         this._rewardImg.scaleY = 100 / 121;
         this._rewardImg.smoothing = true;
         this.setupEntry();
      }
      
      private function setupEntry() : void
      {
         var _loc3_:Vector.<TournamentRewardType> = null;
         var _loc5_:int = 0;
         var _loc6_:TournamentRewardType = null;
         var _loc7_:RGLogic = null;
         var _loc8_:Number = NaN;
         var _loc9_:RareGemWidget = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:MovieClip = null;
         this._tourRewardInfo.copyBitmapDataTo(this._rewardImg);
         this._rewardImg.cacheAsBitmap = true;
         Utils.removeAllChildrenFrom(this.ChestBoxRankContainer.ChestPlaceholder);
         this.ChestBoxRankContainer.ChestPlaceholder.addChild(this._rewardImg);
         this.RGContainer.visible = false;
         var _loc1_:String = "";
         if(this._tourRewardInfo.minRank == this._tourRewardInfo.maxRank)
         {
            _loc1_ = Utils.getRankText(this._tourRewardInfo.minRank);
         }
         else
         {
            _loc1_ = Utils.getRankText(this._tourRewardInfo.minRank) + "-" + Utils.getRankText(this._tourRewardInfo.maxRank);
         }
         this.ChestBoxRankContainer.txtRankNormal.text = _loc1_;
         var _loc2_:int = 0;
         _loc3_ = this._tourRewardInfo.rewards;
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            if(this._app.sessionData.userData.currencyManager.IsTypeCurrency(_loc6_.Type))
            {
               _loc2_++;
            }
            else
            {
               Utils.removeAllChildrenFrom(this.RGContainer.Raregemplaceholder);
               if(this._app.sessionData.rareGemManager.GetCatalog()[_loc6_.Data] != null)
               {
                  _loc7_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc6_.Data);
                  _loc8_ = 1;
                  (_loc9_ = new RareGemWidget(this._app,new DynamicRareGemLoader(this._app),"small",0,0,_loc8_,_loc8_,false)).reset(_loc7_);
                  this.RGContainer.Raregemplaceholder.addChild(_loc9_);
                  this.RGContainer.Rgnumber.text = _loc6_.Amount.toString();
                  this.RGContainer.visible = true;
                  this.RGContainer.x = 260;
               }
            }
            _loc5_++;
         }
         if(_loc2_ <= 2)
         {
            _loc10_ = 5;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc11_ = _loc3_[_loc5_].Type;
               if(this._app.sessionData.userData.currencyManager.IsTypeCurrency(_loc11_) && _loc10_ < 7)
               {
                  Utils.removeAllChildrenFrom(this["CoinPlaceholder" + _loc10_]);
                  (_loc12_ = CurrencyManager.getImageByType(_loc11_,false)).x = 0;
                  _loc12_.y = 0;
                  _loc12_.smoothing = true;
                  this["CoinPlaceholder" + _loc10_].addChild(_loc12_);
                  this["CoinTxt" + _loc10_].text = Utils.formatNumberToBJBNumberString(_loc3_[_loc5_].Amount);
                  _loc10_++;
               }
               _loc5_++;
            }
            if(this.RGContainer.visible && _loc2_ < 2)
            {
               this.RGContainer.x = 180;
            }
         }
         else
         {
            _loc10_ = 1;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc11_ = _loc3_[_loc5_].Type;
               if(this._app.sessionData.userData.currencyManager.IsTypeCurrency(_loc11_) && _loc10_ < 5)
               {
                  Utils.removeAllChildrenFrom(this["CoinPlaceholder" + _loc10_]);
                  (_loc12_ = CurrencyManager.getImageByType(_loc11_,false)).x = 0;
                  _loc12_.y = 0;
                  _loc12_.smoothing = true;
                  this["CoinPlaceholder" + _loc10_].addChild(_loc12_);
                  this["CoinTxt" + _loc10_].text = Utils.formatNumberToBJBNumberString(_loc3_[_loc5_].Amount);
                  _loc10_++;
               }
               _loc5_++;
            }
         }
      }
      
      public function update() : void
      {
      }
   }
}
